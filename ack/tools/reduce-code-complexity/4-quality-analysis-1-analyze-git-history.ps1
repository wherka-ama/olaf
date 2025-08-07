<#
.SYNOPSIS
    Generates a list of frequently changed files for analysis by complexity scripts.

.DESCRIPTION
    This script analyzes git history to identify files that have been frequently modified
    and outputs them to a files-to-be-analyzed.txt file. This file can then be consumed
    by the Cyclomatic Complexity and Halstead Metrics analysis scripts.

.PARAMETER RepoPath
    Path to the repository to analyze. Defaults to the current directory.

.PARAMETER MonthsToAnalyze
    Number of months of git history to analyze. Defaults to 12.

.PARAMETER OutputFile
    Path to the output file list. Defaults to files-to-be-analyzed.txt in the repository root.

.PARAMETER FileExtensions
    Array of file extensions to include (without the dot). Defaults to common code file extensions.

.PARAMETER ExcludePatterns
    Array of patterns to exclude from analysis (e.g., "node_modules", "dist").

.PARAMETER MaxFiles
    This parameter has been removed. All files meeting the criteria will be included.

.PARAMETER MinChangeFrequency
    Minimum number of changes required for a file to be included. Defaults to 2.

.EXAMPLE
    ./Analyze-CombinedHotspots.ps1 -RepoPath "C:\path\to\repo" -MonthsToAnalyze 6

.EXAMPLE
    ./Analyze-CombinedHotspots.ps1 -MinChangeFrequency 3

.NOTES
    Requires Git to be installed and accessible in the PATH.
    Requires PowerShell 5.1 or higher.
    Output file can be used with analyze-cyclomatic-complexity.ps1 and analyze-halstead-metrics.ps1
#>

param (
    [string]$RepoPath = (Get-Location).Path,
    [int]$MonthsToAnalyze = 12,
    [string]$OutputFile,
    [string[]]$FileExtensions = @("cs", "java", "js", "ts", "py", "rb", "php", "go", "cpp", "c", "h", "hpp"),
    [string[]]$ExcludePatterns = @("node_modules", "dist", "bin", "obj", "build", "target", "vendor", "packages"),
    [int]$MinChangeFrequency = 4
)




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

