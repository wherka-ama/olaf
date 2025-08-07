# File Reference Validator Script
# Created: 2025-08-04
# Purpose: Parse files in prompts, templates, and tools directories to find file references and validate their existence

param(
    [string]$RootPath,
    [string]$OutputFile
)

# Auto-detect workspace root if not provided
if (-not $RootPath) {
    $currentDir = Get-Location
    $searchDir = $currentDir
    
    # Look for workspace indicators (ack and ads folders)
    while ($searchDir -and $searchDir.Path -ne $searchDir.Root) {
        $ackPath = Join-Path $searchDir.Path "ack"
        $adsPath = Join-Path $searchDir.Path "ads"
        
        if ((Test-Path $ackPath) -and (Test-Path $adsPath)) {
            $RootPath = Join-Path $searchDir.Path "ack"
            break
        }
        
        $searchDir = $searchDir.Parent
    }
    
    if (-not $RootPath) {
        throw "Could not auto-detect workspace root. Please provide -RootPath parameter or run from within a workspace containing 'ack' and 'ads' folders."
    }
    
    Write-Host "Auto-detected workspace root: $RootPath"
}

# Set default output file if not provided
if (-not $OutputFile) {
    $OutputFile = Join-Path $RootPath "missing-file-references.txt"
}

# Define the directories to scan
$ScanDirectories = @(
    "prompts",
    "templates", 
    "tools"
)

# Define file extensions to scan
$FileExtensions = @("*.md", "*.ps1", "*.json", "*.xml")

# Define patterns for file references - only look for real references, not examples
$ReferencePatterns = @(
    # Pattern for [id:directory_name]filename references - these are REAL references
    '\[id:([^\]]+)\]([^\s\[\]]+\.(?:md|ps1|json|xml|txt|yml|yaml))',
    # Pattern for Read/Write/Load file commands - these are REAL references  
    '(?:Read file:|Write file:|Load file:|Include file:|Import file:|Execute script:)\s*["`'']*([^\s"`''\[\]]+\.(?:md|ps1|json|xml|txt|yml|yaml))["`'']*',
    # Pattern for script execution - these are REAL references
    '(?:\.\s*\\|Invoke-Expression|& )\s*["`'']*([a-zA-Z0-9_-]+\.ps1)["`'']*'
)

# Function to resolve ID mappings to actual directories - ONLY ACK directories
function Resolve-IdMapping {
    param([string]$IdName)
    
    $IdMappings = @{
        "templates_dir" = "ack\templates"
        "prompts_dir" = "ack\prompts"
        "tools_dir" = "ack\tools"
        "reference_dir" = "ack\reference"
        "questionnaires_dir" = "ack\questionnaires"
        "documentation_dir" = "ack\documentation"
        "conversation_records_dir" = "ack\conversation_records"
    }
    
    if ($IdMappings.ContainsKey($IdName)) {
        return $IdMappings[$IdName]
    }
    
    # If no specific mapping found, try to infer from the name - but only if it's ack-related
    if ($IdName.EndsWith("_dir")) {
        $dirName = $IdName.Replace("_dir", "")
        # Only return ack paths for known ack directories
        $ackDirs = @("templates", "prompts", "tools", "reference", "questionnaires", "documentation", "conversation_records")
        if ($ackDirs -contains $dirName) {
            return "ack\$dirName"
        }
    }
    
    return $null
}

# Function to check if a filename looks like a real reference vs an example/template
function Test-IsRealFileReference {
    param(
        [string]$FileName,
        [string]$Context
    )
    
    # Skip obvious template/example patterns
    $templatePatterns = @(
        'YYYY', 'MM', 'DD', 'NNN', 'SSS', 'XXX',  # Date/number placeholders
        'filename', 'file1', 'file2', 'FileN',     # Generic placeholders
        'example', 'sample', 'template',           # Example indicators
        'your-', 'my-', 'custom-',                 # User-specific placeholders
        'ComponentName', 'Application',            # Code placeholders
        'overview.md', 'index.md'                  # Common example names in structure docs
    )
    
    foreach ($pattern in $templatePatterns) {
        if ($FileName -like "*$pattern*") {
            return $false
        }
    }
    
    # Skip if it's in a code block, documentation structure, or example section
    $contextLines = $Context -split "`n"
    $isInCodeBlock = $false
    $isInExample = $false
    
    foreach ($line in $contextLines) {
        if ($line -match '```|````') {
            $isInCodeBlock = -not $isInCodeBlock
        }
        if ($line -match '(?i)(example|sample|structure|template|format):') {
            $isInExample = $true
        }
        if ($line.Contains($FileName) -and ($isInCodeBlock -or $isInExample)) {
            return $false
        }
    }
    
    return $true
}
function Find-FileInAck {
    param(
        [string]$FileName,
        [string]$AckRootPath
    )
    
    try {
        $foundFiles = Get-ChildItem -Path $AckRootPath -Recurse -Filter $FileName -File -ErrorAction SilentlyContinue
        return $foundFiles.Count -gt 0
    }
    catch {
        return $false
    }
}

