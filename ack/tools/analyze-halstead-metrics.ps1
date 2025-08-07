<#
.SYNOPSIS
    Analyzes Halstead complexity metrics for source code.

.DESCRIPTION
    This script calculates Halstead complexity metrics for source code files. 
    Halstead metrics measure software complexity based on the number of operators 
    and operands in the code, providing insights into program effort, difficulty, 
    and maintainability.

.PARAMETER RepoPath
    Path to the repository to analyze. Defaults to the current directory.

.PARAMETER OutputFile
    Path to the output markdown file. Defaults to halstead-metrics.md in the ads/findings directory.

.PARAMETER FileExtensions
    Array of file extensions to analyze (without the dot). Defaults to common code file extensions.

.PARAMETER ExcludePatterns
    Array of patterns to exclude from analysis (e.g., "node_modules", "dist").

.PARAMETER MaxFiles
    Maximum number of files to analyze. Defaults to 500. Set to 0 for unlimited.

.PARAMETER FilesToAnalyzeFile
    Path to a text file containing a list of files to analyze (one file path per line).
    If provided, only these files will be analyzed instead of scanning the repository.

.EXAMPLE
    ./analyze-halstead-metrics.ps1 -RepoPath "C:\path\to\repo"

.EXAMPLE
    ./analyze-halstead-metrics.ps1 -MaxFiles 50 -FileExtensions @("js", "ts")

.EXAMPLE
    ./analyze-halstead-metrics.ps1 -FilesToAnalyzeFile "files-to-be-analyzed.txt"

.NOTES
    This script performs a simplified calculation of Halstead metrics.
    For more accurate results, consider using language-specific static analysis tools.
#>

param (
    [string]$RepoPath = (Get-Location).Path,
    [string]$OutputFile,
    [string]$FilesToAnalyzeFile,
    [string[]]$FileExtensions = @("cs", "java", "js", "ts", "py", "rb", "php", "go", "cpp", "c", "h", "hpp"),
    [string[]]$ExcludePatterns = @("node_modules", "dist", "bin", "obj", "build", "target", "vendor", "packages"),
    [int]$MaxFiles = 500
)

