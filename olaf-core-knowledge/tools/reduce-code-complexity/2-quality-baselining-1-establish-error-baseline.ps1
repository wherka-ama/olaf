#!/usr/bin/env pwsh

<#
.SYNOPSIS
    Establishes error baseline for code quality assessment by running static analysis and capturing current errors/warnings.

.DESCRIPTION
    This script performs static analysis on the target codebase to establish a baseline of existing errors, warnings, and code quality issues.
    It identifies the project type and runs appropriate static analysis tools to capture the current state.

.PARAMETER ProjectPath
    Path to the target project directory.

.PARAMETER OutputPath
    Path where the error baseline results will be saved.

.PARAMETER ProjectType
    Type of project (detected from discovery phase).

.PARAMETER IncludeWarnings
    Include warnings in the baseline (default: true).

.EXAMPLE
    .\2-quality-baselining-1-establish-error-baseline.ps1 -ProjectPath "C:\MyProject" -OutputPath "C:\Results" -ProjectType "nodejs"
#>

param(
    [Parameter(Mandatory = $true)]
    [string]$ProjectPath,
    
    [Parameter(Mandatory = $true)]
    [string]$OutputPath,
    
    [Parameter(Mandatory = $true)]
    [string]$ProjectType,
    
    [Parameter(Mandatory = $false)]
    [bool]$IncludeWarnings = $true
)

# Initialize result structure
$ErrorBaseline = @{
    timestamp = Get-Date -Format "YYYYMMDDTHH:mm:ssZ"
    project_path = $ProjectPath
    project_type = $ProjectType
    analysis_summary = @{
        total_errors = 0
        total_warnings = 0
        critical_issues = 0
        static_analysis_tools = @()
    }
    error_categories = @{
        syntax_errors = @()
        type_errors = @()
        security_issues = @()
        performance_warnings = @()
        style_violations = @()
        complexity_warnings = @()
    }
    file_analysis = @()
    recommendations = @()
}

function Write-StatusMessage {
    param([string]$Message, [string]$Type = "INFO")
    $timestamp = Get-Date -Format "HH:mm:ss"
    Write-Host "[$timestamp] [$Type] $Message" -ForegroundColor $(
        switch ($Type) {
            "ERROR" { "Red" }
            "WARNING" { "Yellow" }
            "SUCCESS" { "Green" }
            default { "White" }
        }
    )
}

function Test-ProjectPath {
    if (-not (Test-Path $ProjectPath)) {
        Write-StatusMessage "Project path does not exist: $ProjectPath" "ERROR"
        return $false
    }
    return $true
}

function Get-StaticAnalysisTools {
    param([string]$ProjectType)
    
    $tools = @()
    
    switch ($ProjectType.ToLower()) {
        "nodejs" {
            $tools += @{
                name = "ESLint"
                command = "npx eslint"
                args = ". --format json --output-file eslint-results.json"
                output_file = "eslint-results.json"
            }
            if (Test-Path "$ProjectPath\tsconfig.json") {
                $tools += @{
                    name = "TypeScript"
                    command = "npx tsc"
                    args = "--noEmit --listFiles"
                    output_file = "tsc-results.txt"
                }
            }
        }
        "python" {
            $tools += @{
                name = "Flake8"
                command = "flake8"
                args = ". --format=json --output-file flake8-results.json"
                output_file = "flake8-results.json"
            }
            $tools += @{
                name = "Pylint"
                command = "pylint"
                args = ". --output-format=json --output pylint-results.json"
                output_file = "pylint-results.json"
            }
        }
        "java" {
            $tools += @{
                name = "SpotBugs"
                command = "mvn"
                args = "spotbugs:spotbugs"
                output_file = "target/spotbugsXml.xml"
            }
            $tools += @{
                name = "PMD"
                command = "mvn"
                args = "pmd:pmd"
                output_file = "target/pmd.xml"
            }
        }
        "dotnet" {
            $tools += @{
                name = "Roslyn Analyzers"
                command = "dotnet"
                args = "build --verbosity normal"
                output_file = "build-output.txt"
            }
        }
        "go" {
            $tools += @{
                name = "Go Vet"
                command = "go"
                args = "vet ./..."
                output_file = "go-vet-results.txt"
            }
            $tools += @{
                name = "Golint"
                command = "golint"
                args = "./..."
                output_file = "golint-results.txt"
            }
        }
        "rust" {
            $tools += @{
                name = "Clippy"
                command = "cargo"
                args = "clippy --message-format=json"
                output_file = "clippy-results.json"
            }
        }
        default {
            Write-StatusMessage "No static analysis tools configured for project type: $ProjectType" "WARNING"
        }
    }
    
    return $tools
}

