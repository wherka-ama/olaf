#!/usr/bin/env pwsh

<#
.SYNOPSIS
    Sets up comprehensive testing framework for the project based on detected project type and existing test infrastructure.

.DESCRIPTION
    This script analyzes the project structure and sets up appropriate testing frameworks, installs dependencies,
    configures test runners, and establishes testing standards for comprehensive test coverage assessment.

.PARAMETER ProjectPath
    Path to the target project directory.

.PARAMETER OutputPath
    Path where the testing setup results will be saved.

.PARAMETER ProjectType
    Type of project (detected from discovery phase).

.PARAMETER SetupCI
    Whether to setup CI/CD integration (default: false).

.EXAMPLE
    .\2-quality-baselining-2-setup-testing-framework.ps1 -ProjectPath "C:\MyProject" -OutputPath "C:\Results" -ProjectType "nodejs"
#>

param(
    [Parameter(Mandatory = $true)]
    [string]$ProjectPath,
    
    [Parameter(Mandatory = $true)]
    [string]$OutputPath,
    
    [Parameter(Mandatory = $true)]
    [string]$ProjectType,
    
    [Parameter(Mandatory = $false)]
    [bool]$SetupCI = $false
)

# Initialize result structure
$TestingSetup = @{
    timestamp = Get-Date -Format "YYYYMMDDTHH:mm:ssZ"
    project_path = $ProjectPath
    project_type = $ProjectType
    setup_summary = @{
        frameworks_installed = @()
        dependencies_added = @()
        configuration_files_created = @()
        test_directories_created = @()
        setup_status = "pending"
    }
    existing_infrastructure = @{
        test_frameworks = @()
        test_files = @()
        configuration_files = @()
        coverage_tools = @()
    }
    recommended_structure = @{
        test_directories = @()
        naming_conventions = @()
        file_patterns = @()
    }
    testing_tools = @{
        unit_testing = @()
        integration_testing = @()
        coverage_tools = @()
        mocking_libraries = @()
    }
    configuration = @{
        test_scripts = @()
        coverage_thresholds = @()
        ci_integration = @()
    }
    next_steps = @()
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

function Analyze-ExistingInfrastructure {
    Write-StatusMessage "Analyzing existing test infrastructure..." "INFO"
    
    Push-Location $ProjectPath
    
    try {
        # Check for existing test frameworks based on project type
        switch ($ProjectType.ToLower()) {
            "nodejs" {
                $packageJson = Get-Content "package.json" -Raw -ErrorAction SilentlyContinue
                if ($packageJson) {
                    $package = $packageJson | ConvertFrom-Json
                    
                    # Check dependencies for test frameworks
                    $testFrameworks = @("jest", "mocha", "jasmine", "vitest", "cypress")
                    foreach ($framework in $testFrameworks) {
                        if ($package.dependencies.$framework -or $package.devDependencies.$framework) {
                            $TestingSetup.existing_infrastructure.test_frameworks += @{
                                name = $framework
                                version = $package.dependencies.$framework ?? $package.devDependencies.$framework
                                type = "unit"
                            }
                        }
                    }
                    
                    # Check for coverage tools
                    $coverageTools = @("nyc", "istanbul", "c8")
                    foreach ($tool in $coverageTools) {
                        if ($package.dependencies.$tool -or $package.devDependencies.$tool) {
                            $TestingSetup.existing_infrastructure.coverage_tools += $tool
                        }
                    }
                }
                
                # Check for existing test files
                $testFiles = Get-ChildItem -Recurse -Include "*.test.js", "*.spec.js", "*.test.ts", "*.spec.ts" -ErrorAction SilentlyContinue
                $TestingSetup.existing_infrastructure.test_files = $testFiles | ForEach-Object { $_.FullName.Replace($ProjectPath, "").Replace("\", "/") }
                
                # Check for configuration files
                $configFiles = @("jest.config.js", "jest.config.json", "mocha.opts", ".mocharc.json", "cypress.config.js")
                foreach ($config in $configFiles) {
                    if (Test-Path $config) {
                        $TestingSetup.existing_infrastructure.configuration_files += $config
                    }
                }
            }
            
            "python" {
                # Check for Python test frameworks
                $requirementsFiles = Get-ChildItem -Include "requirements*.txt", "Pipfile", "pyproject.toml" -ErrorAction SilentlyContinue
                foreach ($file in $requirementsFiles) {
                    $content = Get-Content $file.FullName -Raw -ErrorAction SilentlyContinue
                    if ($content) {
                        $testFrameworks = @("pytest", "unittest", "nose2", "tox")
                        foreach ($framework in $testFrameworks) {
                            if ($content -match $framework) {
                                $TestingSetup.existing_infrastructure.test_frameworks += @{
                                    name = $framework
                                    type = "unit"
                                    source = $file.Name
                                }
                            }
                        }
                    }
                }
                
                # Check for existing test files
                $testFiles = Get-ChildItem -Recurse -Include "test_*.py", "*_test.py" -ErrorAction SilentlyContinue
                $TestingSetup.existing_infrastructure.test_files = $testFiles | ForEach-Object { $_.FullName.Replace($ProjectPath, "").Replace("\", "/") }
                
                # Check for configuration files
                $configFiles = @("pytest.ini", "tox.ini", "setup.cfg", "pyproject.toml")
                foreach ($config in $configFiles) {
                    if (Test-Path $config) {
                        $TestingSetup.existing_infrastructure.configuration_files += $config
                    }
                }
            }
            
            "java" {
                # Check for Java test frameworks
                $pomXml = Get-Content "pom.xml" -Raw -ErrorAction SilentlyContinue
                $buildGradle = Get-Content "build.gradle" -Raw -ErrorAction SilentlyContinue
                
                $testFrameworks = @("junit", "testng", "mockito", "assertj")
                foreach ($framework in $testFrameworks) {
                    if ($pomXml -match $framework -or $buildGradle -match $framework) {
                        $TestingSetup.existing_infrastructure.test_frameworks += @{
                            name = $framework
                            type = "unit"
                            source = if ($pomXml -match $framework) { "pom.xml" } else { "build.gradle" }
                        }
                    }
                }
                
                # Check for existing test files
                $testFiles = Get-ChildItem -Recurse -Include "*Test.java", "*Tests.java" -ErrorAction SilentlyContinue
                $TestingSetup.existing_infrastructure.test_files = $testFiles | ForEach-Object { $_.FullName.Replace($ProjectPath, "").Replace("\", "/") }
            }
            
            "dotnet" {
                # Check for .NET test frameworks
                $projectFiles = Get-ChildItem -Recurse -Include "*.csproj", "*.fsproj", "*.vbproj" -ErrorAction SilentlyContinue
                foreach ($file in $projectFiles) {
                    $content = Get-Content $file.FullName -Raw -ErrorAction SilentlyContinue
                    if ($content) {
                        $testFrameworks = @("xunit", "nunit", "mstest", "moq")
                        foreach ($framework in $testFrameworks) {
                            if ($content -match $framework) {
                                $TestingSetup.existing_infrastructure.test_frameworks += @{
                                    name = $framework
                                    type = "unit"
                                    source = $file.Name
                                }
                            }
                        }
                    }
                }
                
                # Check for existing test files
                $testFiles = Get-ChildItem -Recurse -Include "*Test.cs", "*Tests.cs", "*Test.fs", "*Tests.fs" -ErrorAction SilentlyContinue
                $TestingSetup.existing_infrastructure.test_files = $testFiles | ForEach-Object { $_.FullName.Replace($ProjectPath, "").Replace("\", "/") }
            }
            
            "go" {
                # Check for Go test files
                $testFiles = Get-ChildItem -Recurse -Include "*_test.go" -ErrorAction SilentlyContinue
                $TestingSetup.existing_infrastructure.test_files = $testFiles | ForEach-Object { $_.FullName.Replace($ProjectPath, "").Replace("\", "/") }
                
                # Go has built-in testing
                $TestingSetup.existing_infrastructure.test_frameworks += @{
                    name = "go test"
                    type = "unit"
                    source = "built-in"
                }
            }
            
            "rust" {
                # Check for Rust test files
                $testFiles = Get-ChildItem -Recurse -Include "*.rs" -ErrorAction SilentlyContinue | 
                           Where-Object { (Get-Content $_.FullName -Raw -ErrorAction SilentlyContinue) -match "#\[test\]" }
                $TestingSetup.existing_infrastructure.test_files = $testFiles | ForEach-Object { $_.FullName.Replace($ProjectPath, "").Replace("\", "/") }
                
                # Rust has built-in testing
                $TestingSetup.existing_infrastructure.test_frameworks += @{
                    name = "cargo test"
                    type = "unit"
                    source = "built-in"
                }
            }
        }
        
    } finally {
        Pop-Location
    }
}

function Setup-TestingFramework {
    Write-StatusMessage "Setting up testing framework..." "INFO"
    
    Push-Location $ProjectPath
    
    try {
        switch ($ProjectType.ToLower()) {
            "nodejs" {
                # Setup Jest if no framework exists
                if ($TestingSetup.existing_infrastructure.test_frameworks.Count -eq 0) {
                    Write-StatusMessage "Installing Jest testing framework..." "INFO"
                    & npm install --save-dev jest @types/jest
                    if ($LASTEXITCODE -eq 0) {
                        $TestingSetup.setup_summary.frameworks_installed += "jest"
                        $TestingSetup.setup_summary.dependencies_added += "@types/jest"
                    }
                }
                
                # Setup coverage tool
                if ($TestingSetup.existing_infrastructure.coverage_tools.Count -eq 0) {
                    Write-StatusMessage "Installing coverage tool..." "INFO"
                    & npm install --save-dev nyc
                    if ($LASTEXITCODE -eq 0) {
                        $TestingSetup.setup_summary.dependencies_added += "nyc"
                    }
                }
                
                # Create jest.config.js if it doesn't exist
                if (-not (Test-Path "jest.config.js")) {
                    $jestConfig = @"
module.exports = {
  testEnvironment: 'node',
  roots: ['<rootDir>/src', '<rootDir>/test'],
  testMatch: ['**/__tests__/**/*.(js|ts)', '**/*.(test|spec).(js|ts)'],
  coverageDirectory: 'coverage',
  collectCoverageFrom: [
    'src/**/*.(js|ts)',
    '!src/**/*.d.ts',
    '!src/**/*.test.(js|ts)',
    '!src/**/*.spec.(js|ts)'
  ],
  coverageReporters: ['text', 'lcov', 'html'],
  coverageThreshold: {
    global: {
      branches: 80,
      functions: 80,
      lines: 80,
      statements: 80
    }
  }
};
"@
                    $jestConfig | Out-File "jest.config.js" -Encoding UTF8
                    $TestingSetup.setup_summary.configuration_files_created += "jest.config.js"
                }
            }
            
            "python" {
                # Setup pytest if no framework exists
                if ($TestingSetup.existing_infrastructure.test_frameworks.Count -eq 0) {
                    Write-StatusMessage "Installing pytest testing framework..." "INFO"
                    & pip install pytest pytest-cov pytest-mock
                    if ($LASTEXITCODE -eq 0) {
                        $TestingSetup.setup_summary.frameworks_installed += "pytest"
                        $TestingSetup.setup_summary.dependencies_added += @("pytest-cov", "pytest-mock")
                    }
                }
                
                # Create pytest.ini if it doesn't exist
                if (-not (Test-Path "pytest.ini")) {
                    $pytestConfig = @"
[tool:pytest]
testpaths = tests
python_files = test_*.py *_test.py
python_classes = Test*
python_functions = test_*
addopts = --cov=src --cov-report=html --cov-report=term-missing --cov-fail-under=80
"@
                    $pytestConfig | Out-File "pytest.ini" -Encoding UTF8
                    $TestingSetup.setup_summary.configuration_files_created += "pytest.ini"
                }
            }
            
            "java" {
                # Add JUnit if no framework exists
                if ($TestingSetup.existing_infrastructure.test_frameworks.Count -eq 0) {
                    Write-StatusMessage "JUnit setup needed - add to pom.xml or build.gradle" "INFO"
                    $TestingSetup.setup_summary.frameworks_installed += "junit (manual setup required)"
                }
            }
            
            "dotnet" {
                # Setup xUnit if no framework exists
                if ($TestingSetup.existing_infrastructure.test_frameworks.Count -eq 0) {
                    Write-StatusMessage "Creating test project with xUnit..." "INFO"
                    & dotnet new xunit -n "Tests" -o "Tests"
                    if ($LASTEXITCODE -eq 0) {
                        $TestingSetup.setup_summary.frameworks_installed += "xunit"
                        $TestingSetup.setup_summary.test_directories_created += "Tests"
                    }
                }
            }
            
            "go" {
                # Go has built-in testing
                Write-StatusMessage "Go has built-in testing framework" "INFO"
                $TestingSetup.setup_summary.frameworks_installed += "go test (built-in)"
            }
            
            "rust" {
                # Rust has built-in testing
                Write-StatusMessage "Rust has built-in testing framework" "INFO"
                $TestingSetup.setup_summary.frameworks_installed += "cargo test (built-in)"
            }
        }
        
        # Create test directories if they don't exist
        $testDirs = @("test", "tests", "__tests__")
        foreach ($dir in $testDirs) {
            if (-not (Test-Path $dir)) {
                New-Item -ItemType Directory -Path $dir -Force | Out-Null
                $TestingSetup.setup_summary.test_directories_created += $dir
                break
            }
        }
        
    } finally {
        Pop-Location
    }
}

function Generate-TestingRecommendations {
    Write-StatusMessage "Generating testing recommendations..." "INFO"
    
    # Define testing tools based on project type
    switch ($ProjectType.ToLower()) {
        "nodejs" {
            $TestingSetup.testing_tools.unit_testing = @("Jest", "Mocha", "Vitest")
            $TestingSetup.testing_tools.integration_testing = @("Cypress", "Playwright", "Supertest")
            $TestingSetup.testing_tools.coverage_tools = @("nyc", "istanbul", "c8")
            $TestingSetup.testing_tools.mocking_libraries = @("sinon", "jest.mock", "nock")
        }
        "python" {
            $TestingSetup.testing_tools.unit_testing = @("pytest", "unittest", "nose2")
            $TestingSetup.testing_tools.integration_testing = @("pytest", "selenium", "requests-mock")
            $TestingSetup.testing_tools.coverage_tools = @("pytest-cov", "coverage.py")
            $TestingSetup.testing_tools.mocking_libraries = @("pytest-mock", "unittest.mock", "responses")
        }
        "java" {
            $TestingSetup.testing_tools.unit_testing = @("JUnit 5", "TestNG")
            $TestingSetup.testing_tools.integration_testing = @("Spring Boot Test", "Testcontainers")
            $TestingSetup.testing_tools.coverage_tools = @("JaCoCo", "Cobertura")
            $TestingSetup.testing_tools.mocking_libraries = @("Mockito", "PowerMock", "EasyMock")
        }
        "dotnet" {
            $TestingSetup.testing_tools.unit_testing = @("xUnit", "NUnit", "MSTest")
            $TestingSetup.testing_tools.integration_testing = @("ASP.NET Core Test", "TestContainers")
            $TestingSetup.testing_tools.coverage_tools = @("coverlet", "dotCover")
            $TestingSetup.testing_tools.mocking_libraries = @("Moq", "NSubstitute", "FakeItEasy")
        }
        "go" {
            $TestingSetup.testing_tools.unit_testing = @("go test", "testify")
            $TestingSetup.testing_tools.integration_testing = @("go test", "httptest")
            $TestingSetup.testing_tools.coverage_tools = @("go test -cover")
            $TestingSetup.testing_tools.mocking_libraries = @("testify/mock", "gomock")
        }
        "rust" {
            $TestingSetup.testing_tools.unit_testing = @("cargo test", "rstest")
            $TestingSetup.testing_tools.integration_testing = @("cargo test", "tokio-test")
            $TestingSetup.testing_tools.coverage_tools = @("tarpaulin", "grcov")
            $TestingSetup.testing_tools.mocking_libraries = @("mockall", "mockers")
        }
    }
    
    # Generate recommendations
    $TestingSetup.recommended_structure.test_directories = @("tests/unit", "tests/integration", "tests/e2e")
    $TestingSetup.recommended_structure.naming_conventions = @("test_*.py", "*.test.js", "*Test.java", "*_test.go")
    $TestingSetup.recommended_structure.file_patterns = @("Arrange-Act-Assert", "Given-When-Then", "Test-First Development")
    
    # Coverage thresholds
    $TestingSetup.configuration.coverage_thresholds = @{
        statements = 80
        branches = 80
        functions = 80
        lines = 80
    }
    
    # Next steps
    if ($TestingSetup.existing_infrastructure.test_files.Count -eq 0) {
        $TestingSetup.next_steps += "Create initial test files for core functionality"
    }
    
    if ($TestingSetup.existing_infrastructure.test_frameworks.Count -eq 0) {
        $TestingSetup.next_steps += "Complete testing framework setup and configuration"
    }
    
    $TestingSetup.next_steps += "Establish testing standards and conventions"
    $TestingSetup.next_steps += "Set up continuous integration with automated testing"
    $TestingSetup.next_steps += "Create test data and fixtures for comprehensive testing"
}

# Main execution
Write-StatusMessage "Starting testing framework setup..." "INFO"

if (-not (Test-ProjectPath)) {
    exit 1
}

try {
    # Analyze existing infrastructure
    Analyze-ExistingInfrastructure
    
    # Setup testing framework
    Setup-TestingFramework
    
    # Generate recommendations
    Generate-TestingRecommendations
    
    # Determine setup status
    if ($TestingSetup.setup_summary.frameworks_installed.Count -gt 0 -or 
        $TestingSetup.existing_infrastructure.test_frameworks.Count -gt 0) {
        $TestingSetup.setup_summary.setup_status = "completed"
    } else {
        $TestingSetup.setup_summary.setup_status = "partial"
    }
    
    # Save results
    $outputFile = Join-Path $OutputPath "2-quality-baselining-2-testing-setup.json"
    $TestingSetup | ConvertTo-Json -Depth 10 | Out-File $outputFile -Encoding UTF8
    
    Write-StatusMessage "Testing framework setup saved to: $outputFile" "SUCCESS"
    Write-StatusMessage "Setup status: $($TestingSetup.setup_summary.setup_status)" "INFO"
    
} catch {
    Write-StatusMessage "Error during testing setup: $($_.Exception.Message)" "ERROR"
    exit 1
}

exit 0
