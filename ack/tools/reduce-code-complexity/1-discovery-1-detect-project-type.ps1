#!/usr/bin/env pwsh

<#
.SYNOPSIS
    Comprehensive project detection script for identifying languages, build systems, and project structure.

.DESCRIPTION
    This script analyzes a codebase to detect:
    - Primary and secondary programming languages
    - Build systems and package managers
    - Project structure (monorepo vs single project)
    - Configuration files and version requirements
    - Total lines of code

.PARAMETER ProjectPath
    The path to the project directory to analyze. Defaults to current directory.

.PARAMETER OutputFile
    The output file to save detection results. Defaults to 'project-detection.json'.

.PARAMETER Verbose
    Enable verbose output showing detailed analysis steps.

.EXAMPLE
    .\1-discovery-1-detect-project-type
    
.EXAMPLE
    .\1-discovery-1-detect-project-type -ProjectPath "C:\MyProject" -OutputFile "detection-results.json" -Verbose

.NOTES
    Part of the Complexity Reduction toolkit - Phase 0.1.1: Project Detection
#>

param(
    [Parameter(Mandatory = $false)]
    [string]$ProjectPath = ".",
    
    [Parameter(Mandatory = $false)]
    [string]$OutputFile = "project-detection.json"
)

# Set location to project path
Set-Location $ProjectPath

# Initialize variables
$buildSystem = "Unknown"
$packageManager = "Unknown"

Write-Host "Detecting project languages and types..." 
Write-Host "Analyzing directory: $(Get-Location)" -ForegroundColor Gray
Write-Host "Current working directory contents:" -ForegroundColor Gray
$dirContents = Get-ChildItem -Force | Select-Object -First 10
$dirContents | ForEach-Object { 
    $type = if ($_.PSIsContainer) { "[DIR]" } else { "[FILE]" }
    Write-Host "  $type $($_.Name)" -ForegroundColor DarkGray 
}
if ((Get-ChildItem).Count -gt 10) {
    Write-Host "  ... and $((Get-ChildItem).Count - 10) more items" -ForegroundColor DarkGray
}
Write-Host "" 

# Step 1: Find configuration files
Write-Host "Scanning for configuration files..." -ForegroundColor Yellow

$configFilePatterns = @("package.json", "pom.xml", "Cargo.toml", "go.mod", "requirements.txt", "*.sln", "build.gradle", "CMakeLists.txt", "Makefile", "composer.json", "Gemfile", "pyproject.toml", "Pipfile", "setup.py", "turbo.json", "nx.json", "lerna.json", "tsconfig.json")
$allConfigFiles = Get-ChildItem -Path . -Recurse -Depth 1 -Include $configFilePatterns -ErrorAction SilentlyContinue | Select-Object -ExpandProperty FullName

