# Java Environment Setup Script (Phase 0.1.2)

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

Write-Host "Setting up Java environment..."

# Read detection results
if (Test-Path "project-detection.json") {
    $detection = Get-Content "project-detection.json" | ConvertFrom-Json
    Write-Host "Project language: $($detection.PrimaryLanguage)"
} else {
    Write-Error "project-detection.json not found. Run Phase 0.1.1 first."
    exit 1
}

# Step 1: Verify Java
Write-Host "Checking Java installation..."
try {
    $javaVersion = java -version 2>&1 | Select-String "version" | ForEach-Object { $_.ToString() }
    if ($javaVersion -match '"([\d.]+)"') {
        $ver = $Matches[1]
        Write-Host "Java version $ver detected."
    } else {
        Write-Host "Java version could not be determined."
        exit 1
    }
} catch {
    Write-Host "Java not installed. Please install Java 11 or higher."
    exit 1
}

# Step 2: Install Dependencies (Maven/Gradle)
$buildTool = ""
if (Test-Path "pom.xml") {
    $buildTool = "maven"
    Write-Host "Using Maven."
    mvn install -B
    if ($LASTEXITCODE -ne 0) { Write-Host "Maven install failed."; exit 1 }
} elseif (Test-Path "build.gradle") {
    $buildTool = "gradle"
    Write-Host "Using Gradle."
    gradle build --no-daemon
    if ($LASTEXITCODE -ne 0) { Write-Host "Gradle build failed."; exit 1 }
} else {
    Write-Host "No recognized Java build file found."
    exit 1
}

# Step 3: Generate Environment Report
$report = @{
    "phase" = "0.1.2-java"
    "timestamp" = (Get-Date).ToString("YYYYMMDD HH:mm:ss")
    "javaVersion" = $javaVersion
    "buildTool" = $buildTool
    "dependenciesInstalled" = $true
}
$report | ConvertTo-Json -Depth 3 | Out-File "environment-java-report.json"
Write-Host "Environment report saved to: environment-java-report.json"