# Require OutputFile if not provided
if (-not $OutputFile) {
    $OutputFile = Join-Path $projectRoot "halstead-metrics.md"
}
# If the output path is a directory, append the default filename
if ((Test-Path $OutputFile) -and (Get-Item $OutputFile).PSIsContainer) {
    $OutputFile = Join-Path $OutputFile "halstead-metrics.md"
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
 _   _       _     _                 _ 
| | | |     | |   | |               | |
| |_| | __ _| |___| |_ ___  __ _  __| |
|  _  |/ _` | / __| __/ _ \/ _` |/ _` |
| | | | (_| | \__ \ ||  __/ (_| | (_| |
\_| |_/\__,_|_|___/\__\___|\__,_|\__,_|
                                       
" -ForegroundColor Cyan
    Write-Host "Halstead Metrics Analyzer" -ForegroundColor Cyan
    Write-Host "=========================" -ForegroundColor Cyan
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

# Function to calculate Halstead metrics for a file
function Get-HalsteadMetrics {
    param (
        [string]$FilePath,
        [string]$Language
    )
    
    $content = $null
    try {
        # Try to read the file as text, with error handling for binary files
        $content = Get-Content -Path $FilePath -Raw -ErrorAction Stop
    }
    catch {
        Write-Warning "Could not read file $FilePath as text. It might be a binary file: $_"
        return @{
            Vocabulary = 0
            Length = 0
            Volume = 0
            Difficulty = 0
            Effort = 0
            Time = 0
            Bugs = 0
        }
    }
    
    # Skip empty files
    if ([string]::IsNullOrEmpty($content)) {
        Write-Warning "File $FilePath is empty or could not be read."
        return @{
            Vocabulary = 0
            Length = 0
            Volume = 0
            Difficulty = 0
            Effort = 0
            Time = 0
            Bugs = 0
        }
    }
    
    # Define language-specific patterns for operators and operands
    # These are simplified and should be expanded for more accurate results
    $patterns = @{
        "cs" = @{
            Operators = @(
                '\+', '-', '\*', '/', '%',           # Arithmetic operators
                '==', '!=', '>', '<', '>=', '<=',    # Comparison operators
                '&&', '\|\|', '!',                   # Logical operators
                '\+=', '-=', '\*=', '/=', '%=',      # Assignment operators
                '\+\+', '--',                        # Increment/decrement
                '\?', ':',                           # Ternary operator
                '\.', '\[', '\]', '\(', '\)',        # Access operators
                '{', '}',                           # Block delimiters
                'if', 'else', 'switch', 'case',      # Control flow
                'for', 'foreach', 'while', 'do',     # Loops
                'try', 'catch', 'finally', 'throw'   # Exception handling
            )
            Operands = @(
                '\b[a-zA-Z_][a-zA-Z0-9_]*\b',        # Identifiers
                '\b\d+\b',                           # Integer literals
                '\b\d+\.\d+\b',                      # Float literals
                '"[^"]*"',                           # String literals
                "'[^']*'"                            # Character literals
            )
        }
        "java" = @{
            Operators = @(
                '\+', '-', '\*', '/', '%',           # Arithmetic operators
                '==', '!=', '>', '<', '>=', '<=',    # Comparison operators
                '&&', '\|\|', '!',                   # Logical operators
                '\+=', '-=', '\*=', '/=', '%=',      # Assignment operators
                '\+\+', '--',                        # Increment/decrement
                '\?', ':',                           # Ternary operator
                '\.', '\[', '\]', '\(', '\)',        # Access operators
                '{', '}',                           # Block delimiters
                'if', 'else', 'switch', 'case',      # Control flow
                'for', 'foreach', 'while', 'do',     # Loops
                'try', 'catch', 'finally', 'throw'   # Exception handling
            )
            Operands = @(
                '\b[a-zA-Z_][a-zA-Z0-9_]*\b',        # Identifiers
                '\b\d+\b',                           # Integer literals
                '\b\d+\.\d+\b',                      # Float literals
                '"[^"]*"',                           # String literals
                "'[^']*'"                            # Character literals
            )
        }
        "js" = @{
            Operators = @(
                '\+', '-', '\*', '/', '%',           # Arithmetic operators
                '==', '===', '!=', '!==', '>', '<', '>=', '<=',  # Comparison operators
                '&&', '\|\|', '!',                   # Logical operators
                '=', '\+=', '-=', '\*=', '/=', '%=', # Assignment operators
                '\+\+', '--',                        # Increment/decrement
                '\?', ':',                           # Ternary operator
                '\.', '\[', '\]', '\(', '\)',        # Access operators
                '{', '}',                           # Block delimiters
                'if', 'else', 'switch', 'case',      # Control flow
                'for', 'while', 'do',                # Loops
                'try', 'catch', 'finally', 'throw'   # Exception handling
            )
            Operands = @(
                '\b[a-zA-Z_][a-zA-Z0-9_]*\b',        # Identifiers
                '\b\d+\b',                           # Integer literals
                '\b\d+\.\d+\b',                      # Float literals
                '"[^"]*"',                           # String literals
                "'[^']*'",                          # Single-quoted strings
                '`[^`]*`'                            # Template literals
            )
        }
        "py" = @{
            Operators = @(
                '\+', '-', '\*', '/', '//', '%', '\*\*',  # Arithmetic operators
                '==', '!=', '>', '<', '>=', '<=',    # Comparison operators
                'and', 'or', 'not',                  # Logical operators
                '=', '\+=', '-=', '\*=', '/=', '%=', # Assignment operators
                '\?', ':',                           # Ternary operator
                '\.', '\[', '\]', '\(', '\)',        # Access operators
                '{', '}',                           # Block delimiters
                'if', 'elif', 'else',                # Control flow
                'for', 'while',                      # Loops
                'try', 'except', 'finally', 'raise'  # Exception handling
            )
            Operands = @(
                '\b[a-zA-Z_][a-zA-Z0-9_]*\b',        # Identifiers
                '\b\d+\b',                           # Integer literals
                '\b\d+\.\d+\b',                      # Float literals
                '"[^"]*"',                           # Double-quoted strings
                "'[^']*'",                          # Single-quoted strings
                '"""[\s\S]*?"""',                    # Triple-quoted strings
                "'''[\s\S]*?'''"                     # Triple-quoted strings (single)
            )
        }
        # Default pattern for other languages
        "default" = @{
            Operators = @(
                '\+', '-', '\*', '/', '%',           # Common arithmetic operators
                '==', '!=', '>', '<', '>=', '<=',    # Common comparison operators
                '&&', '\|\|', '!',                   # Common logical operators
                '=',                                 # Assignment
                '\?', ':',                           # Ternary operator
                '\.', '\[', '\]', '\(', '\)',        # Access operators
                '{', '}'                            # Block delimiters
            )
            Operands = @(
                '\b[a-zA-Z_][a-zA-Z0-9_]*\b',        # Identifiers
                '\b\d+\b',                           # Integer literals
                '\b\d+\.\d+\b',                      # Float literals
                '"[^"]*"',                           # String literals
                "'[^']*'"                            # Character literals
            )
        }
    }
    
    # Determine which pattern set to use based on file extension
    $patternSet = $patterns["default"]
    if ($patterns.ContainsKey($Language)) {
        $patternSet = $patterns[$Language]
    }
    
    # Find unique operators
    $uniqueOperators = @{}
    $totalOperators = 0
    
    foreach ($pattern in $patternSet.Operators) {
        # Skip empty or null patterns
        if ([string]::IsNullOrEmpty($pattern) -or [string]::IsNullOrEmpty($content)) {
            continue
        }
        
        try {
            $matches = [regex]::Matches($content, $pattern)
            if ($matches.Count -gt 0) {
                foreach ($match in $matches) {
                    $operator = $match.Value
                    if (-not $uniqueOperators.ContainsKey($operator)) {
                        $uniqueOperators[$operator] = 0
                    }
                    $uniqueOperators[$operator]++
                    $totalOperators++
                }
            }
        }
        catch {
            Write-Warning "Error matching pattern '$pattern': $_"
        }
    }
    
    # Find unique operands
    $uniqueOperands = @{}
    $totalOperands = 0
    
    foreach ($pattern in $patternSet.Operands) {
        # Skip empty or null patterns
        if ([string]::IsNullOrEmpty($pattern) -or [string]::IsNullOrEmpty($content)) {
            continue
        }
        
        try {
            $matches = [regex]::Matches($content, $pattern)
            if ($matches.Count -gt 0) {
                foreach ($match in $matches) {
                    $operand = $match.Value
                    if (-not $uniqueOperands.ContainsKey($operand)) {
                        $uniqueOperands[$operand] = 0
                    }
                    $uniqueOperands[$operand]++
                    $totalOperands++
                }
            }
        }
        catch {
            Write-Warning "Error matching pattern '$pattern': $_"
        }
    }
    
    # Calculate Halstead metrics
    $n1 = $uniqueOperators.Count            # Number of unique operators
    $n2 = $uniqueOperands.Count             # Number of unique operands
    $N1 = $totalOperators                   # Total number of operators
    $N2 = $totalOperands                    # Total number of operands
    
    # Avoid division by zero
    if ($n1 -eq 0 -or $n2 -eq 0) {
        return @{
            Vocabulary = 0
            Length = 0
            Volume = 0
            Difficulty = 0
            Effort = 0
            Time = 0
            Bugs = 0
        }
    }
    
    $vocabulary = $n1 + $n2                 # Program vocabulary
    $length = $N1 + $N2                     # Program length
    $volume = $length * [Math]::Log($vocabulary, 2)  # Program volume
    $difficulty = ($n1 / 2) * ($N2 / $n2)   # Program difficulty
    $effort = $volume * $difficulty         # Programming effort
    $time = $effort / 18                    # Time to implement (in seconds)
    $bugs = $volume / 3000                  # Estimated number of bugs
    
    return @{
        Vocabulary = [Math]::Round($vocabulary, 2)
        Length = $length
        Volume = [Math]::Round($volume, 2)
        Difficulty = [Math]::Round($difficulty, 2)
        Effort = [Math]::Round($effort, 2)
        Time = [Math]::Round($time, 2)
        Bugs = [Math]::Round($bugs, 3)
    }
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
        $findingsDir = Join-Path $projectRoot "ads\findings"
        if (-not (Test-Path $findingsDir)) {
            New-Item -ItemType Directory -Path $findingsDir -Force | Out-Null
            Write-Host "Created findings directory: $findingsDir"
        }
        $OutputFile = Join-Path $findingsDir "halstead-metrics.md"
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
    
    # Check if FilesToAnalyzeFile is provided and exists
    if ($FilesToAnalyzeFile) {
        if (-not (Test-Path $FilesToAnalyzeFile)) {
            Write-Error "Files list file not found: $FilesToAnalyzeFile"
            exit 1
        }
        
        Write-Host "Reading files from: $FilesToAnalyzeFile" -ForegroundColor Yellow
        
        try {
            $fileList = Get-Content -Path $FilesToAnalyzeFile -ErrorAction Stop
            foreach ($filePath in $fileList) {
                $filePath = $filePath.Trim()
                if ([string]::IsNullOrWhiteSpace($filePath) -or $filePath.StartsWith('#')) {
                    continue  # Skip empty lines and comments
                }
                
                # Convert relative paths to absolute paths based on project root
                if (-not [System.IO.Path]::IsPathRooted($filePath)) {
                    $filePath = Join-Path $projectRoot $filePath
                }
                
                if (Test-Path $filePath) {
                    $fileInfo = Get-Item $filePath
                    if (-not $fileInfo.PSIsContainer) {  # Ensure it's a file, not a directory
                        $filesToAnalyze += $fileInfo
                    } else {
                        Write-Warning "Skipping directory: $filePath"
                    }
                } else {
                    Write-Warning "File not found: $filePath"
                }
            }
            
            Write-Host "Loaded $($filesToAnalyze.Count) files from the provided list." -ForegroundColor Green
            
        } catch {
            Write-Error "Error reading files list: $_"
            exit 1
        }
        
    } else {
        # Default behavior: scan repository for files matching extensions
        Write-Host "No files list provided. Scanning repository for files matching extensions..." -ForegroundColor Yellow
        
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
                
                # Limit the number of files to analyze if MaxFiles is set
                if ($MaxFiles -gt 0 -and $filesToAnalyze.Count -ge $MaxFiles) {
                    Write-Host "Reached maximum file limit ($MaxFiles). Use -MaxFiles parameter to adjust." -ForegroundColor Yellow
                    break
                }
            }
            
            # Check again after processing each extension
            if ($MaxFiles -gt 0 -and $filesToAnalyze.Count -ge $MaxFiles) {
                break
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
        $metrics = Get-HalsteadMetrics -FilePath $file.FullName -Language $ext
        
        $relativePath = $file.FullName.Substring($projectRoot.Length).TrimStart('\')
        
        $results += [PSCustomObject]@{
            File = $relativePath
            Language = $ext
            Vocabulary = $metrics.Vocabulary
            Length = $metrics.Length
            Volume = $metrics.Volume
            Difficulty = $metrics.Difficulty
            Effort = $metrics.Effort
            Time = $metrics.Time
            Bugs = $metrics.Bugs
        }
    }
    
    Write-Progress -Activity "Analyzing Files" -Completed
    
    # Sort results by effort (highest first)
    $sortedResults = $results | Sort-Object -Property Effort -Descending
    
    # Calculate averages
    $avgVolume = ($results | Measure-Object -Property Volume -Average).Average
    $avgDifficulty = ($results | Measure-Object -Property Difficulty -Average).Average
    $avgEffort = ($results | Measure-Object -Property Effort -Average).Average
    $totalBugs = ($results | Measure-Object -Property Bugs -Sum).Sum
    
    # Generate report
    $report = @"
# Halstead Complexity Metrics Report

Analysis performed on: $(Get-Date -Format "YYYYMMDD HH:mm:ss")  
Repository: $projectRoot  
Files analyzed: $($results.Count)

## Overview

Halstead metrics measure program complexity based on the number of operators and operands in the code:

- **Vocabulary**: The number of unique operators and operands
- **Length**: The total number of operators and operands
- **Volume**: The size of the implementation of an algorithm
- **Difficulty**: The difficulty of the program to write or understand
- **Effort**: The amount of mental effort required to develop or maintain the program
- **Time**: Estimated time (in seconds) to implement or understand the program
- **Bugs**: Estimated number of bugs in the implementation

## Summary Statistics

- **Average Volume**: $([Math]::Round($avgVolume, 2))
- **Average Difficulty**: $([Math]::Round($avgDifficulty, 2))
- **Average Effort**: $([Math]::Round($avgEffort, 2))
- **Estimated Total Bugs**: $([Math]::Round($totalBugs, 2))


    # Insert Automatic Refactoring Flags section
    $report += @"

## Automatic Refactoring Flags

The following files exceed at least one high-complexity threshold and are flagged for refactoring:

| File | Volume | Difficulty | Effort | Reason |
|------|--------|------------|--------|--------|
"@
    $flagged = $false
    foreach ($item in $results) {
        $reasons = @()
        if ($item.Volume -gt 10000) { $reasons += "Volume > 10000" }
        if ($item.Difficulty -gt 20) { $reasons += "Difficulty > 20" }
        if ($item.Effort -gt 100000) { $reasons += "Effort > 100000" }
        if ($reasons.Count -gt 0) {
            $report += "`n| $($item.File) | $($item.Volume) | $($item.Difficulty) | $($item.Effort) | $($reasons -join '; ') |"
            $flagged = $true
        }
    }
    if ($flagged) {
        $report += "`n`n**These files should be prioritized for refactoring, simplification, and documentation.**`n"
    } else {
        $report += "`n`n_No files exceeded high-complexity thresholds for refactoring._`n"
    }



$report += @"
## Files Ranked by Effort

The following files require the most effort to understand and maintain:

| File | Volume | Difficulty | Effort | Est. Time (min) | Est. Bugs |
|------|--------|------------|--------|----------------|-----------|
"@

foreach ($item in ($sortedResults | Select-Object -First 20)) {
    $timeInMinutes = [Math]::Round($item.Time / 60, 1)
    $report += "`n| $($item.File) | $($item.Volume) | $($item.Difficulty) | $($item.Effort) | $timeInMinutes | $($item.Bugs) |"
}
    
    $report += @"

## Files Grouped by Language

"@
    
    $languageGroups = $results | Group-Object -Property Language
    
    foreach ($group in $languageGroups) {
        $langAvgVolume = ($group.Group | Measure-Object -Property Volume -Average).Average
        $langAvgDifficulty = ($group.Group | Measure-Object -Property Difficulty -Average).Average
        $langAvgEffort = ($group.Group | Measure-Object -Property Effort -Average).Average
        
        $report += @"

### $($group.Name) Files ($($group.Count) files)

- **Average Volume**: $([Math]::Round($langAvgVolume, 2))
- **Average Difficulty**: $([Math]::Round($langAvgDifficulty, 2))
- **Average Effort**: $([Math]::Round($langAvgEffort, 2))

"@
    }
    
    $report += @"

## Recommendations

Based on the Halstead metrics analysis:

1. **Focus Refactoring Efforts**: Files with high Effort values should be prioritized for refactoring.
2. **Documentation**: Files with high Difficulty should be well-documented.
3. **Code Reviews**: High Volume files should receive thorough code reviews.
4. **Testing**: Files with higher estimated bug counts should have comprehensive test coverage.

## Interpretation Guide

- **Volume < 1000**: Simple, straightforward code
- **Volume 1000-10000**: Moderate complexity
- **Volume > 10000**: High complexity, consider refactoring

- **Difficulty < 10**: Easy to understand
- **Difficulty 10-20**: Moderate difficulty
- **Difficulty > 20**: Difficult to understand, may need simplification

- **Effort < 10000**: Low effort required
- **Effort 10000-100000**: Moderate effort required
- **Effort > 100000**: High effort required, consider refactoring

## Notes on Accuracy

This analysis provides approximate Halstead metrics. For more accurate results, consider using language-specific static analysis tools.

"@
    
    # Write report to file
    $report | Out-File -FilePath $OutputFile -Encoding utf8
    
    Write-Host "Analysis complete. Report saved to $OutputFile" -ForegroundColor Green
    
} catch {
    Write-Error "Error during analysis: $_"
    exit 1
}