function Invoke-StaticAnalysis {
    param([array]$Tools)
    
    Write-StatusMessage "Running static analysis tools..." "INFO"
    
    foreach ($tool in $Tools) {
        Write-StatusMessage "Running $($tool.name)..." "INFO"
        
        try {
            $result = & $tool.command.Split()[0] $tool.args.Split() 2>&1
            
            if ($LASTEXITCODE -eq 0) {
                Write-StatusMessage "$($tool.name) completed successfully" "SUCCESS"
                $ErrorBaseline.analysis_summary.static_analysis_tools += $tool.name
            } else {
                Write-StatusMessage "$($tool.name) found issues (exit code: $LASTEXITCODE)" "WARNING"
                $ErrorBaseline.analysis_summary.static_analysis_tools += $tool.name
            }
            
            # Process tool output
            if (Test-Path $tool.output_file) {
                $content = Get-Content $tool.output_file -Raw
                Parse-ToolOutput -ToolName $tool.name -Content $content
            }
        } catch {
            Write-StatusMessage "Error running $($tool.name): $($_.Exception.Message)" "ERROR"
        }
    }
}

function Parse-ToolOutput {
    param([string]$ToolName, [string]$Content)
    
    # Parse different tool outputs and categorize issues
    switch ($ToolName) {
        "ESLint" {
            try {
                $eslintResults = $Content | ConvertFrom-Json
                foreach ($file in $eslintResults) {
                    foreach ($message in $file.messages) {
                        $issue = @{
                            file = $file.filePath
                            line = $message.line
                            column = $message.column
                            severity = $message.severity
                            message = $message.message
                            rule = $message.ruleId
                            tool = "ESLint"
                        }
                        
                        if ($message.severity -eq 2) {
                            $ErrorBaseline.error_categories.syntax_errors += $issue
                            $ErrorBaseline.analysis_summary.total_errors++
                        } elseif ($message.severity -eq 1 -and $IncludeWarnings) {
                            $ErrorBaseline.error_categories.style_violations += $issue
                            $ErrorBaseline.analysis_summary.total_warnings++
                        }
                    }
                }
            } catch {
                Write-StatusMessage "Error parsing ESLint output: $($_.Exception.Message)" "ERROR"
            }
        }
        "Flake8" {
            # Parse Flake8 JSON output
            try {
                $flake8Results = $Content | ConvertFrom-Json
                foreach ($file in $flake8Results.PSObject.Properties) {
                    foreach ($issue in $file.Value) {
                        $ErrorBaseline.error_categories.style_violations += @{
                            file = $file.Name
                            line = $issue.line_number
                            column = $issue.column_number
                            message = $issue.text
                            code = $issue.code
                            tool = "Flake8"
                        }
                        $ErrorBaseline.analysis_summary.total_warnings++
                    }
                }
            } catch {
                Write-StatusMessage "Error parsing Flake8 output: $($_.Exception.Message)" "ERROR"
            }
        }
        default {
            # Generic parsing for other tools
            $lines = $Content -split "`n"
            foreach ($line in $lines) {
                if ($line -match "error|Error|ERROR") {
                    $ErrorBaseline.analysis_summary.total_errors++
                } elseif ($line -match "warning|Warning|WARNING") {
                    $ErrorBaseline.analysis_summary.total_warnings++
                }
            }
        }
    }
}