# Exclude files in node_modules, dist, .git, .next, .turbo, .cache, coverage, and any hidden folders
$excludePatterns = @('node_modules\', 'dist\', '.git\', '.next\', '.turbo\', '.cache\', 'coverage\', 'out\', 'build\', 'tmp\', 'test-output\')

# Parse .gitignore if present
$gitignorePath = Join-Path (Get-Location) ".gitignore"
if (Test-Path $gitignorePath) {
    Write-Host "Parsing .gitignore for additional exclude patterns..." -ForegroundColor Gray
    $gitignoreLines = Get-Content $gitignorePath | Where-Object { $_ -and $_ -notmatch '^#' }
    foreach ($line in $gitignoreLines) {
        $trimmed = $line.Trim()
        if ($trimmed -eq "") { continue }
        # Convert forward slashes to backslashes for Windows
        $pat = $trimmed.Replace('/', '\')
        # Remove trailing slashes
        if ($pat.EndsWith('\')) { $pat = $pat.Substring(0, $pat.Length - 1) }
        # Add to exclude patterns
        $excludePatterns += $pat
    }
}

$projectFiles = $allConfigFiles | Where-Object {
    $relPath = $_.Replace((Get-Location).Path + "\", "")
    foreach ($pat in $excludePatterns) {
        if ($relPath -like "*${pat}*") { return $false }
    }
    return $true
}

if ($projectFiles) {
    Write-Host "Found configuration files (excluding dependencies/build folders):" -ForegroundColor Green
    $projectFiles | ForEach-Object {
        $relPath = $_.Replace((Get-Location).Path + "\", "")
        Write-Host "  - $relPath" -ForegroundColor White
    }
} else {
    Write-Host "No standard configuration files found" -ForegroundColor Yellow
}

# Step 2: Count source files by language
Write-Host "Analyzing source files and calculating lines of code (single pass)..." -ForegroundColor Yellow

# Define language mappings with their extensions
$languageMap = @{
    "JavaScript/TypeScript" = @(".js",".ts",".jsx",".tsx")
    "Python" = @(".py")
    "Java" = @(".java")
    "C#" = @(".cs")
    "C/C++" = @(".c",".cpp",".h",".hpp")
    "Go" = @(".go")
    "Rust" = @(".rs")
    "PHP" = @(".php")
    "Ruby" = @(".rb")
    "HTML/CSS" = @(".html",".css",".scss",".sass",".less")
    "Shell" = @(".sh",".bash",".ps1")
}

# Flatten all extensions for one pass
$allExtensions = $languageMap.Values | ForEach-Object { $_ } | Select-Object -Unique

# Collect all relevant files in one pass
$allSourceFiles = Get-ChildItem -Recurse -File -ErrorAction SilentlyContinue | Where-Object {
    $ext = $_.Extension.ToLower()
    $allExtensions -contains $ext
}

# Filter out excluded folders
$filteredSourceFiles = $allSourceFiles | Where-Object {
    $relPath = $_.FullName.Replace((Get-Location).Path + "\", "")
    foreach ($pat in $excludePatterns) {
        if ($relPath -like "*${pat}*") { return $false }
    }
    return $true
}

# Initialize counters
$sourceFiles = @{}
$totalLOC = 0
$exampleFilesPerLang = @{}

# Map files to language and count LOC
foreach ($file in $filteredSourceFiles) {
    $ext = $file.Extension.ToLower()
    foreach ($lang in $languageMap.Keys) {
        if ($languageMap[$lang] -contains $ext) {
            if (-not $sourceFiles.ContainsKey($lang)) { $sourceFiles[$lang] = 0 }
            $sourceFiles[$lang]++
            if (-not $exampleFilesPerLang.ContainsKey($lang)) { $exampleFilesPerLang[$lang] = @() }
            if ($exampleFilesPerLang[$lang].Count -lt 3) { $exampleFilesPerLang[$lang] += $file.Name }
        }
    }
    # Count LOC
    try {
        $loc = (Get-Content $file.FullName -ErrorAction SilentlyContinue | Measure-Object -Line).Lines
        $totalLOC += $loc
    } catch {}
}

Write-Host "Source file counts by language:" -ForegroundColor Green
$languagesFound = $sourceFiles.GetEnumerator() | Where-Object { $_.Value -gt 0 } | Sort-Object Value -Descending
$languagesFound | ForEach-Object {
    Write-Host "  - $($_.Key): $($_.Value) files" -ForegroundColor White
    if ($exampleFilesPerLang[$_.Key]) {
        Write-Host "    Examples: $($exampleFilesPerLang[$_.Key] -join ', ')" -ForegroundColor DarkGray
    }
}

if ($languagesFound.Count -eq 0) {
    Write-Host "  No source files detected" -ForegroundColor Yellow
}

# Step 3: Detect build systems and package managers
Write-Host "`nDetecting build systems and package managers..." -ForegroundColor Yellow

function Detect-NodeJsProject {
    if (Test-Path "package.json") {
        Write-Host "Node.js project detected" -ForegroundColor Green
        
        # Detect package manager
        if (Test-Path "pnpm-lock.yaml") { 
            Write-Host "  Package Manager: PNPM" -ForegroundColor White
            $script:packageManager = "pnpm"
        } elseif (Test-Path "yarn.lock") { 
            Write-Host "  Package Manager: Yarn" -ForegroundColor White
            $script:packageManager = "yarn"
        } elseif (Test-Path "package-lock.json") { 
            Write-Host "  Package Manager: NPM" -ForegroundColor White
            $script:packageManager = "npm"
        } else {
            Write-Host "  Package Manager: NPM (default)" -ForegroundColor White
            $script:packageManager = "npm"
        }
        
        # Detect build system
        if (Test-Path "turbo.json") { 
            Write-Host "  Build System: Turbo (monorepo)" -ForegroundColor White
            $script:buildSystem = "Turbo"
        } elseif (Test-Path "nx.json") { 
            Write-Host "  Build System: Nx (monorepo)" -ForegroundColor White
            $script:buildSystem = "Nx"
        } elseif (Test-Path "lerna.json") { 
            Write-Host "  Build System: Lerna (monorepo)" -ForegroundColor White
            $script:buildSystem = "Lerna"
        } elseif (Test-Path "tsconfig.json") { 
            Write-Host "  Build System: TypeScript" -ForegroundColor White
            $script:buildSystem = "TypeScript"
        } else { 
            Write-Host "  Build System: Standard Node.js" -ForegroundColor White
            $script:buildSystem = "Node.js"
        }
        
        # Extract package.json details
        try {
            $packageJson = Get-Content "package.json" | ConvertFrom-Json
            Write-Host "  Project Name: $($packageJson.name)" -ForegroundColor White
            if ($packageJson.engines -and $packageJson.engines.node) {
                Write-Host "  Node Version Requirement: $($packageJson.engines.node)" -ForegroundColor White
            }
            if ($packageJson.packageManager) {
                Write-Host "  Package Manager (from package.json): $($packageJson.packageManager)" -ForegroundColor White
            }
        } catch {
            Write-Host "  Warning: Could not parse package.json" -ForegroundColor Yellow
        }
        
        return $true
    }
    return $false
}

function Detect-JavaProject {
    if (Test-Path "pom.xml") {
        Write-Host "Java Maven project detected" -ForegroundColor Green
        $script:buildSystem = "Maven"
        
        # Extract Java version from pom.xml
        try {
            $pomContent = Get-Content "pom.xml" -Raw
            if ($pomContent -match '<maven.compiler.source>(\d+)</maven.compiler.source>') {
                Write-Host "  Java Version: $($Matches[1])" -ForegroundColor White
            } elseif ($pomContent -match '<java.version>([^<]+)</java.version>') {
                Write-Host "  Java Version: $($Matches[1])" -ForegroundColor White
            }
        } catch {
            Write-Host "  Warning: Could not parse pom.xml" -ForegroundColor Yellow
        }
        
        return $true
    } elseif ((Test-Path "build.gradle") -or (Test-Path "build.gradle.kts")) {
        Write-Host "Java Gradle project detected" -ForegroundColor Green
        $script:buildSystem = "Gradle"
        
        # Check for Gradle wrapper
        if ((Test-Path "gradlew") -or (Test-Path "gradlew.bat")) {
            Write-Host "  Gradle Wrapper: Available" -ForegroundColor White
        }
        
        return $true
    }
    return $false
}

function Detect-PythonProject {
    if (Test-Path "pyproject.toml") {
        Write-Host "Python project (pyproject.toml) detected" -ForegroundColor Green
        $script:buildSystem = "Modern Python (pyproject.toml)"
        
        # Extract Python version requirement
        try {
            $pyprojectContent = Get-Content "pyproject.toml" -Raw
            if ($pyprojectContent -match 'requires-python = "(.+?)"') {
                Write-Host "  Python Version Requirement: $($Matches[1])" -ForegroundColor White
            }
        } catch {
            Write-Host "  Warning: Could not parse pyproject.toml" -ForegroundColor Yellow
        }
        
        return $true
    } elseif (Test-Path "Pipfile") {
        Write-Host "Python Pipenv project detected" -ForegroundColor Green
        $script:buildSystem = "Pipenv"
        $script:packageManager = "pipenv"
        return $true
    } elseif (Test-Path "requirements.txt") {
        Write-Host "Python pip project detected" -ForegroundColor Green
        $script:buildSystem = "pip"
        $script:packageManager = "pip"
        return $true
    } elseif (Test-Path "setup.py") {
        Write-Host "Python setuptools project detected" -ForegroundColor Green
        $script:buildSystem = "setuptools"
        $script:packageManager = "pip"
        return $true
    }
    return $false
}

function Detect-OtherLanguages {
    $detected = $false
    
    # Rust
    if (Test-Path "Cargo.toml") {
        Write-Host "Rust project detected" -ForegroundColor Green
        $script:buildSystem = "Cargo"
        $script:packageManager = "cargo"
        
        # Extract Rust edition
        try {
            $cargoContent = Get-Content "Cargo.toml" -Raw
            if ($cargoContent -match 'edition = "(\d+)"') {
                Write-Host "  Rust Edition: $($Matches[1])" -ForegroundColor White
            }
        } catch {
            Write-Host "  Warning: Could not parse Cargo.toml" -ForegroundColor Yellow
        }
        
        $detected = $true
    }

    # Go
    if (Test-Path "go.mod") {
        Write-Host "Go project detected" -ForegroundColor Green
        $script:buildSystem = "Go Modules"
        $script:packageManager = "go"
        
        # Extract Go version
        try {
            $goModContent = Get-Content "go.mod" | Select-Object -First 3
            $goModContent | ForEach-Object {
                if ($_ -match 'go (\d+\.\d+)') {
                    Write-Host "  Go Version: $($Matches[1])" -ForegroundColor White
                }
            }
        } catch {
            Write-Host "  Warning: Could not parse go.mod" -ForegroundColor Yellow
        }
        
        $detected = $true
    }

    # C#/.NET
    $slnFiles = Get-ChildItem "*.sln" -ErrorAction SilentlyContinue
    $csprojFiles = Get-ChildItem "*.csproj" -ErrorAction SilentlyContinue
    
    if ($slnFiles) {
        Write-Host ".NET Solution detected" -ForegroundColor Green
        $script:buildSystem = ".NET/MSBuild"
        Write-Host "  Solution files: $($slnFiles.Count)" -ForegroundColor White
        $detected = $true
    } elseif ($csprojFiles) {
        Write-Host ".NET Project detected" -ForegroundColor Green
        $script:buildSystem = ".NET/MSBuild"
        Write-Host "  Project files: $($csprojFiles.Count)" -ForegroundColor White
        $detected = $true
    }

    # C/C++
    if (Test-Path "CMakeLists.txt") {
        Write-Host "C/C++ CMake project detected" -ForegroundColor Green
        $script:buildSystem = "CMake"
        $detected = $true
    } elseif (Test-Path "Makefile") {
        Write-Host "C/C++ Make project detected" -ForegroundColor Green
        $script:buildSystem = "Make"
        $detected = $true
    }

    # PHP
    if (Test-Path "composer.json") {
        Write-Host "PHP Composer project detected" -ForegroundColor Green
        $script:buildSystem = "Composer"
        $script:packageManager = "composer"
        $detected = $true
    }

    # Ruby
    if (Test-Path "Gemfile") {
        Write-Host "Ruby project detected" -ForegroundColor Green
        $script:buildSystem = "Bundler"
        $script:packageManager = "bundler"
        $detected = $true
    }
    
    return $detected
}

# Run detection functions
$detectionResults = @()
$detectionResults += Detect-NodeJsProject
$detectionResults += Detect-JavaProject
$detectionResults += Detect-PythonProject
$detectionResults += Detect-OtherLanguages

if (-not ($detectionResults -contains $true)) {
    Write-Host "No specific build system detected" -ForegroundColor Yellow
}

# Step 4: Analyze project structure
Write-Host "`nAnalyzing project structure..." -ForegroundColor Yellow

$isMonorepo = $false
$packageCount = 0
$appCount = 0
$libCount = 0

if ((Test-Path "packages") -or (Test-Path "apps") -or (Test-Path "libs")) {
    Write-Host "  Structure: Monorepo detected" -ForegroundColor Green
    $isMonorepo = $true
    
    if (Test-Path "packages") {
        $packageCount = (Get-ChildItem "packages" -Directory -ErrorAction SilentlyContinue).Count
        Write-Host "  Packages: $packageCount in /packages" -ForegroundColor White
    }
    
    if (Test-Path "apps") {
        $appCount = (Get-ChildItem "apps" -Directory -ErrorAction SilentlyContinue).Count
        Write-Host "  Applications: $appCount in /apps" -ForegroundColor White
    }
    
    if (Test-Path "libs") {
        $libCount = (Get-ChildItem "libs" -Directory -ErrorAction SilentlyContinue).Count
        Write-Host "  Libraries: $libCount in /libs" -ForegroundColor White
    }
} else {
    Write-Host "  Structure: Single project" -ForegroundColor Green
}

# Step 5: Calculate total lines of code
Write-Host "  Total Lines of Code: $totalLOC" -ForegroundColor White

# Step 6: Determine primary language
$primaryLanguage = "Unknown"
$allLanguages = ""

if ($languagesFound.Count -gt 0) {
    $primaryLanguage = $languagesFound[0].Key
    $allLanguages = ($languagesFound | ForEach-Object { "$($_.Key):$($_.Value)" }) -join ","
}

# Step 7: Save detection results
Write-Host "`nSaving detection results..." -ForegroundColor Yellow

$detectionResults = @{
    "DetectionDate" = Get-Date -Format "YYYYMMDD HH:mm:ss"
    "ProjectPath" = (Get-Location).Path
    "PrimaryLanguage" = $primaryLanguage
    "AllLanguages" = $allLanguages
    "BuildSystem" = $buildSystem
    "PackageManager" = $packageManager
    "ProjectType" = if ($isMonorepo) { "Monorepo" } else { "Single" }
    "TotalLOC" = $totalLOC
    "ConfigFiles" = if ($projectFiles) { $projectFiles | ForEach-Object { $_.Replace((Get-Location).Path + "\", "") } } else { @() }
    "MonorepoDetails" = @{
        "IsMonorepo" = $isMonorepo
        "PackageCount" = $packageCount
        "AppCount" = $appCount
        "LibCount" = $libCount
    }
    "LanguageBreakdown" = $sourceFiles
}

try {
    $detectionResults | ConvertTo-Json -Depth 10 | Out-File -FilePath $OutputFile -Encoding UTF8
    Write-Host "Detection results saved to $OutputFile" -ForegroundColor Green
} catch {
    Write-Host "Failed to save detection results: $($_.Exception.Message)" -ForegroundColor Red
    return 1
}

# Step 8: Display summary
Write-Host "`nDetection Summary" -ForegroundColor Cyan
Write-Host "===================" -ForegroundColor Cyan
Write-Host "Primary Language: $primaryLanguage" -ForegroundColor White
Write-Host "Build System: $buildSystem" -ForegroundColor White
Write-Host "Package Manager: $packageManager" -ForegroundColor White
Write-Host "Project Type: $(if ($isMonorepo) { 'Monorepo' } else { 'Single Project' })" -ForegroundColor White
Write-Host "Total LOC: $totalLOC" -ForegroundColor White
Write-Host "Detection Date: $(Get-Date -Format 'YYYYMMDD HH:mm:ss')" -ForegroundColor White

Write-Host "`nNext Steps:" -ForegroundColor Yellow
Write-Host "1. Review the detection results in $OutputFile" -ForegroundColor White
Write-Host "2. Proceed to Phase 0.1.2: Environment Setup" -ForegroundColor White
Write-Host "3. Install detected runtime and tools" -ForegroundColor White
Write-Host "4. Install project dependencies" -ForegroundColor White

return 0
