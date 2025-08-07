<#
.SYNOPSIS
    Performs comprehensive complexity analysis by chaining cyclomatic complexity and Halstead metrics analysis.

.DESCRIPTION
    This script orchestrates complexity analysis by calling both analyze-cyclomatic-complexity.ps1 
    and analyze-halstead-metrics.ps1 in sequence, then consolidates their outputs into a unified JSON report.

.PARAMETER ProjectPath
    Path to the target project directory.

.PARAMETER OutputPath
    Path where the consolidated complexity analysis results will be saved.

.PARAMETER GitAnalysisFile
    Path to git analysis results file for correlation.

.PARAMETER ProjectType
    Type of project for tool selection.

.EXAMPLE
    .\4-quality-analysis-2-analyze-complexity.ps1 -ProjectPath "C:\MyProject" -OutputPath "C:\Results\complexity.json" -GitAnalysisFile "C:\Results\git-analysis.json" -ProjectType "nodejs"
#>

param(
    [Parameter(Mandatory = $true)]
    [string]$ProjectPath,
    
    [Parameter(Mandatory = $true)]
    [string]$OutputPath,
    
    [Parameter(Mandatory = $true)]
    [string]$GitAnalysisFile,
    
    [Parameter(Mandatory = $true)]
    [string]$ProjectType
)

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

try {
    Write-StatusMessage "Starting comprehensive complexity analysis..." "INFO"
    
    # Validate inputs
    if (-not (Test-Path $ProjectPath)) {
        throw "Project path does not exist: $ProjectPath"
    }
    
    # Determine script directory
    $scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
    $projectRoot = Split-Path -Parent (Split-Path -Parent $scriptDir)
    $commonsQualityDir = Join-Path $projectRoot "tools\commons\quality"
    $cyclomaticScript = Join-Path $commonsQualityDir "analyze-cyclomatic-complexity.ps1"
    $halsteadScript = Join-Path $commonsQualityDir "analyze-halstead-metrics.ps1"
    
    # Verify both scripts exist
    if (-not (Test-Path $cyclomaticScript)) {
        throw "Cyclomatic complexity script not found: $cyclomaticScript"
    }
    
    if (-not (Test-Path $halsteadScript)) {
        throw "Halstead metrics script not found: $halsteadScript"
    }
    
    # Set up output files for individual analyses
    $outputDir = Split-Path -Parent $OutputPath
    $cyclomaticOutput = Join-Path $outputDir "cyclomatic-complexity.md"
    $halsteadOutput = Join-Path $outputDir "halstead-metrics.md"
    
    # Check for files-to-be-analyzed.txt
    $filesToAnalyze = Join-Path $ProjectPath "files-to-be-analyzed.txt"
    if (-not (Test-Path $filesToAnalyze)) {
        Write-StatusMessage "files-to-be-analyzed.txt not found in project path. Scripts will scan the repository." "WARNING"
    }
    
    # Step 1: Run Cyclomatic Complexity Analysis
    Write-StatusMessage "Running cyclomatic complexity analysis..." "INFO"
    
    if (Test-Path $filesToAnalyze) {
        & $cyclomaticScript -RepoPath $ProjectPath -OutputFile $cyclomaticOutput -FilesToAnalyzeFile $filesToAnalyze
    } else {
        & $cyclomaticScript -RepoPath $ProjectPath -OutputFile $cyclomaticOutput
    }
    
    if ($LASTEXITCODE -and $LASTEXITCODE -ne 0) {
        throw "Cyclomatic complexity analysis failed with exit code: $LASTEXITCODE"
    }
    
    Write-StatusMessage "Cyclomatic complexity analysis completed" "SUCCESS"
    
    # Step 2: Run Halstead Metrics Analysis
    Write-StatusMessage "Running Halstead metrics analysis..." "INFO"
    
    if (Test-Path $filesToAnalyze) {
        & $halsteadScript -RepoPath $ProjectPath -OutputFile $halsteadOutput -FilesToAnalyzeFile $filesToAnalyze
    } else {
        & $halsteadScript -RepoPath $ProjectPath -OutputFile $halsteadOutput
    }
    
    if ($LASTEXITCODE -and $LASTEXITCODE -ne 0) {
        throw "Halstead metrics analysis failed with exit code: $LASTEXITCODE"
    }
    
    Write-StatusMessage "Halstead metrics analysis completed" "SUCCESS"
    
    # Step 3: Consolidate results into JSON format
    Write-StatusMessage "Consolidating complexity analysis results..." "INFO"
    
    # Read git analysis file if available
    $gitData = $null
    if (Test-Path $GitAnalysisFile) {
        $gitData = Get-Content $GitAnalysisFile -Raw | ConvertFrom-Json
    }
    
    # Create consolidated JSON output
    $consolidatedResults = @{
        timestamp = Get-Date -Format "YYYYMMDDTHH:mm:ssZ"
        project_path = $ProjectPath
        git_analysis_source = $GitAnalysisFile
        project_type = $ProjectType
        complexity_overview = @{
            cyclomatic_analysis_file = $cyclomaticOutput
            halstead_analysis_file = $halsteadOutput
            analysis_completed = $true
            tools_used = @("analyze-cyclomatic-complexity.ps1", "analyze-halstead-metrics.ps1")
        }
        analysis_status = @{
            cyclomatic_complexity = "completed"
            halstead_metrics = "completed"
            consolidation = "completed"
        }
        output_files = @{
            cyclomatic_complexity_report = $cyclomaticOutput
            halstead_metrics_report = $halsteadOutput
            consolidated_report = $OutputPath
        }
        git_correlation = @{
            hotspots_available = if ($gitData -and $gitData.code_hotspots) { $true } else { $false }
            hotspot_count = if ($gitData -and $gitData.code_hotspots) { $gitData.code_hotspots.Count } else { 0 }
        }
        refactoring_recommendations = @(
            @{
                priority = "high"
                source = "cyclomatic_complexity"
                recommendation = "Review cyclomatic complexity report for functions exceeding threshold"
                action_required = "Refactor high-complexity functions identified in the analysis"
            },
            @{
                priority = "medium"
                source = "halstead_metrics"
                recommendation = "Review Halstead metrics report for maintainability insights"
                action_required = "Focus on functions with high effort and difficulty scores"
            }
        )
        quality_gates = @{
            analysis_complete = $true
            reports_generated = 2
            consolidation_successful = $true
        }
    }
    
    # Save consolidated results
    $consolidatedResults | ConvertTo-Json -Depth 10 | Out-File $OutputPath -Encoding UTF8
    
    Write-StatusMessage "Complexity analysis saved to: $OutputPath" "SUCCESS"
    Write-StatusMessage "Individual reports available at:" "INFO"
    Write-StatusMessage "  - Cyclomatic Complexity: $cyclomaticOutput" "INFO"
    Write-StatusMessage "  - Halstead Metrics: $halsteadOutput" "INFO"
    Write-StatusMessage "Comprehensive complexity analysis completed successfully" "SUCCESS"
    
} catch {
    Write-StatusMessage "Error during complexity analysis: $($_.Exception.Message)" "ERROR"
    exit 1
}

exit 0