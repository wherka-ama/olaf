# Log-to-Source Mapping Script
# Analyzes codebase to create mapping between log entries and source files

param(
    [Parameter(Mandatory=$true)]
    [string]$CodebasePath,
    
    [Parameter(Mandatory=$false)]
    [string]$LogFile = "",
    
    [Parameter(Mandatory=$false)]
    [string]$OutputPath = "log-source-mapping.json",
    
    [Parameter(Mandatory=$false)]
    [string[]]$FileExtensions = @("*.js", "*.ts", "*.cs", "*.java", "*.py", "*.php", "*.rb", "*.go", "*.cpp", "*.c"),
    
    [Parameter(Mandatory=$false)]
    [string[]]$LogPatterns = @(
        "console\.log\s*\(",
        "console\.error\s*\(",
        "console\.warn\s*\(",
        "console\.info\s*\(",
        "logger\.info\s*\(",
        "logger\.error\s*\(",
        "logger\.warn\s*\(",
        "logger\.debug\s*\(",
        "log\.info\s*\(",
        "log\.error\s*\(",
        "System\.out\.println\s*\(",
        "System\.err\.println\s*\(",
        "Log\.Information\s*\(",
        "Log\.Error\s*\(",
        "Log\.Warning\s*\(",
        "_logger\.Log\w+\s*\(",
        "print\s*\(",
        "puts\s+",
        "fmt\.Print\w*\s*\(",
        "std::cout\s*<<"
    )
)

Write-Host "Starting log-to-source mapping analysis..." -ForegroundColor Green
Write-Host "Codebase Path: $CodebasePath" -ForegroundColor Yellow
Write-Host "Output Path: $OutputPath" -ForegroundColor Yellow

# Initialize results structure
$mappingResults = @{
    "timestamp" = Get-Date -Format "YYYYMMDD HH:mm:ss"
    "codebase_path" = $CodebasePath
    "log_file" = $LogFile
    "source_mappings" = @()
    "log_patterns_found" = @()
    "reverse_lookup" = @{}
    "summary" = @{
        "files_scanned" = 0
        "log_statements_found" = 0
        "unique_patterns" = 0
    }
}

# Function to extract log message from a line
function Extract-LogMessage {
    param([string]$line, [string]$pattern)
    
    $match = [regex]::Match($line, $pattern + "(.+)")
    if ($match.Success) {
        $logContent = $match.Groups[1].Value
        # Clean up the log content - remove quotes, parentheses, etc.
        $logContent = $logContent -replace '^\s*[\(\"\'']*', '' -replace '[\)\"\'']*\s*;?\s*$', ''
        # Handle template literals and variable interpolation
        $logContent = $logContent -replace '\$\{[^}]+\}', '{VARIABLE}' -replace '\+\s*\w+', '+{VARIABLE}'
        return $logContent.Trim()
    }
    return $null
}

# Function to scan a single file
function Scan-SourceFile {
    param([string]$filePath)
    
    try {
        $content = Get-Content -Path $filePath -ErrorAction Stop
        $fileResults = @()
        
        for ($lineNumber = 1; $lineNumber -le $content.Length; $lineNumber++) {
            $line = $content[$lineNumber - 1]
            
            foreach ($pattern in $LogPatterns) {
                if ($line -match $pattern) {
                    $logMessage = Extract-LogMessage -line $line -pattern $pattern
                    
                    if ($logMessage) {
                        $logEntry = @{
                            "file_path" = $filePath
                            "line_number" = $lineNumber
                            "pattern_type" = $pattern
                            "original_line" = $line.Trim()
                            "extracted_message" = $logMessage
                            "message_hash" = [System.Security.Cryptography.SHA256]::Create().ComputeHash([System.Text.Encoding]::UTF8.GetBytes($logMessage)) | ForEach-Object { $_.ToString("x2") } | Join-String
                        }
                        
                        $fileResults += $logEntry
                        $mappingResults.summary.log_statements_found++
                        
                        # Add to reverse lookup
                        $key = $logMessage.ToLower()
                        if (-not $mappingResults.reverse_lookup.ContainsKey($key)) {
                            $mappingResults.reverse_lookup[$key] = @()
                        }
                        $mappingResults.reverse_lookup[$key] += $logEntry
                    }
                }
            }
        }
        
        if ($fileResults.Count -gt 0) {
            $mappingResults.source_mappings += @{
                "file_path" = $filePath
                "log_entries" = $fileResults
                "entry_count" = $fileResults.Count
            }
        }
        
        $mappingResults.summary.files_scanned++
        Write-Progress -Activity "Scanning files" -Status "Processed: $filePath" -PercentComplete (($mappingResults.summary.files_scanned / 100) * 100)
        
    } catch {
        Write-Warning "Error scanning file $filePath`: $($_.Exception.Message)"
    }
}

