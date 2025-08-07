# Find-OrphanedFiles.ps1
# Finds files in tools_dir and templates_dir that are never referenced in prompts_dir .md files

function Resolve-IdMapping {
    param([string]$Id)
    
    $idMappings = @{
        'tools_dir' = 'c:\Users\ppaccaud\coderepos\olaf-official\ack\tools'
        'templates_dir' = 'c:\Users\ppaccaud\coderepos\olaf-official\ack\templates'
        'prompts_dir' = 'c:\Users\ppaccaud\coderepos\olaf-official\ack\prompts'
    }
    
    return $idMappings[$Id]
}

function Get-RelativePathFromAck {
    param([string]$FullPath)
    
    $ackBasePath = 'c:\Users\ppaccaud\coderepos\olaf-official\ack'
    if ($FullPath.StartsWith($ackBasePath, [System.StringComparison]::OrdinalIgnoreCase)) {
        $relativePath = $FullPath.Substring($ackBasePath.Length)
        # Remove leading slash/backslash and convert to forward slashes
        $relativePath = $relativePath.TrimStart('\', '/').Replace('\', '/')
        return "/ack/$relativePath"
    }
    return $FullPath
}

function Get-AllFilesInDirectory {
    param([string]$DirectoryPath)
    
    $files = @()
    if (Test-Path $DirectoryPath) {
        Get-ChildItem -Path $DirectoryPath -Recurse -File | ForEach-Object {
            $relativePath = $_.FullName.Substring($DirectoryPath.Length + 1)
            $files += $relativePath
        }
    }
    return $files
}

function Find-FileReferences {
    param([string]$FileName, [string]$PromptsDir, [string]$ToolsDir)
    
    $references = @()
    
    # Handle subdirectory paths - extract just the filename for some patterns
    $fileNameOnly = Split-Path $FileName -Leaf
    $subPath = $FileName.Replace('\', '/')
    
    $patterns = @(
        # Pattern for [id:directory]path/filename (handles subdirectories)
        "\[id:(tools_dir|templates_dir)\]$([regex]::Escape($subPath))",
        # Pattern for [id:directory]filename (just filename)
        "\[id:(tools_dir|templates_dir)\]$([regex]::Escape($fileNameOnly))",
        # Pattern for direct paths like templates/path/filename
        "templates/$([regex]::Escape($subPath))",
        "tools/$([regex]::Escape($subPath))",
        # Pattern for PowerShell script calls (for tool scripts)
        "\&\s*[`"'].*$([regex]::Escape($fileNameOnly))[`"']",
        "Invoke-Expression.*$([regex]::Escape($fileNameOnly))",
        "\.\\$([regex]::Escape($fileNameOnly))",
        # Pattern for direct filename references
        "$([regex]::Escape($fileNameOnly))"
    )
    
    # Search in prompts directory (.md files)
    Get-ChildItem -Path $PromptsDir -Recurse -Filter "*.md" | ForEach-Object {
        $filePath = $_.FullName
        try {
            $content = [System.IO.File]::ReadAllText($filePath)
            
            foreach ($pattern in $patterns) {
                if ($content -match $pattern) {
                    $references += @{
                        File = $filePath
                        Pattern = $pattern
                        FoundIn = "prompts"
                    }
                    break
                }
            }
        }
        catch {
            Write-Warning "Could not read file: $filePath - $($_.Exception.Message)"
        }
    }
    
    # Search in tools directory (.ps1 files) for tool script references
    Get-ChildItem -Path $ToolsDir -Recurse -Filter "*.ps1" | ForEach-Object {
        $filePath = $_.FullName
        # Skip searching the file for references to itself
        if ($filePath -eq (Join-Path $ToolsDir $FileName)) {
            return
        }
        
        try {
            $content = [System.IO.File]::ReadAllText($filePath)
            
            foreach ($pattern in $patterns) {
                if ($content -match $pattern) {
                    $references += @{
                        File = $filePath
                        Pattern = $pattern
                        FoundIn = "tools"
                    }
                    break
                }
            }
        }
        catch {
            Write-Warning "Could not read file: $filePath - $($_.Exception.Message)"
        }
    }
    
    return $references
}

function Test-OrphanedFiles {
    $toolsDir = Resolve-IdMapping -Id 'tools_dir'
    $templatesDir = Resolve-IdMapping -Id 'templates_dir'
    $promptsDir = Resolve-IdMapping -Id 'prompts_dir'
    
    Write-Host "Finding orphaned files in tools and templates directories..." -ForegroundColor Yellow
    Write-Host "Tools directory: $toolsDir" -ForegroundColor Gray
    Write-Host "Templates directory: $templatesDir" -ForegroundColor Gray
    Write-Host "Prompts directory: $promptsDir" -ForegroundColor Gray
    Write-Host ""
    
    $orphanedFiles = @()
    $totalFiles = 0
    $referencedFiles = 0
    
    # Check tools directory
    Write-Host "Scanning tools directory..." -ForegroundColor Cyan
    $toolsFiles = Get-AllFilesInDirectory -DirectoryPath $toolsDir
    foreach ($file in $toolsFiles) {
        $totalFiles++
        $references = Find-FileReferences -FileName $file -PromptsDir $promptsDir -ToolsDir $toolsDir
        
        if ($references.Count -eq 0) {
            $fullPath = Join-Path $toolsDir $file
            $relativePath = Get-RelativePathFromAck -FullPath $fullPath
            $orphanedFiles += @{
                Directory = 'tools_dir'
                FileName = $file
                FullPath = $fullPath
                RelativePath = $relativePath
            }
            Write-Host "  ORPHANED: $relativePath" -ForegroundColor Red
        } else {
            $referencedFiles++
            $promptRefs = ($references | Where-Object FoundIn -eq "prompts").Count
            $toolRefs = ($references | Where-Object FoundIn -eq "tools").Count
            $refInfo = ""
            if ($promptRefs -gt 0 -and $toolRefs -gt 0) {
                $refInfo = "($promptRefs in prompts, $toolRefs in tools)"
            } elseif ($promptRefs -gt 0) {
                $refInfo = "($promptRefs in prompts)"
            } elseif ($toolRefs -gt 0) {
                $refInfo = "($toolRefs in tools)"
            }
            Write-Host "  Referenced: $file $refInfo" -ForegroundColor Green
        }
    }
    
    # Check templates directory
    Write-Host "`nScanning templates directory..." -ForegroundColor Cyan
    $templatesFiles = Get-AllFilesInDirectory -DirectoryPath $templatesDir
    foreach ($file in $templatesFiles) {
        $totalFiles++
        $references = Find-FileReferences -FileName $file -PromptsDir $promptsDir -ToolsDir $toolsDir
        
        if ($references.Count -eq 0) {
            $fullPath = Join-Path $templatesDir $file
            $relativePath = Get-RelativePathFromAck -FullPath $fullPath
            $orphanedFiles += @{
                Directory = 'templates_dir'
                FileName = $file
                FullPath = $fullPath
                RelativePath = $relativePath
            }
            Write-Host "  ORPHANED: $relativePath" -ForegroundColor Red
        } else {
            $referencedFiles++
            $promptRefs = ($references | Where-Object FoundIn -eq "prompts").Count
            $toolRefs = ($references | Where-Object FoundIn -eq "tools").Count
            $refInfo = ""
            if ($promptRefs -gt 0 -and $toolRefs -gt 0) {
                $refInfo = "($promptRefs in prompts, $toolRefs in tools)"
            } elseif ($promptRefs -gt 0) {
                $refInfo = "($promptRefs in prompts)"
            } elseif ($toolRefs -gt 0) {
                $refInfo = "($toolRefs in tools)"
            }
            Write-Host "  Referenced: $file $refInfo" -ForegroundColor Green
        }
    }
    
    # Summary report
    Write-Host "`n" + "="*60 -ForegroundColor Yellow
    Write-Host "ORPHANED FILES SUMMARY" -ForegroundColor Yellow
    Write-Host "="*60 -ForegroundColor Yellow
    
    Write-Host "Total files scanned: $totalFiles" -ForegroundColor White
    Write-Host "Referenced files: $referencedFiles" -ForegroundColor Green
    Write-Host "Orphaned files: $($orphanedFiles.Count)" -ForegroundColor $(if ($orphanedFiles.Count -gt 0) { 'Red' } else { 'Green' })
    
    if ($orphanedFiles.Count -gt 0) {
        Write-Host "`nOrphaned files by directory:" -ForegroundColor Yellow
        
        $groupedOrphans = $orphanedFiles | Group-Object Directory
        foreach ($group in $groupedOrphans) {
            Write-Host "`n$($group.Name):" -ForegroundColor Cyan
            foreach ($file in $group.Group) {
                Write-Host "  - $($file.FileName)" -ForegroundColor Red
                Write-Host "    Path: $($file.RelativePath)" -ForegroundColor Gray
            }
        }
        
        Write-Host "`nThese files may be candidates for cleanup if they are truly unused." -ForegroundColor Yellow
        Write-Host "Please review each file before deletion to ensure it's not needed." -ForegroundColor Yellow
    } else {
        Write-Host "`nAll files are properly referenced! No orphaned files found." -ForegroundColor Green
    }
    
    Write-Host "`nOrphaned file analysis complete!" -ForegroundColor Yellow
}

# Run the analysis
Test-OrphanedFiles
