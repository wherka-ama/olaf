# Node.js Environment Setup Script (Phase 0.1.2)
# No emoji or emoticons in output

param(
    [Parameter(Mandatory=$true)]
    [string]$ProjectDetectionFile,

    [Parameter(Mandatory=$false)]
    [string]$OutputLocation = "."
)

Write-Host "Setting up Node.js environment..."

# Read detection results
if (Test-Path $ProjectDetectionFile) {
    $detection = Get-Content $ProjectDetectionFile | ConvertFrom-Json
    Write-Host "Project language: $($detection.PrimaryLanguage)"
} else {
    Write-Error "$($ProjectDetectionFile) not found. Run Phase 0.1.1 first."
    exit 1
}

# Step 1: Verify Node.js
Write-Host "Checking Node.js installation..."
try {
    $nodeVersion = node --version 2>$null
    $nodeVersionNum = $nodeVersion -replace "[vV]", ""
    if ([version]$nodeVersionNum -lt [version]"16.0.0") {
        Write-Host "Node.js version $nodeVersionNum detected. Version 16+ recommended."
    } else {
        Write-Host "Node.js version $nodeVersionNum detected."
    }
} catch {
    Write-Host "Node.js not installed. Please install Node.js 16 or higher."
    exit 1
}

# Step 2: Detect Package Manager
$packageManager = ""
if (Test-Path "pnpm-lock.yaml") {
    $packageManager = "pnpm"
} elseif (Test-Path "yarn.lock") {
    $packageManager = "yarn"
} elseif (Test-Path "package-lock.json") {
    $packageManager = "npm"
} else {
    $packageManager = "npm"
}
Write-Host "Using package manager: $packageManager"

# Step 3: Install Dependencies
Write-Host "Installing project dependencies..."
$installCmd = ""
switch ($packageManager) {
    "pnpm" { $installCmd = "pnpm install" }
    "yarn" { $installCmd = "yarn install" }
    default { $installCmd = "npm install" }
}
$startTime = Get-Date
Invoke-Expression $installCmd
if ($LASTEXITCODE -ne 0) {
    Write-Host "Dependency installation failed."
    exit 1
}
$duration = (Get-Date) - $startTime
Write-Host "Dependencies installed in $($duration.TotalSeconds) seconds."

# Step 4: Validate Environment
if (-not (Test-Path "node_modules")) {
    Write-Host "node_modules directory not found."
    exit 1
}
if (-not (Test-Path "package.json")) {
    Write-Host "package.json not found."
    exit 1
}
Write-Host "Node.js environment setup completed successfully."

# Step 5: Generate Environment Report
$report = @{
    "phase" = "0.1.2-nodejs"
    "timestamp" = (Get-Date).ToString("YYYYMMDD HH:mm:ss")
    "nodeVersion" = (node --version 2>$null)
    "packageManager" = $packageManager
    "dependenciesInstalled" = $true
    "nodeModulesExists" = (Test-Path "node_modules")
    "packageJsonExists" = (Test-Path "package.json")
}
$outputPath = Join-Path -Path $OutputLocation -ChildPath "1-discovery-2-environment-setup.json"
$report | ConvertTo-Json -Depth 4 | Out-File -FilePath $outputPath -Encoding UTF8
Write-Host "Environment report saved to: $outputPath"
