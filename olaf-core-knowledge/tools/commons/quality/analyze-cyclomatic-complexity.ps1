<#
.SYNOPSIS
    Analyzes cyclomatic complexity (CC) for source code files.

.DESCRIPTION
    This script analyzes source code files to calculate cyclomatic complexity (CC),
    which measures the number of linearly independent paths through a program's source code.
    Higher CC values indicate more complex code that may be harder to understand, test, and maintain.

.PARAMETER RepoPath
    Path to the repository to analyze. Defaults to the current directory.

.PARAMETER OutputFile
    Path to the output markdown file. Defaults to cyclomatic-complexity.md in the ads/findings directory.

.PARAMETER FileExtensions
    Array of file extensions to analyze (without the dot). Defaults to common code file extensions.

.PARAMETER ExcludePatterns
    Array of patterns to exclude from analysis (e.g., "node_modules", "dist").

.PARAMETER ComplexityThreshold
    Threshold for highlighting high-complexity functions. Functions with CC higher than this value
    will be flagged in the report. Defaults to 10.

.PARAMETER MaxFiles
    Maximum number of files to analyze. Defaults to 500. Set to 0 for unlimited.

.PARAMETER FilesToAnalyzeFile
    Path to a text file containing a list of files to analyze (one file path per line).
    If provided, only these files will be analyzed instead of scanning the repository.

.EXAMPLE
    ./analyze-cyclomatic-complexity.ps1 -RepoPath "C:\path\to\repo" -ComplexityThreshold 15

.EXAMPLE
    ./analyze-cyclomatic-complexity.ps1 -FilesToAnalyzeFile "files-to-be-analyzed.txt"

.NOTES
    This script performs a simplified calculation of cyclomatic complexity.
    For more accurate results, consider using language-specific static analysis tools.
#>

param (
    [string]$RepoPath = (Get-Location).Path,
    [string]$OutputFile,
    [string]$FilesToAnalyzeFile,
    [string[]]$FileExtensions = @("cs", "java", "js", "ts", "py", "rb", "php", "go", "cpp", "c", "h", "hpp"),
    [string[]]$ExcludePatterns = @("node_modules", "dist", "bin", "obj", "build", "target", "vendor", "packages"),
    [int]$ComplexityThreshold = 10,
    [int]$MaxFiles = 500
)

if (-not $OutputFile) {
    $OutputFile = Join-Path $projectRoot "cyclomatic-complexity.md"
}
# If the output path is a directory, append the default filename
if ((Test-Path $OutputFile) -and (Get-Item $OutputFile).PSIsContainer) {
    $OutputFile = Join-Path $OutputFile "cyclomatic-complexity.md"
}

# Check for default files-to-be-analyzed.txt if no FilesToAnalyzeFile specified
if (-not $FilesToAnalyzeFile) {
    $defaultFilesListPath = Join-Path $RepoPath "files-to-be-analyzed.txt"
    if (Test-Path $defaultFilesListPath) {
        $FilesToAnalyzeFile = $defaultFilesListPath
        Write-Host "Found default files list: $defaultFilesListPath" -ForegroundColor Green
    }
}

