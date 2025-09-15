# Rust Environment Setup Script (Phase 0.1.2)

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

Write-Host "Setting up Rust environment..."

# Read detection results
if (Test-Path "project-detection.json") {
    $detection = Get-Content "project-detection.json" | ConvertFrom-Json
    Write-Host "Project language: $($detection.PrimaryLanguage)"
} else {
    Write-Error "project-detection.json not found. Run Phase 0.1.1 first."
    exit 1
}

# Step 1: Verify Rust
Write-Host "Checking Rust installation..."
try {
    $rustVersion = rustc --version 2>&1
    Write-Host $rustVersion
} catch {
    Write-Host "Rust not installed. Please install Rust 1.56 or higher."
    exit 1
}

# Step 2: Install Dependencies
if (Test-Path "Cargo.toml") {
    Write-Host "Installing Rust dependencies..."
    cargo fetch
    if ($LASTEXITCODE -ne 0) { Write-Host "Dependency installation failed."; exit 1 }
} else {
    Write-Host "Cargo.toml not found. Skipping dependency installation."
}

# Step 3: Generate Environment Report
$report = @{
    "phase" = "0.1.2-rust"
    "timestamp" = (Get-Date).ToString("YYYYMMDD HH:mm:ss")
    "rustVersion" = $rustVersion
    "cargoTomlExists" = (Test-Path "Cargo.toml")
    "dependenciesInstalled" = $true
}
$report | ConvertTo-Json -Depth 3 | Out-File "environment-rust-report.json"
Write-Host "Environment report saved to: environment-rust-report.json"
