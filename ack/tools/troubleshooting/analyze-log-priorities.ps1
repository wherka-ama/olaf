# Log Priority Analysis Script
# Parses log files to identify and prioritize critical errors, warnings, and exceptions

param(
    [Parameter(Mandatory=$true)]
    [string]$LogFile,
    
    [Parameter(Mandatory=$false)]
    [string]$OutputPath = "log-priorities-analysis.json",
    
    [Parameter(Mandatory=$false)]
    [string]$TimeRange = "",
    
    [Parameter(Mandatory=$false)]
    [int]$MaxResults = 50,
    
    [Parameter(Mandatory=$false)]
    [string[]]$SeverityPatterns = @(
        "FATAL|CRITICAL|SEVERE",
        "ERROR|EXCEPTION|FAIL",
        "WARN|WARNING|CAUTION",
        "INFO|INFORMATION|NOTICE",
        "DEBUG|TRACE|VERBOSE"
    )
)

Write-Host "Starting log priority analysis..." -ForegroundColor Green
Write-Host "Log File: $LogFile" -ForegroundColor Yellow
Write-Host "Output Path: $OutputPath" -ForegroundColor Yellow

# Initialize results structure
$priorityResults = @{
    "timestamp" = Get-Date -Format "YYYYMMDD HH:mm:ss"
    "log_file" = $LogFile
    "time_range" = $TimeRange
    "analysis_summary" = @{
        "total_lines_processed" = 0
        "critical_issues" = 0
        "errors" = 0
        "warnings" = 0
        "info_messages" = 0
        "debug_messages" = 0
    }
    "prioritized_issues" = @()
    "severity_distribution" = @{}
    "frequency_analysis" = @{}
    "timeline_analysis" = @()
}

# Severity level mapping
$severityLevels = @{
    "FATAL" = 5; "CRITICAL" = 5; "SEVERE" = 5
    "ERROR" = 4; "EXCEPTION" = 4; "FAIL" = 4
    "WARN" = 3; "WARNING" = 3; "CAUTION" = 3
    "INFO" = 2; "INFORMATION" = 2; "NOTICE" = 2
    "DEBUG" = 1; "TRACE" = 1; "VERBOSE" = 1
}

# Function to extract timestamp from log line
function Extract-Timestamp {
    param([string]$line)
    
    # Common timestamp patterns
    $patterns = @(
        '\d{4}-\d{2}-\d{2}[\sT]\d{2}:\d{2}:\d{2}(?:\.\d{3})?',
        '\d{2}/\d{2}/\d{4} \d{2}:\d{2}:\d{2}',
        '\d{2}-\d{2}-\d{4} \d{2}:\d{2}:\d{2}',
        '\w{3} \d{2} \d{2}:\d{2}:\d{2}'
    )
    
    foreach ($pattern in $patterns) {
        $match = [regex]::Match($line, $pattern)
        if ($match.Success) {
            try {
                return [DateTime]::Parse($match.Value)
            } catch {
                continue
            }
        }
    }
    return $null
}

# Function to detect severity level
function Get-SeverityLevel {
    param([string]$line)
    
    $line = $line.ToUpper()
    
    foreach ($level in $severityLevels.Keys) {
        if ($line -match "\b$level\b") {
            return @{
                "level" = $level
                "numeric_value" = $severityLevels[$level]
            }
        }
    }
    
    return @{
        "level" = "UNKNOWN"
        "numeric_value" = 0
    }
}

# Function to extract exception/error details
function Extract-ErrorDetails {
    param([string]$line)
    
    $details = @{
        "exception_type" = $null
        "error_message" = $null
        "stack_trace" = $false
        "method_name" = $null
        "file_reference" = $null
    }
    
    # Exception type patterns
    if ($line -match '(\w+Exception|\w+Error)') {
        $details.exception_type = $matches[1]
    }
    
    # Method/function references
    if ($line -match '(\w+\.\w+\([^)]*\))') {
        $details.method_name = $matches[1]
    }
    
    # File references with line numbers
    if ($line -match '(\w+\.(js|ts|cs|java|py|php|rb|go|cpp|c))(:?\d+)?') {
        $details.file_reference = $matches[0]
    }
    
    # Stack trace indicator
    if ($line -match '(at |in |line \d+|stack trace|\s+at\s+)') {
        $details.stack_trace = $true
    }
    
    return $details
}