# ASCII art banner
function Show-Banner {
    Write-Host "
  _____       _____ _                        _   _      
 / ____|     / ____| |                      | | (_)     
| |   _   _ | |    | | ___  _ __ ___   __ _ | |_ _  ___ 
| |  | | | || |    | |/ _ \| '_ \` _ \ / _\` || __| |/ __|
| |__| |_| || |____| | (_) | | | | | | (_| || |_| | (__ 
 \___|\__, | \_____|_|\___/|_| |_| |_|\__,_| \__|_|\___|
       __/ |                                           
      |___/                                            
" -ForegroundColor Cyan
    Write-Host "Cyclomatic Complexity Analyzer" -ForegroundColor Cyan
    Write-Host "============================" -ForegroundColor Cyan
}

# Function to get project root directory (looks for .git)
function Get-ProjectRoot {
    param ([string]$Path)
    $currentPath = (Resolve-Path $Path).Path
    while ($currentPath -ne $null -and $currentPath -ne "") {
        if (Test-Path (Join-Path $currentPath ".git")) {
            return $currentPath
        }
        $parentPath = Split-Path $currentPath -Parent
        if ($parentPath -eq $currentPath) { # Reached root of the drive
            return $null
        }
        $currentPath = $parentPath
    }
    return $null
}

# Function to analyze a file for cyclomatic complexity
function Get-CyclomaticComplexity {
    param (
        [string]$FilePath,
        [string]$Language
    )
    
    # Try to read the file as text with error handling
    $content = $null
    try {
        $content = Get-Content -Path $FilePath -ErrorAction Stop
    } catch {
        Write-Warning "Could not read file $FilePath as text. It might be a binary file: $_"
        return @(
            [PSCustomObject]@{
                Name = "File_Level"
                StartLine = 1
                EndLine = 1
                LineCount = 0
                Complexity = 0
                ComplexityDensity = 0
            }
        )
    }
    
    # Skip empty files
    if ($null -eq $content -or $content.Count -eq 0) {
        Write-Warning "File $FilePath is empty or could not be read."
        return @(
            [PSCustomObject]@{
                Name = "File_Level"
                StartLine = 1
                EndLine = 1
                LineCount = 0
                Complexity = 0
                ComplexityDensity = 0
            }
        )
    }
    
    # Store functions/methods and their complexity
    $functions = @()
    
    # Pattern to identify function/method declarations (simplistic)
    $functionPatterns = @{
        "cs" = '(public|private|protected|internal|static)?\s+\w+\s+(\w+)\s*\([^)]*\)\s*(?:{|\n*{)'
        "java" = '(public|private|protected|static|final)?\s+\w+\s+(\w+)\s*\([^)]*\)\s*(?:{|\n*{)'
        "js" = '(function\s+(\w+)|(\w+)\s*[:=]\s*function|\(.*\)\s*=>\s*{|(\w+)\s*\(.*\)\s*{)'
        "ts" = '(?:(?:public|private|protected|static|async|export)\s+)*(?:\w+\s+)?(\w+)\s*\([^)]*\)(?:\s*:\s*[\w<>|\[\]\s]+)?\s*\{'
        "py" = 'def\s+(\w+)\s*\('
        "default" = '(?:function\s+)?(\w+)\s*\([^)]*\)\s*\{'
    }
    
    # Pattern to identify conditional statements and loops
    $complexityPatterns = @(
        'if\s*\(',
        'else\s+if',
        'else',
        'switch\s*\(',
        'case\s+',
        'for\s*\(',
        'foreach\s*\(',
        'while\s*\(',
        'do\s*{',
        '\?\s*',
        '\|\|',
        '&&',
        'except',
        'catch',
        'finally'
    )
    
    # Choose the appropriate function pattern
    $functionPattern = $functionPatterns["default"]
    if ($functionPatterns.ContainsKey($Language)) {
        $functionPattern = $functionPatterns[$Language]
    }
    
    # Process file content
    $currentFunction = $null
    $bracketCount = 0
    $currentLines = @()
    $inFunction = $false
    
    for ($i = 0; $i -lt $content.Count; $i++) {
        $line = $content[$i]
        # Check if this line contains a function declaration
        if (-not $inFunction) {
            $functionMatch = [regex]::Match($line, $functionPattern)
            if ($functionMatch.Success) {
                # Extract function name from match groups (get the last non-empty capture group)
                $functionName = $null
                for ($g = $functionMatch.Groups.Count - 1; $g -ge 1; $g--) {
                    if ($functionMatch.Groups[$g].Value -ne "" -and $functionMatch.Groups[$g].Value.Trim() -ne "") {
                        $candidateName = $functionMatch.Groups[$g].Value.Trim()
                        # Skip modifiers and keywords
                        if ($candidateName -notmatch '^(public|private|protected|internal|static|final|function|def|async|export)$') {
                            $functionName = $candidateName
                            break
                        }
                    }
                }
                
                if (-not $functionName) {
                    $functionName = "Anonymous_Function_Line_$($i+1)"
                }
                
                $currentFunction = @{
                    Name = $functionName
                    StartLine = $i + 1
                    EndLine = 0
                    Lines = @()
                    Complexity = 1  # Base complexity is 1
                }
                
                $inFunction = $true
                $bracketCount = 0
                $currentLines = @()
            }
        }
        
        if ($inFunction) {
            $currentLines += $line
            
            # Count opening and closing brackets to track function boundaries
            $openBrackets = [regex]::Matches($line, '{').Count
            $closeBrackets = [regex]::Matches($line, '}').Count
            $bracketCount += $openBrackets - $closeBrackets
            
            # Analyze complexity for this line
            foreach ($pattern in $complexityPatterns) {
                $matches = [regex]::Matches($line, $pattern)
                $currentFunction.Complexity += $matches.Count
            }
            
            # Check if function has ended
            if ($bracketCount -eq 0 -and $line -match '}') {
                $currentFunction.EndLine = $i + 1
                $currentFunction.Lines = $currentLines
                $functions += $currentFunction
                $inFunction = $false
                $currentFunction = $null
            }
        }
    }
    
    # Handle special case for Python and other indentation-based languages
    if ($Language -eq "py") {
        # Reset and use a different approach
        $functions = @()
        $indentStack = @()
        $currentFunction = $null
        
        for ($i = 0; $i -lt $content.Count; $i++) {
            $line = $content[$i]
            
            # Skip empty lines and comments
            if ([string]::IsNullOrWhiteSpace($line) -or $line.Trim().StartsWith('#')) {
                continue
            }
            
            # Calculate current indentation level
            $indent = 0
            if ($line -match '^\s+') {
                $indent = $Matches[0].Length
            }
            
            # Check for function definition
            if ($line -match 'def\s+(\w+)\s*\(') {
                $functionName = $Matches[1]
                
                $currentFunction = @{
                    Name = $functionName
                    StartLine = $i + 1
                    EndLine = 0
                    Lines = @()
                    Complexity = 1  # Base complexity is 1
                    IndentLevel = $indent
                }
                
                $indentStack += $currentFunction
            }
            
            # Check if we're in a function
            if ($indentStack.Count -gt 0) {
                $currentFunction = $indentStack[-1]
                $currentFunction.Lines += $line
                
                # Calculate complexity
                if ($line -match '^\s*(if|elif|else|for|while|except|finally)\b') {
                    $currentFunction.Complexity++
                }
                
                # Check for logical operators that increase complexity
                $andCount = [regex]::Matches($line, '\band\b').Count
                $orCount = [regex]::Matches($line, '\bor\b').Count
                $currentFunction.Complexity += $andCount + $orCount
                
                # Check if function has ended (next line has same or less indentation)
                if ($i + 1 -lt $content.Count) {
                    $nextLine = $content[$i + 1]
                    if ([string]::IsNullOrWhiteSpace($nextLine) -or $nextLine.Trim().StartsWith('#')) {
                        # Skip empty lines and comments for indentation check
                        continue
                    }
                    
                    $nextIndent = 0
                    if ($nextLine -match '^\s+') {
                        $nextIndent = $Matches[0].Length
                    }
                    if ($nextIndent -le $currentFunction.IndentLevel -and -not [string]::IsNullOrWhiteSpace($nextLine)) {
                        $currentFunction.EndLine = $i + 1
                        $functions += $currentFunction
                        $indentStack = $indentStack[0..($indentStack.Count - 2)]
                    }
                } else {
                    # End of file
                    $currentFunction.EndLine = $i + 1
                    $functions += $currentFunction
                }
            }
        }
    }
    
    # If no functions were found, return file-level complexity
    if ($functions.Count -eq 0) {
        $fileComplexity = 1  # Base complexity
        
        foreach ($line in $content) {
            foreach ($pattern in $complexityPatterns) {
                $matches = [regex]::Matches($line, $pattern)
                $fileComplexity += $matches.Count
            }
        }
        
        return @(
            [PSCustomObject]@{
                Name = "File_Level"
                StartLine = 1
                EndLine = $content.Count
                LineCount = $content.Count
                Complexity = $fileComplexity
                ComplexityDensity = [Math]::Round($fileComplexity / $content.Count, 3)
            }
        )
    }
    
    # Convert to output format
    $result = @()
    foreach ($func in $functions) {
        $lineCount = $func.EndLine - $func.StartLine + 1
        $result += [PSCustomObject]@{
            Name = $func.Name
            StartLine = $func.StartLine
            EndLine = $func.EndLine
            LineCount = $lineCount
            Complexity = $func.Complexity
            ComplexityDensity = [Math]::Round($func.Complexity / $lineCount, 3)
        }
    }
    
    return $result
}

# Main script execution
$ErrorActionPreference = "Stop"

try {
    Show-Banner
    
    # Determine project root and output file
    $projectRoot = Get-ProjectRoot -Path $RepoPath
    if (-not $projectRoot) {
        $projectRoot = $RepoPath
        Write-Warning "Could not find .git directory, using specified path as project root: $RepoPath"
    } else {
        Write-Host "Project root found: $projectRoot"
    }
    
    # Set default output file if not provided
    if (-not $OutputFile) {
        $OutputFile = Join-Path $projectRoot "cyclomatic-complexity.md"
    }
    
    # Ensure output directory exists
    $outputDir = Split-Path -Parent $OutputFile
    if (-not (Test-Path $outputDir)) {
        New-Item -ItemType Directory -Path $outputDir -Force | Out-Null
        Write-Host "Created output directory: $outputDir"
    }
    
    # Get all files to analyze
    Write-Host "Finding files to analyze..." -ForegroundColor Green
    $filesToAnalyze = @()
    $csvFile = Join-Path $projectRoot "files-to-be-analyzed.txt"
    if (Test-Path $csvFile) {
        Write-Host "Reading files from CSV: $csvFile" -ForegroundColor Yellow
        $csvLines = Get-Content $csvFile
        if ($csvLines.Count -gt 1) {
            foreach ($line in $csvLines[1..($csvLines.Count-1)]) {
                $parts = $line -split ','
                if ($parts.Count -ge 2) {
                    $filePath = $parts[1]
                    $fileName = $parts[0]
                    $fullPath = Join-Path $projectRoot $filePath
                    $fullFile = Join-Path $fullPath $fileName
                    if (Test-Path $fullFile) {
                        $filesToAnalyze += Get-Item $fullFile
                    } else {
                        Write-Warning "File not found: $fullFile"
                    }
                }
            }
            Write-Host "Loaded $($filesToAnalyze.Count) files from CSV." -ForegroundColor Green
        } else {
            Write-Warning "CSV file is empty or only contains header."
        }
    } else {
        # Fallback: scan repository for files matching extensions
        Write-Host "No CSV file found. Scanning repository for files matching extensions..." -ForegroundColor Yellow
        foreach ($ext in $FileExtensions) {
            $files = Get-ChildItem -Path $projectRoot -Filter "*.$ext" -Recurse -File
            foreach ($file in $files) {
                $shouldExclude = $false
                foreach ($pattern in $ExcludePatterns) {
                    if ($file.FullName -like "*$pattern*") {
                        $shouldExclude = $true
                        break
                    }
                }
                if (-not $shouldExclude) {
                    $filesToAnalyze += $file
                }
            }
        }
    }
    
    Write-Host "Found $($filesToAnalyze.Count) files to analyze." -ForegroundColor Green
    
    # Analyze files
    $results = @()
    $fileCount = 0
    $totalFiles = $filesToAnalyze.Count
    
    foreach ($file in $filesToAnalyze) {
        $fileCount++
        $percentComplete = [Math]::Round(($fileCount / $totalFiles) * 100)
        Write-Progress -Activity "Analyzing Files" -Status "$fileCount of $totalFiles ($percentComplete%)" -PercentComplete $percentComplete
        
        $ext = $file.Extension.TrimStart('.')
        $functionResults = Get-CyclomaticComplexity -FilePath $file.FullName -Language $ext
        
        $relativePath = $file.FullName.Substring($projectRoot.Length).TrimStart('\')
        
        foreach ($func in $functionResults) {
            $results += [PSCustomObject]@{
                File = $relativePath
                Function = $func.Name
                StartLine = $func.StartLine
                EndLine = $func.EndLine
                LineCount = $func.LineCount
                Complexity = $func.Complexity
                ComplexityDensity = $func.ComplexityDensity
            }
        }
    }
    
    Write-Progress -Activity "Analyzing Files" -Completed
    
    # Sort results by complexity (highest first)
    $sortedResults = $results | Sort-Object -Property Complexity -Descending
    
    # Calculate statistics
    $totalFunctions = $results.Count
    $avgComplexity = ($results | Measure-Object -Property Complexity -Average).Average
    $maxComplexity = ($results | Measure-Object -Property Complexity -Maximum).Maximum
    $complexFunctions = ($results | Where-Object { $_.Complexity -gt $ComplexityThreshold } | Measure-Object).Count
    $percentComplex = [Math]::Round(($complexFunctions / $totalFunctions) * 100, 1)
    
    # Group results by complexity ranges
    $ranges = @(
        @{Name = "Low (1-5)"; Min = 1; Max = 5},
        @{Name = "Moderate (6-10)"; Min = 6; Max = 10},
        @{Name = "High (11-20)"; Min = 11; Max = 20},
        @{Name = "Very High (21-50)"; Min = 21; Max = 50},
        @{Name = "Extremely High (50+)"; Min = 51; Max = [int]::MaxValue}
    )
    
    $complexityDistribution = @()
    foreach ($range in $ranges) {
        $count = ($results | Where-Object { $_.Complexity -ge $range.Min -and $_.Complexity -le $range.Max } | Measure-Object).Count
        $percent = [Math]::Round(($count / $totalFunctions) * 100, 1)
        $complexityDistribution += [PSCustomObject]@{
            Range = $range.Name
            Count = $count
            Percent = $percent
        }
    }
    
    # Generate report
    $report = @"
# Cyclomatic Complexity Analysis Report

Analysis performed on: $(Get-Date -Format "YYYYMMDD HH:mm:ss")  
Repository: $projectRoot  
Files analyzed: $($filesToAnalyze.Count)  
Functions/methods analyzed: $totalFunctions

## Overview

Cyclomatic Complexity (CC) measures the number of linearly independent paths through a program's source code.
It directly corresponds to the number of test cases needed to achieve complete branch coverage.

## Summary Statistics

- **Average Complexity**: $([Math]::Round($avgComplexity, 2))
- **Maximum Complexity**: $maxComplexity
- **Functions with CC > $ComplexityThreshold**: $complexFunctions ($percentComplex%)

## Complexity Distribution

| Complexity Range | Function Count | Percentage |
|------------------|---------------|-----------|
$(($complexityDistribution | ForEach-Object { "| $($_.Range) | $($_.Count) | $($_.Percent)% |" }) -join "`n")

## Most Complex Functions

The following functions have the highest cyclomatic complexity (ordered from most to least complex):

| File | Function | Line | Line Count | Complexity | Density |
|------|----------|------|-----------|------------|---------|
"@
    
    foreach ($item in ($sortedResults | Select-Object -First 20)) {
        $report += "`n| $($item.File) | $($item.Function) | $($item.StartLine) | $($item.LineCount) | $($item.Complexity) | $($item.ComplexityDensity) |"
    }
    
    $report += @"

## Functions Exceeding Threshold (CC > $ComplexityThreshold)

The following functions exceed the complexity threshold and should be prioritized for refactoring:

| File | Function | Line | Line Count | Complexity | Density |
|------|----------|------|-----------|------------|---------|
"@
    
    $highComplexityFunctions = $results | Where-Object { $_.Complexity -gt $ComplexityThreshold } | Sort-Object -Property Complexity -Descending
    
    foreach ($item in $highComplexityFunctions) {
        $report += "`n| $($item.File) | $($item.Function) | $($item.StartLine) | $($item.LineCount) | $($item.Complexity) | $($item.ComplexityDensity) |"
    }
    
    $report += @"

## Recommendations

Based on the cyclomatic complexity analysis:

1. **Refactor High-Complexity Functions**: Functions with CC > 10 should be refactored into smaller, more focused units.
   - Consider extracting complex conditions into separate functions
   - Break large functions into smaller, more manageable pieces
   - Simplify nested conditionals with early returns or guard clauses

2. **Increase Test Coverage**: Functions with high complexity need more thorough testing.
   - Each decision point (if, loop, etc.) represents a path that should be tested
   - High-complexity functions may need specific focus in your test suite

3. **Code Review Focus**: Direct extra attention to high-complexity areas during code reviews.

4. **Documentation**: Ensure complex logic is well-documented to aid understanding.

## Complexity Risk Categories

| Complexity | Risk | Recommendation |
|------------|------|---------------|
| 1-5 | Low | Simple, well-structured code. Generally easy to maintain. |
| 6-10 | Moderate | Reasonably complex. May need minor refactoring. |
| 11-20 | High | Complex code. Should be refactored and well-tested. |
| 21-50 | Very High | Excessively complex. High priority for refactoring. |
| 50+ | Extremely High | Unmaintainable code. Critical priority for refactoring. |

## Notes on Accuracy

This analysis provides approximate cyclomatic complexity. For more accurate results, consider using language-specific static analysis tools.

"@
    
    # Write report to file
    $report | Out-File -FilePath $OutputFile -Encoding utf8
    
    Write-Host "Analysis complete. Report saved to $OutputFile" -ForegroundColor Green
    
} catch {
    Write-Error "Error during analysis: $_"
    exit 1
}
