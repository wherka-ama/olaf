<#
.SYNOPSIS
    Identifies complexity hotspots in a codebase by analyzing git history and code complexity.

.DESCRIPTION
    This script analyzes a git repository to find files that have been frequently changed
    in the last 12 months and have high cyclomatic complexity. It produces a report
    identifying potential hotspots that may require refactoring or special attention.

.PARAMETER RepoPath
    Path to the git repository to analyze. Defaults to current directory.

.PARAMETER MonthsToAnalyze
    Number of months of git history to analyze. Defaults to 12.

.PARAMETER OutputFile
    Path to the output markdown file. Defaults to complexity-hotspots.md in the current directory.

.PARAMETER FileExtensions
    Array of file extensions to analyze (without the dot). Defaults to common code file extensions.

.PARAMETER ExcludePatterns
    Array of patterns to exclude from analysis (e.g., "node_modules", "dist").

.EXAMPLE
    ./identify-complexity-hotspots.ps1 -RepoPath "C:\path\to\repo" -OutputFile "[id:findings_dir]hotspot-analysis/custom-hotspots.md"

.NOTES
    Requires Git to be installed and accessible in the PATH.
    For complexity analysis, it uses simple line count and conditional statement counting as a proxy.
#>

param (
    [string]$RepoPath = (Get-Location),
    [int]$MonthsToAnalyze = 12,
    [string]$OutputFile = "complexity-hotspots.md",
    [string[]]$FileExtensions = @("cs", "java", "js", "ts", "py", "rb", "php", "go", "cpp", "c", "h", "hpp"),
    [string[]]$ExcludePatterns = @("node_modules", "dist", "bin", "obj", "build", "target", "vendor", "packages")
)

# Ensure we're in a git repository
Push-Location $RepoPath
if (-not (Test-Path ".git")) {
    Write-Error "Not a git repository: $RepoPath"
    exit 1
}

# Calculate date for git log
$sinceDate = (Get-Date).AddMonths(-$MonthsToAnalyze).ToString("yyyy-MM-dd")

Write-Host "Analyzing git history since $sinceDate..."

# Get frequently changed files from git history
$changedFiles = git log --since=$sinceDate --name-only --pretty=format: | 
    Where-Object { $_ -ne "" } | 
    Where-Object { 
        $file = $_
        $extension = [System.IO.Path]::GetExtension($file).TrimStart('.')
        $exclude = $false
        foreach ($pattern in $ExcludePatterns) {
            if ($file -like "*$pattern*") {
                $exclude = $true
                break
            }
        }
        -not $exclude -and $FileExtensions -contains $extension
    } | 
    Group-Object | 
    Sort-Object -Property Count -Descending

# Initialize results array
$results = @()

# Analyze top changed files for complexity
$topFiles = $changedFiles | Select-Object -First 30

# Fallback: if no git history, analyze all code files
if ($topFiles.Count -eq 0) {
    Write-Host "No git history found. Analyzing all code files..."
    $allCodeFiles = Get-ChildItem -Recurse -File | Where-Object {
        $file = $_.FullName.Replace($PWD.Path + "\", "")
        $extension = [System.IO.Path]::GetExtension($file).TrimStart('.')
        $exclude = $false
        foreach ($pattern in $ExcludePatterns) {
            if ($file -like "*$pattern*") {
                $exclude = $true
                break
            }
        }
        -not $exclude -and $FileExtensions -contains $extension
    }
    
    $topFiles = $allCodeFiles | ForEach-Object {
        [PSCustomObject]@{
            Name = $_.FullName.Replace($PWD.Path + "\", "")
            Count = 1  # Assign weight of 1 to all files
        }
    } | Select-Object -First 30
}

foreach ($fileEntry in $topFiles) {
    $file = $fileEntry.Name
    
    if (-not (Test-Path $file)) {
        continue
    }
    
    $content = Get-Content $file -ErrorAction SilentlyContinue
    
    if ($null -eq $content) {
        continue
    }
    
    # Simple complexity metrics
    $lineCount = $content.Count
    $conditionalCount = 0
    
    # Count conditional statements (very simple proxy for complexity)
    foreach ($line in $content) {
        if ($line -match "if\s*\(" -or 
            $line -match "else\s*{" -or 
            $line -match "else\s+if" -or 
            $line -match "switch\s*\(" -or 
            $line -match "case\s+:" -or
            $line -match "for\s*\(" -or
            $line -match "while\s*\(" -or
            $line -match "do\s*{" -or
            $line -match "\?\s*.*\s*:" -or  # Ternary operator
            $line -match "&&" -or
            $line -match "\|\|") {
            $conditionalCount++
        }
    }
    
    # Calculate complexity score (change frequency * conditional density)
    $changeFrequency = $fileEntry.Count
    $conditionalDensity = if ($lineCount -gt 0) { $conditionalCount / $lineCount } else { 0 }
    $complexityScore = $changeFrequency * $conditionalDensity * 100
    
    # Add to results
    $results += [PSCustomObject]@{
        File = $file
        ChangeFrequency = $changeFrequency
        LineCount = $lineCount
        ConditionalCount = $conditionalCount
        ConditionalDensity = [math]::Round($conditionalDensity, 3)
        ComplexityScore = [math]::Round($complexityScore, 1)
    }
}

# Sort by complexity score
$sortedResults = $results | Sort-Object -Property ComplexityScore -Descending

# Generate markdown report
$report = @"
# Complexity Hotspots Analysis

Analysis performed on: $(Get-Date -Format "yyyyMMdd-HHmm")  
Repository: $RepoPath  
Period analyzed: $MonthsToAnalyze months (since $sinceDate)

## Top Complexity Hotspots

Files with high change frequency and complexity:

| File | Change Frequency | Lines | Conditionals | Conditional Density | Complexity Score |
|------|-----------------|-------|-------------|-------------------|----------------|
"@

foreach ($item in ($sortedResults | Select-Object -First 20)) {
    $report += "`n| $($item.File) | $($item.ChangeFrequency) | $($item.LineCount) | $($item.ConditionalCount) | $($item.ConditionalDensity) | $($item.ComplexityScore) |"
}

$report += @"

## Analysis Methodology

This report identifies potential complexity hotspots by combining:

1. **Change Frequency**: How often a file has been modified in the last $MonthsToAnalyze months
2. **Conditional Density**: The ratio of conditional statements to total lines of code
3. **Complexity Score**: Change frequency * conditional density * 100

Higher scores indicate files that are both frequently changed and complex, which may benefit from refactoring.

## Recommendations

Files with high complexity scores should be considered for:

1. Refactoring to reduce complexity
2. Additional test coverage
3. Documentation improvements
4. Code review focus during changes

"@

# Write report to file
$outputDir = Split-Path -Parent $OutputFile
if (-not (Test-Path $outputDir)) {
    New-Item -ItemType Directory -Path $outputDir -Force | Out-Null
    Write-Host "Created directory: $outputDir"
}

$report | Out-File -FilePath $OutputFile -Encoding utf8 -NoNewline

Write-Host "Analysis complete. Report saved to $OutputFile"
Pop-Location