# Function to generate issue hash for deduplication
function Get-IssueHash {
    param([string]$message, [string]$severity)
    
    # Clean message for hashing (remove timestamps, specific values)
    $cleanMessage = $message -replace '\d{4}-\d{2}-\d{2}[\sT]\d{2}:\d{2}:\d{2}(?:\.\d{3})?', 'TIMESTAMP'
    $cleanMessage = $cleanMessage -replace '\d+', 'NUMBER'
    $cleanMessage = $cleanMessage -replace '"[^"]*"', 'STRING'
    
    $hashInput = "$severity|$cleanMessage"
    $hash = [System.Security.Cryptography.SHA256]::Create().ComputeHash([System.Text.Encoding]::UTF8.GetBytes($hashInput))
    return ($hash | ForEach-Object { $_.ToString("x2") } | Join-String).Substring(0, 12)
}

# Main processing function
function Process-LogFile {
    try {
        if (-not (Test-Path $LogFile)) {
            throw "Log file not found: $LogFile"
        }
        
        Write-Host "Reading log file..." -ForegroundColor Yellow
        $logContent = Get-Content -Path $LogFile -ErrorAction Stop
        $priorityResults.analysis_summary.total_lines_processed = $logContent.Length
        
        $issueTracker = @{}
        $timelineData = @{}
        
        Write-Host "Analyzing $($logContent.Length) log lines..." -ForegroundColor Yellow
        
        for ($i = 0; $i -lt $logContent.Length; $i++) {
            $line = $logContent[$i]
            
            # Progress indicator
            if ($i % 1000 -eq 0) {
                $progress = [math]::Round(($i / $logContent.Length) * 100, 1)
                Write-Progress -Activity "Analyzing log entries" -Status "$progress% Complete" -PercentComplete $progress
            }
            
            $severity = Get-SeverityLevel -line $line
            $timestamp = Extract-Timestamp -line $line
            
            # Update summary counters
            switch ($severity.level) {
                { $_ -in @("FATAL", "CRITICAL", "SEVERE") } { $priorityResults.analysis_summary.critical_issues++ }
                { $_ -in @("ERROR", "EXCEPTION", "FAIL") } { $priorityResults.analysis_summary.errors++ }
                { $_ -in @("WARN", "WARNING", "CAUTION") } { $priorityResults.analysis_summary.warnings++ }
                { $_ -in @("INFO", "INFORMATION", "NOTICE") } { $priorityResults.analysis_summary.info_messages++ }
                { $_ -in @("DEBUG", "TRACE", "VERBOSE") } { $priorityResults.analysis_summary.debug_messages++ }
            }
            
            # Process high-priority issues (severity 3 and above)
            if ($severity.numeric_value -ge 3) {
                $errorDetails = Extract-ErrorDetails -line $line
                $issueHash = Get-IssueHash -message $line -severity $severity.level
                
                if ($issueTracker.ContainsKey($issueHash)) {
                    # Update existing issue
                    $issueTracker[$issueHash].frequency++
                    $issueTracker[$issueHash].last_occurrence = $timestamp
                    $issueTracker[$issueHash].sample_lines += $line
                } else {
                    # Create new issue entry
                    $issueTracker[$issueHash] = @{
                        "hash" = $issueHash
                        "severity" = $severity.level
                        "numeric_severity" = $severity.numeric_value
                        "first_occurrence" = $timestamp
                        "last_occurrence" = $timestamp
                        "frequency" = 1
                        "sample_lines" = @($line)
                        "error_details" = $errorDetails
                        "line_numbers" = @($i + 1)
                    }
                }
                
                # Timeline analysis
                if ($timestamp) {
                    $hourKey = $timestamp.ToString("YYYYMMDD HH:00")
                    if (-not $timelineData.ContainsKey($hourKey)) {
                        $timelineData[$hourKey] = 0
                    }
                    $timelineData[$hourKey]++
                }
            }
        }
        
        Write-Progress -Activity "Analyzing log entries" -Completed
        
        # Convert issue tracker to prioritized list
        $sortedIssues = $issueTracker.Values | Sort-Object @{Expression={$_.numeric_severity}; Descending=$true}, @{Expression={$_.frequency}; Descending=$true}
        
        # Take top MaxResults
        $priorityResults.prioritized_issues = $sortedIssues | Select-Object -First $MaxResults
        
        # Generate severity distribution
        foreach ($issue in $sortedIssues) {
            if (-not $priorityResults.severity_distribution.ContainsKey($issue.severity)) {
                $priorityResults.severity_distribution[$issue.severity] = 0
            }
            $priorityResults.severity_distribution[$issue.severity]++
        }
        
        # Generate timeline analysis
        $priorityResults.timeline_analysis = $timelineData.GetEnumerator() | Sort-Object Name | ForEach-Object {
            @{
                "time_period" = $_.Key
                "issue_count" = $_.Value
            }
        }
        
    } catch {
        Write-Error "Error processing log file: $($_.Exception.Message)"
        throw
    }
}