# Function to analyze actual log file if provided
function Analyze-LogFile {
    param([string]$logFilePath)
    
    if (-not (Test-Path $logFilePath)) {
        Write-Warning "Log file not found: $logFilePath"
        return
    }
    
    Write-Host "Analyzing log file: $logFilePath" -ForegroundColor Yellow
    $logContent = Get-Content -Path $logFilePath
    $logAnalysis = @()
    
    foreach ($logLine in $logContent) {
        # Try to match log line with known patterns
        $matches = @()
        
        foreach ($key in $mappingResults.reverse_lookup.Keys) {
            if ($logLine -like "*$key*") {
                $matches += @{
                    "matched_pattern" = $key
                    "source_locations" = $mappingResults.reverse_lookup[$key]
                    "confidence" = "High"
                }
            }
        }
        
        if ($matches.Count -gt 0) {
            $logAnalysis += @{
                "log_line" = $logLine
                "timestamp" = [regex]::Match($logLine, '\d{4}-\d{2}-\d{2}[\sT]\d{2}:\d{2}:\d{2}').Value
                "matches" = $matches
            }
        }
    }
    
    $mappingResults["log_analysis"] = $logAnalysis
}

# Main execution
try {
    if (-not (Test-Path $CodebasePath)) {
        throw "Codebase path does not exist: $CodebasePath"
    }
    
    Write-Host "Scanning codebase for logging statements..." -ForegroundColor Green
    
    # Get all files matching the specified extensions
    $allFiles = @()
    foreach ($extension in $FileExtensions) {
        $files = Get-ChildItem -Path $CodebasePath -Filter $extension -Recurse -File
        $allFiles += $files
    }
    
    Write-Host "Found $($allFiles.Count) files to scan" -ForegroundColor Yellow
    
    # Scan each file
    foreach ($file in $allFiles) {
        Scan-SourceFile -filePath $file.FullName
    }
    
    # Analyze log file if provided
    if ($LogFile -and (Test-Path $LogFile)) {
        Analyze-LogFile -logFilePath $LogFile
    }
    
    # Calculate summary statistics
    $mappingResults.summary.unique_patterns = ($mappingResults.reverse_lookup.Keys | Measure-Object).Count
    
    # Save results to JSON
    $jsonOutput = $mappingResults | ConvertTo-Json -Depth 10
    $jsonOutput | Out-File -FilePath $OutputPath -Encoding UTF8
    
    # Display summary
    Write-Host "`n=== ANALYSIS COMPLETE ===" -ForegroundColor Green
    Write-Host "Files Scanned: $($mappingResults.summary.files_scanned)" -ForegroundColor Cyan
    Write-Host "Log Statements Found: $($mappingResults.summary.log_statements_found)" -ForegroundColor Cyan
    Write-Host "Unique Log Patterns: $($mappingResults.summary.unique_patterns)" -ForegroundColor Cyan
    Write-Host "Results saved to: $OutputPath" -ForegroundColor Cyan
    
    # Show top files with most logging
    $topFiles = $mappingResults.source_mappings | Sort-Object entry_count -Descending | Select-Object -First 5
    if ($topFiles.Count -gt 0) {
        Write-Host "`nTop files with most logging:" -ForegroundColor Yellow
        foreach ($file in $topFiles) {
            Write-Host "  $($file.file_path): $($file.entry_count) statements" -ForegroundColor White
        }
    }
    
    if ($mappingResults.ContainsKey("log_analysis")) {
        $matchedLines = ($mappingResults.log_analysis | Measure-Object).Count
        Write-Host "`nLog Analysis Results: $matchedLines log lines matched to source code" -ForegroundColor Green
    }
    
} catch {
    Write-Error "Script execution failed: $($_.Exception.Message)"
    exit 1
}

Write-Host "`nUse the generated mapping file with troubleshoot-logs-to-sources.md prompt for guided analysis." -ForegroundColor Green