# Function to validate file references
function Test-FileReferences {
    param(
        [string]$FilePath,
        [string]$Content,
        [System.Collections.ArrayList]$MissingRefs
    )
    
    # Remove the Write-Host line that was causing issues
    # Write-Host "Scanning file: $FilePath" -ForegroundColor Cyan
    
    foreach ($pattern in $ReferencePatterns) {
        $matches = [regex]::Matches($Content, $pattern, [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
        
        foreach ($match in $matches) {
            $referencedFile = ""
            $resolvedPath = ""
            
            if ($match.Groups.Count -eq 3) {
                # This is an [id:directory]filename pattern
                $idName = $match.Groups[1].Value
                $fileName = $match.Groups[2].Value
                $resolvedDir = Resolve-IdMapping -IdName $idName
                
                # Only process if it resolves to an ack directory
                if ($resolvedDir) {
                    $referencedFile = $fileName
                    $resolvedPath = Join-Path $RootPath.Replace("\ack", "") $resolvedDir $fileName
                }
                else {
                    # Skip non-ack references
                    continue
                }
            }
            else {
                # This is a direct file reference
                $referencedFile = $match.Groups[1].Value
                
                # Check if it's an absolute path or relative path
                if ([System.IO.Path]::IsPathRooted($referencedFile)) {
                    $resolvedPath = $referencedFile
                }
                else {
                    # Assume it's relative to the current file's directory
                    $currentDir = Split-Path $FilePath -Parent
                    $resolvedPath = Join-Path $currentDir $referencedFile
                }
            }
            
            # Check if this looks like a real file reference (not an example/template)
            if (-not (Test-IsRealFileReference -FileName $referencedFile -Context $Content)) {
                Write-Host "  SKIPPED (template/example): $referencedFile" -ForegroundColor Yellow
                continue
            }
            
            # Check if the file exists
            $fileExists = $false
            
            if (Test-Path $resolvedPath) {
                $fileExists = $true
            }
            else {
                # If not found at resolved path, search only in /ack subdirectories
                $fileExists = Find-FileInAck -FileName $referencedFile -AckRootPath $RootPath
            }
            
            if (-not $fileExists) {
                $missingRef = [PSCustomObject]@{
                    SourceFile = $FilePath
                    ReferencedFile = $referencedFile
                    ResolvedPath = $resolvedPath
                    FullMatch = $match.Value
                }
                [void]$MissingRefs.Add($missingRef)
                Write-Host "  MISSING: $referencedFile" -ForegroundColor Red
            }
            else {
                Write-Host "  FOUND: $referencedFile" -ForegroundColor Green
            }
        }
    }
}

# Main execution
Write-Host "Starting File Reference Validation..." -ForegroundColor Yellow
Write-Host "Root Path: $RootPath" -ForegroundColor Yellow
Write-Host "Output File: $OutputFile" -ForegroundColor Yellow

$missingReferences = New-Object System.Collections.ArrayList

# Scan each specified directory
foreach ($scanDir in $ScanDirectories) {
    $fullScanPath = Join-Path $RootPath $scanDir
    
    if (-not (Test-Path $fullScanPath)) {
        Write-Warning "Directory not found: $fullScanPath"
        continue
    }
    
    Write-Host "`nScanning directory: $fullScanPath" -ForegroundColor Magenta
    
    # Get all files with specified extensions
    $filesToScan = @()
    foreach ($ext in $FileExtensions) {
        $filesToScan += Get-ChildItem -Path $fullScanPath -Filter $ext -Recurse -File
    }
    
    foreach ($file in $filesToScan) {
        Write-Host "Scanning file: $($file.FullName)" -ForegroundColor Cyan
        
        try {
            # Use .NET file reading to completely avoid PowerShell command parsing
            if (Test-Path $file.FullName) {
                $content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
                if ($content) {
                    Test-FileReferences -FilePath $file.FullName -Content $content -MissingRefs $missingReferences
                }
            }
        }
        catch {
            Write-Warning "Error reading file: $($file.FullName) - $($_.Exception.Message)"
        }
    }
}

# Generate the output report
Write-Host "`nGenerating report..." -ForegroundColor Yellow

$reportContent = @()
$reportContent += "# Missing File References Report"
$reportContent += "Generated: $(Get-Date -Format 'YYYYMMDD HH:mm:ss')"
$reportContent += "Total missing references found: $($missingReferences.Count)"
$reportContent += ""

if ($missingReferences.Count -eq 0) {
    $reportContent += "✅ All file references are valid!"
}
else {
    $reportContent += "❌ Missing file references:"
    $reportContent += ""
    
    foreach ($missing in $missingReferences) {
        $reportContent += "SOURCE FILE: $($missing.SourceFile)"
        $reportContent += "REFERENCED FILE: $($missing.ReferencedFile)"
        $reportContent += "RESOLVED PATH: $($missing.ResolvedPath)"
        $reportContent += "FULL MATCH: $($missing.FullMatch)"
        $reportContent += "---"
    }
}

# Write the report to file
try {
    $reportContent | Out-File -FilePath $OutputFile -Encoding UTF8 -Force
    Write-Host "Report saved to: $OutputFile" -ForegroundColor Green
}
catch {
    Write-Error "Failed to save report: $($_.Exception.Message)"
}

# Display summary
Write-Host "`n=== SUMMARY ===" -ForegroundColor Yellow
Write-Host "Total files scanned: $(
    $totalCount = 0
    foreach ($scanDir in $ScanDirectories) {
        $scanPath = Join-Path $RootPath $scanDir
        if (Test-Path $scanPath) {
            foreach ($ext in $FileExtensions) {
                $files = Get-ChildItem -Path $scanPath -Filter $ext -Recurse -File -ErrorAction SilentlyContinue
                $totalCount += $files.Count
            }
        }
    }
    $totalCount
)"
Write-Host "Missing references found: $($missingReferences.Count)" -ForegroundColor $(if ($missingReferences.Count -eq 0) { "Green" } else { "Red" })

if ($missingReferences.Count -gt 0) {
    Write-Host "`nMissing files:" -ForegroundColor Red
    $missingReferences | ForEach-Object {
        Write-Host "  $($_.ReferencedFile) (referenced in $([System.IO.Path]::GetFileName($_.SourceFile)))" -ForegroundColor Red
    }
}

Write-Host "`nValidation complete!" -ForegroundColor Yellow