# Execute main processing
try {
    Process-LogFile
    
    # Save results to JSON
    $jsonOutput = $priorityResults | ConvertTo-Json -Depth 10
    $jsonOutput | Out-File -FilePath $OutputPath -Encoding UTF8
    
    # Display summary
    Write-Host "`n=== LOG PRIORITY ANALYSIS COMPLETE ===" -ForegroundColor Green
    Write-Host "Total Lines Processed: $($priorityResults.analysis_summary.total_lines_processed)" -ForegroundColor Cyan
    Write-Host "Critical Issues: $($priorityResults.analysis_summary.critical_issues)" -ForegroundColor Red
    Write-Host "Errors: $($priorityResults.analysis_summary.errors)" -ForegroundColor Red
    Write-Host "Warnings: $($priorityResults.analysis_summary.warnings)" -ForegroundColor Yellow
    Write-Host "Unique High-Priority Issues Found: $($priorityResults.prioritized_issues.Count)" -ForegroundColor Cyan
    Write-Host "Results saved to: $OutputPath" -ForegroundColor Cyan
    
    # Display top issues
    if ($priorityResults.prioritized_issues.Count -gt 0) {
        Write-Host "`n=== TOP PRIORITY ISSUES ===" -ForegroundColor Yellow
        for ($i = 0; $i -lt [math]::Min(10, $priorityResults.prioritized_issues.Count); $i++) {
            $issue = $priorityResults.prioritized_issues[$i]
            $sampleLine = $issue.sample_lines[0]
            if ($sampleLine.Length -gt 100) {
                $sampleLine = $sampleLine.Substring(0, 100) + "..."
            }
            
            Write-Host "[$($i+1)] $($issue.severity) - $($issue.frequency) occurrences" -ForegroundColor White
            Write-Host "    Sample: $sampleLine" -ForegroundColor Gray
            if ($issue.error_details.exception_type) {
                Write-Host "    Exception: $($issue.error_details.exception_type)" -ForegroundColor Red
            }
            if ($issue.error_details.file_reference) {
                Write-Host "    File: $($issue.error_details.file_reference)" -ForegroundColor Cyan
            }
            Write-Host ""
        }
    }
    
} catch {
    Write-Error "Script execution failed: $($_.Exception.Message)"
    exit 1
}

Write-Host "Use the generated priority analysis with the log troubleshooting orchestrator for targeted analysis." -ForegroundColor Green
