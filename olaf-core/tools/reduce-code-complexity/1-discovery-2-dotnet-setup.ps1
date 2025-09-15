# .NET Environment Setup Script (Phase 0.1.2)

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

Write-Host "Setting up .NET environment..."

# Read detection results
if (Test-Path "project-detection.json") {
    $detection = Get-Content "project-detection.json" | ConvertFrom-Json
    Write-Host "Project language: $($detection.primaryLanguage)"
    Write-Host "Build tool: $($detection.buildTool)"
} else {
    Write-Error "project-detection.json not found. Run Phase 0.1.1 first."
    exit 1
}

# Step 1: Verify .NET SDK
Write-Host "Checking .NET SDK..."

try {
    $dotnetVersion = dotnet --version 2>$null
    Write-Host ".NET SDK: $dotnetVersion"
    if ($dotnetVersion -match "^(\d+)\.(\d+)") {
        $majorVersion = [int]$matches[1]
        if ($majorVersion -lt 6) {
            Write-Host ".NET $majorVersion detected. .NET 6+ recommended."
        }
    }
} catch {
    Write-Host ".NET SDK not installed"
    Write-Host "Install .NET SDK from: https://dotnet.microsoft.com/download"
    exit 1
}

# List installed .NET versions
try {
    Write-Host "Installed .NET versions:"
    $sdks = dotnet --list-sdks 2>$null
    $sdks | ForEach-Object { Write-Host "SDK: $_" }
    $runtimes = dotnet --list-runtimes 2>$null
    $runtimes | ForEach-Object { Write-Host "Runtime: $_" }
} catch {
    Write-Host "Could not list .NET versions"
}

# Step 2: Detect Project Structure
Write-Host "Analyzing project structure..."

$solutionFiles = Get-ChildItem "*.sln" -ErrorAction SilentlyContinue
$projectFiles = Get-ChildItem "*.csproj", "*.fsproj", "*.vbproj" -ErrorAction SilentlyContinue

if ($solutionFiles) {
    $primaryFile = $solutionFiles[0]
    Write-Host "Solution file: $($primaryFile.Name)"
    try {
        $slnContent = Get-Content $primaryFile.FullName -Raw
        $projectMatches = [regex]::Matches($slnContent, 'Project\(".*?"\)\s*=\s*"([^"]+)"')
        $projectCount = $projectMatches.Count
        Write-Host "Projects in solution: $projectCount"
        foreach ($match in $projectMatches) {
            Write-Host "- $($match.Groups[1].Value)"
        }
    } catch {
        Write-Host "Could not parse solution file"
    }
} elseif ($projectFiles) {
    Write-Host "Project files found:"
    foreach ($proj in $projectFiles) {
        Write-Host "- $($proj.Name)"
        try {
            $projContent = Get-Content $proj.FullName -Raw
            if ($projContent -match '<TargetFramework[s]?>([^<]+)</TargetFramework[s]?>') {
                $targetFramework = $matches[1]
                Write-Host "Target: $targetFramework"
            }
        } catch {
            Write-Host "Could not read target framework"
        }
    }
    $primaryFile = $projectFiles[0]
} else {
    Write-Host "No .NET solution or project files found"
    exit 1
}

# Step 3: Restore NuGet Packages
Write-Host "Restoring NuGet packages..."
$startTime = Get-Date
try {
    if ($solutionFiles) {
        Write-Host "Running: dotnet restore $($primaryFile.Name)"
        dotnet restore $primaryFile.Name
    } else {
        Write-Host "Running: dotnet restore"
        dotnet restore
    }
    if ($LASTEXITCODE -ne 0) { throw "dotnet restore failed" }
    $duration = (Get-Date) - $startTime
    Write-Host "Packages restored successfully in $($duration.TotalSeconds) seconds"
} catch {
    Write-Host "Package restoration failed: $_"
    Write-Host "Try troubleshooting: check internet, clear NuGet cache, verify project file syntax, check NuGet sources."
    exit 1
}