# Function to count total eligible files (not excluded)
function Get-TotalEligibleFiles {
    param (
        [string]$RepoPath,
        [string[]]$FileExtensions,
        [string[]]$ExcludePatterns
    )
    
    $totalEligibleFiles = 0
    
    # Get all files in the repository
    $allFiles = Get-ChildItem -Path $RepoPath -Recurse -File
    
    foreach ($file in $allFiles) {
        $relativePath = $file.FullName.Replace($RepoPath, "").TrimStart("\", "/")
        $extension = $file.Extension.TrimStart('.')
        $exclude = $false
        
        # Check exclude patterns
        foreach ($pattern in $ExcludePatterns) {
            if ($relativePath -like "*$pattern*") {
                $exclude = $true
                break
            }
        }
        
        # Check if file extension is in the allowed list
        if (-not $exclude -and $FileExtensions -contains $extension) {
            $totalEligibleFiles++
        }
    }
    
    return $totalEligibleFiles
}

# ASCII art banner
function Show-Banner {
    Write-Host "
  _____ _ _         _     _     _   
 |  ___(_) | ___   | |   (_)___| |_ 
 | |_  | | |/ _ \  | |   | / __| __|
 |  _| | | |  __/  | |___| \__ \ |_ 
 |_|   |_|_|\___|  |_____|_|___/\__|
                                   
 _____                           _             
|  __ \                         | |            
| |  \/ ___ _ __   ___ _ __ __ _| |_ ___  _ __ 
| | __ / _ \ '_ \ / _ \ '__/ _` | __/ _ \| '__|
| |_\ \  __/ | | |  __/ | | (_| | || (_) | |   
 \____/\___|_| |_|\___|_|  \__,_|\__\___/|_|   
" -ForegroundColor Cyan
    Write-Host "Frequently Changed Files Generator" -ForegroundColor Cyan
    Write-Host "==================================" -ForegroundColor Cyan
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

# Function to get the change frequency of files from git history
function Get-GitChangeFrequency {
    param (
        [string]$RepoPath,
        [int]$MonthsToAnalyze,
        [string[]]$FileExtensions,
        [string[]]$ExcludePatterns,
        [int]$MinChangeFrequency
    )
    
    Push-Location $RepoPath
    
    try {
        # Check if we're in a git repository
        $gitCheck = git rev-parse --is-inside-work-tree 2>$null
        if ($LASTEXITCODE -ne 0) {
            throw "Not a git repository or git is not available"
        }
        
        # Calculate date for git log
        $sinceDate = (Get-Date).AddMonths(-$MonthsToAnalyze).ToString("YYYYMMDD")
        
        Write-Host "Analyzing git history since $sinceDate..." -ForegroundColor Green
        
        # Get file change information with last modification dates
        $gitLogOutput = git log --since=$sinceDate --name-only --pretty=format:"%H|%ai" 2>$null
        
        if ($LASTEXITCODE -ne 0) {
            throw "Failed to retrieve git log"
        }
        
        # Parse git log output to extract file changes with dates
        $fileChanges = @{}
        $currentCommitDate = ""
        
        foreach ($line in $gitLogOutput) {
            if ($line -match "^[a-f0-9]{40}\|(.+)$") {
                # This is a commit line with date
                $currentCommitDate = [DateTime]::Parse($Matches[1])
            } elseif ($line -ne "" -and $currentCommitDate -ne "") {
                # This is a file name
                $file = $line
                $extension = [System.IO.Path]::GetExtension($file).TrimStart('.')
                $exclude = $false
                
                # Check exclude patterns
                foreach ($pattern in $ExcludePatterns) {
                    if ($file -like "*$pattern*") {
                        $exclude = $true
                        break
                    }
                }
                
                # Check if file extension is in the allowed list and file exists
                if (-not $exclude -and 
                    $FileExtensions -contains $extension -and
                    (Test-Path (Join-Path $RepoPath $file))) {
                    
                    if (-not $fileChanges.ContainsKey($file)) {
                        $fileChanges[$file] = @{
                            Count = 0
                            LastModified = $currentCommitDate
                        }
                    }
                    
                    $fileChanges[$file].Count++
                    
                    # Update last modified date if this commit is more recent
                    if ($currentCommitDate -gt $fileChanges[$file].LastModified) {
                        $fileChanges[$file].LastModified = $currentCommitDate
                    }
                }
            }
        }
        
        # Filter by minimum change frequency and convert to objects
        $results = @()
        foreach ($file in $fileChanges.Keys) {
            if ($fileChanges[$file].Count -ge $MinChangeFrequency) {
                $results += [PSCustomObject]@{
                    Name = $file
                    Count = $fileChanges[$file].Count
                    LastModified = $fileChanges[$file].LastModified
                }
            }
        }
        
        return $results | Sort-Object -Property Count -Descending
    }
    catch {
        Write-Error "Error analyzing git history: $_"
        return @()
    }
    finally {
        Pop-Location
    }
}

# Main script execution
$ErrorActionPreference = "Stop"

try {
    Show-Banner
    
    # Determine project root
    $projectRoot = Get-ProjectRoot -Path $RepoPath
    if (-not $projectRoot) {
        $projectRoot = $RepoPath
        Write-Warning "Could not find .git directory, using specified path as project root: $RepoPath"
    } else {
        Write-Host "Project root found: $projectRoot"
    }
    
    # Set default output file if not provided
    if (-not $OutputFile) {
        $findingsDir = Join-Path $projectRoot "ads\findings\reduce-code-complexity"
        $OutputFile = Join-Path $findingsDir "files-to-be-analyzed.txt"
    }
    
    # Ensure output directory exists
    $outputDir = Split-Path -Parent $OutputFile
    if (-not (Test-Path $outputDir)) {
        New-Item -ItemType Directory -Path $outputDir -Force | Out-Null
        Write-Host "Created output directory: $outputDir"
    }
    
    # Get frequently changed files from git history
    Write-Host "Analyzing git change history..." -ForegroundColor Green
    $changedFiles = Get-GitChangeFrequency -RepoPath $projectRoot -MonthsToAnalyze $MonthsToAnalyze -FileExtensions $FileExtensions -ExcludePatterns $ExcludePatterns -MinChangeFrequency $MinChangeFrequency
    
    # Get total eligible files count
    Write-Host "Calculating total eligible files..." -ForegroundColor Green
    $totalEligibleFiles = Get-TotalEligibleFiles -RepoPath $projectRoot -FileExtensions $FileExtensions -ExcludePatterns $ExcludePatterns
    
    if ($changedFiles.Count -eq 0) {
        Write-Warning "No files found matching the criteria."
        Write-Host "Try reducing -MinChangeFrequency or increasing -MonthsToAnalyze" -ForegroundColor Yellow
        return
    }
    
    Write-Host "Found $($changedFiles.Count) files to include in analysis list." -ForegroundColor Green
    
    # Generate CSV content
    $csvContent = @()
    $csvContent += "filename-ext,folder,number-of-modification,last-modification-date"
    
    # Add the file data
    foreach ($fileEntry in $changedFiles) {
        $fileName = [System.IO.Path]::GetFileName($fileEntry.Name)
        $folderPath = [System.IO.Path]::GetDirectoryName($fileEntry.Name)
        
        # Handle root files (no folder)
        if ([string]::IsNullOrEmpty($folderPath)) {
            $folderPath = "."
        }
        
        # Format date as ISO 8601
        $lastModDate = $fileEntry.LastModified.ToString("YYYYMMDD")
        
        $csvContent += "$fileName,$folderPath,$($fileEntry.Count),$lastModDate"
    }
    
    # Write the CSV file
    $csvContent | Out-File -FilePath $OutputFile -Encoding utf8
    
    Write-Host "`nCSV file generated successfully!" -ForegroundColor Green
    Write-Host "Output file: $OutputFile" -ForegroundColor Cyan
    Write-Host "Files included: $($changedFiles.Count)" -ForegroundColor Cyan
    
    # Show summary statistics
    Write-Host "`n=== Summary Statistics ===" -ForegroundColor Yellow
    Write-Host "Period analyzed: $MonthsToAnalyze months" -ForegroundColor White
    Write-Host "Minimum change frequency: $MinChangeFrequency" -ForegroundColor White
    Write-Host "Total eligible files: $totalEligibleFiles" -ForegroundColor White
    Write-Host "Files found: $($changedFiles.Count)" -ForegroundColor White
    
    # Calculate and display density
    if ($totalEligibleFiles -gt 0) {
        $density = [Math]::Round(($changedFiles.Count / $totalEligibleFiles) * 100, 2)
        Write-Host "Change density: $density% (changed files / total eligible files)" -ForegroundColor White
    }
    
    if ($changedFiles.Count -gt 0) {
        $avgChanges = ($changedFiles | Measure-Object -Property Count -Average).Average
        $maxChanges = ($changedFiles | Measure-Object -Property Count -Maximum).Maximum
        $minChanges = ($changedFiles | Measure-Object -Property Count -Minimum).Minimum
        
        Write-Host "Average changes per file: $([Math]::Round($avgChanges, 1))" -ForegroundColor White
        Write-Host "Most changed file: $($changedFiles[0].Name) ($maxChanges changes)" -ForegroundColor White
        Write-Host "Least changed file: $($changedFiles[-1].Name) ($minChanges changes)" -ForegroundColor White
    }
    
    # Count total eligible files for density information
    $totalEligibleFiles = Get-TotalEligibleFiles -RepoPath $projectRoot -FileExtensions $FileExtensions -ExcludePatterns $ExcludePatterns
    Write-Host "Total eligible files in repository: $totalEligibleFiles" -ForegroundColor White
    
    # Calculate density metrics
    if ($totalEligibleFiles -gt 0) {
        $density = ($changedFiles.Count / $totalEligibleFiles) * 100
        Write-Host "Density of changes (files included in analysis / total eligible files): $([Math]::Round($density, 2))%" -ForegroundColor White
    } else {
        Write-Host "No eligible files found for density calculation." -ForegroundColor Yellow
    }
    
    Write-Host "`n=== Next Steps ===" -ForegroundColor Yellow
    Write-Host "You can now run complexity analysis using this CSV file:" -ForegroundColor White
    Write-Host "  ./analyze-cyclomatic-complexity.ps1" -ForegroundColor Cyan
    Write-Host "  ./analyze-halstead-metrics.ps1" -ForegroundColor Cyan
    
} catch {
    Write-Error "Error during analysis: $_"
    exit 1
}
