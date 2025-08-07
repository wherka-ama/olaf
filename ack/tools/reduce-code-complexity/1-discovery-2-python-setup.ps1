# Python Environment Setup Script (Phase 0.1.2)

param(
    [Parameter(Mandatory=$true)]
    [string]$ProjectDetectionFile
)

# Read detection results
if (Test-Path $ProjectDetectionFile) {
    $detection = Get-Content $ProjectDetectionFile | ConvertFrom-Json
} else {
    Write-Error "$($ProjectDetectionFile) not found. Run Phase 0.1.1 first."
    exit 1
}
# No emoji or emoticons in output

Write-Host "Setting up Python environment..."

# Read detection results
if (Test-Path "project-detection.json") {
    $detection = Get-Content "project-detection.json" | ConvertFrom-Json
    Write-Host "Project language: $($detection.PrimaryLanguage)"
} else {
    Write-Error "project-detection.json not found. Run Phase 0.1.1 first."
    exit 1
}

# Step 1: Verify Python
Write-Host "Checking Python installation..."
try {
    $pythonVersion = python --version 2>&1
    Write-Host "Python version: $pythonVersion"
} catch {
    Write-Host "Python not installed. Please install Python 3.8 or higher."
    exit 1
}

# Step 2: Install Dependencies
if (Test-Path "requirements.txt") {
    Write-Host "Installing dependencies from requirements.txt..."
    python -m pip install -r requirements.txt
    if ($LASTEXITCODE -ne 0) { Write-Host "Dependency installation failed."; exit 1 }
} else {
    Write-Host "requirements.txt not found. Skipping dependency installation."
}

# Step 3: Generate Environment Report
$report = @{
    "phase" = "0.1.2-python"
    "timestamp" = (Get-Date).ToString("YYYYMMDD HH:mm:ss")
    "pythonVersion" = $pythonVersion
    "requirementsExists" = (Test-Path "requirements.txt")
    "dependenciesInstalled" = $true
}
$report | ConvertTo-Json -Depth 3 | Out-File "environment-python-report.json"
Write-Host "Environment report saved to: environment-python-report.json"