# Step 4: Test Build
Write-Host "Testing .NET build..."
$buildStartTime = Get-Date
try {
    if ($solutionFiles) {
        Write-Host "Running: dotnet build $($primaryFile.Name)"
        dotnet build $primaryFile.Name --no-restore
    } else {
        Write-Host "Running: dotnet build"
        dotnet build --no-restore
    }
    if ($LASTEXITCODE -ne 0) { throw "dotnet build failed" }
    $buildDuration = (Get-Date) - $buildStartTime
    Write-Host "Build successful in $($buildDuration.TotalSeconds) seconds"
} catch {
    Write-Host "Build failed: $_"
    Write-Host "Check for compilation errors in source code."
    try {
        if ($solutionFiles) {
            dotnet build $primaryFile.Name --verbosity minimal 2>&1 | Write-Host
        } else {
            dotnet build --verbosity minimal 2>&1 | Write-Host
        }
    } catch {
        Write-Host "Additional error details not available"
    }
    exit 1
}

# Step 5: Validate Environment
Write-Host "Validating .NET environment..."
$expectedDirs = @("bin", "obj")
$foundDirs = @()
foreach ($dir in $expectedDirs) {
    $found = Get-ChildItem $dir -Recurse -ErrorAction SilentlyContinue | Where-Object { $_.PSIsContainer }
    if ($found) {
        $foundDirs += $dir
        Write-Host "$dir directories found"
    } else {
        Write-Host "$dir directories not found"
    }
}
$buildOutputs = Get-ChildItem "bin" -Recurse -Include "*.dll", "*.exe" -ErrorAction SilentlyContinue
if ($buildOutputs) {
    Write-Host "Build outputs generated:"
    $buildOutputs | ForEach-Object { Write-Host "- $($_.Name)" }
} else {
    Write-Host "No build outputs found"
}
$dotnetCommands = @(
    "dotnet --info",
    "dotnet nuget list source",
    "dotnet tool list --global"
)
foreach ($cmd in $dotnetCommands) {
    try {
        $result = Invoke-Expression "$cmd" 2>$null
        if ($LASTEXITCODE -eq 0) {
            Write-Host "'$cmd' works"
        } else {
            Write-Host "'$cmd' failed"
        }
    } catch {
        Write-Host "'$cmd' error: $_"
    }
}
$commonTools = @("dotnet-ef", "dotnet-aspnet-codegenerator")
foreach ($tool in $commonTools) {
    try {
        $toolCheck = dotnet tool list --global | Select-String $tool
        if ($toolCheck) {
            Write-Host "Global tool '$tool' installed"
        } else {
            Write-Host "Global tool '$tool' not installed"
        }
    } catch {
        Write-Host "Could not check global tool '$tool'"
    }
}
if ($projectFiles) {
    foreach ($proj in $projectFiles) {
        try {
            $projContent = Get-Content $proj.FullName -Raw
            if ($projContent -match '<Nullable>enable</Nullable>') {
                Write-Host "$($proj.Name): Nullable reference types enabled"
            }
            if ($projContent -match '<TreatWarningsAsErrors>true</TreatWarningsAsErrors>') {
                Write-Host "$($proj.Name): Warnings as errors enabled"
            }
            if ($projContent -match '<ImplicitUsings>enable</ImplicitUsings>') {
                Write-Host "$($proj.Name): Implicit usings enabled"
            }
        } catch {
            Write-Host "Could not analyze $($proj.Name)"
        }
    }
}
Write-Host ".NET environment setup completed successfully!"

# Generate environment report
$report = @{
    "phase" = "0.1.2-dotnet"
    "timestamp" = (Get-Date).ToString("YYYYMMDD HH:mm:ss")
    "dotnetVersion" = (dotnet --version 2>$null)
    "sdks" = (dotnet --list-sdks 2>$null)
    "runtimes" = (dotnet --list-runtimes 2>$null)
    "solutionFiles" = if ($solutionFiles) { $solutionFiles | ForEach-Object { $_.Name } } else { @() }
    "projectFiles" = if ($projectFiles) { $projectFiles | ForEach-Object { $_.Name } } else { @() }
    "packagesRestored" = $true
    "buildSuccessful" = $true
    "buildOutputsGenerated" = (Get-ChildItem "bin" -Recurse -Include "*.dll", "*.exe" -ErrorAction SilentlyContinue).Count -gt 0
}
$report | ConvertTo-Json -Depth 3 | Out-File "environment-dotnet-report.json"
Write-Host "Environment report saved to: environment-dotnet-report.json"
