# Go Environment Setup Script (Phase 0.1.2)

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

Write-Host "Setting up Go environment..."

# Read detection results
if (Test-Path "project-detection.json") {
    $detection = Get-Content "project-detection.json" | ConvertFrom-Json
    Write-Host "Project language: $($detection.PrimaryLanguage)"
} else {
    Write-Error "project-detection.json not found. Run Phase 0.1.1 first."
    exit 1
}

# Step 1: Verify Go
Write-Host "Checking Go installation..."
try {
    $goVersion = go version 2>&1
    Write-Host $goVersion
} catch {
    Write-Host "Go not installed. Please install Go 1.16 or higher."
    exit 1
}

# Step 2: Install Dependencies
if (Test-Path "go.mod") {
    Write-Host "Installing Go dependencies..."
    go mod download
    if ($LASTEXITCODE -ne 0) { Write-Host "Dependency installation failed."; exit 1 }
} else {
    Write-Host "go.mod not found. Skipping dependency installation."
}

# Step 3: Generate Environment Report
$report = @{
    "phase" = "0.1.2-go"
    "timestamp" = (Get-Date).ToString("YYYYMMDD HH:mm:ss")
    "goVersion" = $goVersion
    "goModExists" = (Test-Path "go.mod")
    "dependenciesInstalled" = $true
}
$report | ConvertTo-Json -Depth 3 | Out-File "environment-go-report.json"
Write-Host "Environment report saved to: environment-go-report.json"