function Generate-FileAnalysis {
    Write-StatusMessage "Generating file-level analysis..." "INFO"
    
    $sourceFiles = Get-ChildItem -Path $ProjectPath -Recurse -Include "*.js", "*.ts", "*.py", "*.java", "*.cs", "*.go", "*.rs" | 
                   Where-Object { $_.FullName -notmatch "node_modules|\.git|target|bin|obj" }
    
    foreach ($file in $sourceFiles) {
        $content = Get-Content $file.FullName -Raw -ErrorAction SilentlyContinue
        if ($content) {
            $lineCount = ($content -split "`n").Length
            $ErrorBaseline.file_analysis += @{
                file = $file.FullName.Replace($ProjectPath, "").Replace("\", "/")
                lines_of_code = $lineCount
                file_size = $file.Length
                last_modified = $file.LastWriteTime.ToString("YYYYMMDDTHH:mm:ssZ")
                issues_found = ($ErrorBaseline.error_categories.PSObject.Properties | 
                              ForEach-Object { $_.Value } | 
                              Where-Object { $_.file -like "*$($file.BaseName)*" }).Count
            }
        }
    }
}

function Generate-Recommendations {
    Write-StatusMessage "Generating recommendations..." "INFO"
    
    $totalIssues = $ErrorBaseline.analysis_summary.total_errors + $ErrorBaseline.analysis_summary.total_warnings
    
    if ($totalIssues -eq 0) {
        $ErrorBaseline.recommendations += "Excellent! No static analysis issues found. Consider adding more comprehensive analysis tools."
    } else {
        if ($ErrorBaseline.analysis_summary.total_errors -gt 0) {
            $ErrorBaseline.recommendations += "Priority 1: Fix all syntax and critical errors ($($ErrorBaseline.analysis_summary.total_errors) found)"
        }
        
        if ($ErrorBaseline.analysis_summary.total_warnings -gt 50) {
            $ErrorBaseline.recommendations += "Priority 2: Address high number of warnings ($($ErrorBaseline.analysis_summary.total_warnings) found)"
        }
        
        $ErrorBaseline.recommendations += "Consider setting up continuous integration with static analysis tools"
        $ErrorBaseline.recommendations += "Establish coding standards and style guidelines for the team"
    }
}

# Main execution
Write-StatusMessage "Starting error baseline establishment..." "INFO"

if (-not (Test-ProjectPath)) {
    exit 1
}

# Change to project directory
Push-Location $ProjectPath

try {
    # Get and run static analysis tools
    $tools = Get-StaticAnalysisTools -ProjectType $ProjectType
    
    if ($tools.Count -eq 0) {
        Write-StatusMessage "No static analysis tools available for project type: $ProjectType" "WARNING"
    } else {
        Invoke-StaticAnalysis -Tools $tools
    }
    
    # Generate file-level analysis
    Generate-FileAnalysis
    
    # Generate recommendations
    Generate-Recommendations
    
    # Save results
    $outputFile = Join-Path $OutputPath "2-quality-baselining-1-error-baseline.json"
    $ErrorBaseline | ConvertTo-Json -Depth 10 | Out-File $outputFile -Encoding UTF8
    
    Write-StatusMessage "Error baseline saved to: $outputFile" "SUCCESS"
    Write-StatusMessage "Analysis complete - Errors: $($ErrorBaseline.analysis_summary.total_errors), Warnings: $($ErrorBaseline.analysis_summary.total_warnings)" "INFO"
    
} catch {
    Write-StatusMessage "Error during analysis: $($_.Exception.Message)" "ERROR"
    exit 1
} finally {
    Pop-Location
}

exit 0
