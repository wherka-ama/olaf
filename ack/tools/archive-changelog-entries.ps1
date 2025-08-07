#!/usr/bin/env pwsh
# archive-changelog-entries.ps1
# Script to archive changelog entries older than a specified number of days

param (
    [Parameter(Mandatory=$true)]
    [string]$ChangelogPath,
    
    [Parameter(Mandatory=$true)]
    [string]$ArchivePath,
    
    [Parameter(Mandatory=$false)]
    [int]$DaysToKeep = 7,
    
    [Parameter(Mandatory=$false)]
    [switch]$AddMaintenanceEntry = $true
)

# Validate paths
if (-not (Test-Path -Path $ChangelogPath)) {
    Write-Error "Changelog file not found at path: $ChangelogPath"
    exit 1
}

# Calculate cutoff date
$today = Get-Date
$cutoffDate = $today.AddDays(-$DaysToKeep)
$cutoffString = $cutoffDate.ToString("YYYYMMDD")
Write-Host "Today: $today"
Write-Host "Cutoff date ($DaysToKeep days ago): $cutoffDate"
Write-Host "Will archive entries before: $cutoffString"

# Read the changelog content
$content = Get-Content -Path $ChangelogPath -Raw
$lines = $content -split '\r?\n'

# Create arrays to hold kept and archived content
$keptLines = @()
$archivedLines = @()
$inHeaderSection = $true
$inOldSection = $false
$currentDate = ""
$headerEndIndex = 0

# Process line by line to identify content to keep and archive
for ($i = 0; $i -lt $lines.Length; $i++) {
    $line = $lines[$i]
    
    # Capture the header section (everything before the first date heading)
    if ($inHeaderSection) {
        if ($line -match '^\s*#{2,3}\s+(\d{4}-\d{2}-\d{2})\s*$') {
            $inHeaderSection = $false
            $headerEndIndex = $i
            $currentDate = $matches[1]
            
            # Check if this date is before the cutoff
            if ([DateTime]::Parse($currentDate) -lt $cutoffDate) {
                $inOldSection = $true
            }
        } else {
            $keptLines += $line
        }
    }
    
    # Process content after the header
    if (-not $inHeaderSection) {
        # Check if this is a new date section
        if ($line -match '^\s*#{2,3}\s+(\d{4}-\d{2}-\d{2})\s*$') {
            $currentDate = $matches[1]
            
            # Check if this date is before the cutoff
            if ([DateTime]::Parse($currentDate) -lt $cutoffDate) {
                $inOldSection = $true
            } else {
                $inOldSection = $false
            }
        }
        
        # Add line to appropriate array
        if ($inOldSection) {
            $archivedLines += $line
        } else {
            $keptLines += $line
        }
    }
}

# Prepare the archive file if it doesn't exist
if (-not (Test-Path -Path $ArchivePath)) {
    $archiveHeader = "# Archived Changelog Entries`n`nThis file contains archived changelog entries older than $DaysToKeep days from the active changelog register.`n"
    $archiveContent = $archiveHeader
} else {
    $archiveContent = Get-Content -Path $ArchivePath -Raw
    
    # If archive already has content, check if we need to add a separator
    if (-not $archiveContent.EndsWith("`n`n")) {
        $archiveContent += "`n`n"
    }
}

# Add the archived content
if ($archivedLines.Count -gt 0) {
    $archiveContent += ($archivedLines -join "`n")
    
    # Ensure file ends with newline
    if (-not $archiveContent.EndsWith("`n")) {
        $archiveContent += "`n"
    }
    
    # Save the archive file
    Set-Content -Path $ArchivePath -Value $archiveContent
    Write-Host "Archived $($archivedLines.Count) lines to $ArchivePath"
}

# Save the updated changelog
$keptContent = $keptLines -join "`n"
Set-Content -Path $ChangelogPath -Value $keptContent
Write-Host "Kept $($keptLines.Count) lines in $ChangelogPath"

# Add maintenance entry if requested
if ($AddMaintenanceEntry) {
    $timestamp = $today.ToString("HH:mm")
    $entryDate = $today.ToString("YYYYMMDD")
    $yearMonth = $today.ToString("yyyy-MM")
    
    # Prepare the maintenance entry
    $keptEntryCount = ($keptLines | Where-Object { $_ -match '^\s*-\s+' }).Count
    $archivedEntryCount = ($archivedLines | Where-Object { $_ -match '^\s*-\s+' }).Count
    $cutoffDateStr = $cutoffDate.ToString("YYYYMMDD")
    
    $maintenanceEntry = "- $timestamp - Maintenance: Performed weekly changelog archiving. Moved entries older than $DaysToKeep days (before $cutoffDateStr) to `changelog-register-archive.md`. Maintained $keptEntryCount entries in the main file and archived $archivedEntryCount entries for improved performance. (by @HAL)"
    
    # Check if today's date section exists
    $content = Get-Content -Path $ChangelogPath -Raw
    $todaySection = "### $entryDate"
    
    if ($content -match [regex]::Escape($todaySection)) {
        # Insert at the top of today's entries
        $entryPattern = "$todaySection\r?\n((?:- .*\r?\n)*)"
        $existingEntries = [regex]::Match($content, $entryPattern).Groups[1].Value
        $updatedEntries = "$maintenanceEntry`n$existingEntries"
        $newContent = $content -replace $entryPattern, "$todaySection`n$updatedEntries"
    } else {
        # Today's section doesn't exist, check if month section exists
        $monthSection = "## $yearMonth"
        
        if ($content -match [regex]::Escape($monthSection)) {
            # Insert after month heading
            $monthPattern = "$monthSection\r?\n"
            $newContent = $content -replace $monthPattern, "$monthSection`n`n$todaySection`n$maintenanceEntry`n"
        } else {
            # Need to add both month and day sections
            $headerPattern = "# Changelog\r?\n"
            $newContent = $content -replace $headerPattern, "# Changelog`n`n## $yearMonth`n`n$todaySection`n$maintenanceEntry`n"
        }
    }
    
    # Save the updated changelog with maintenance entry
    Set-Content -Path $ChangelogPath -Value $newContent
    Write-Host "Added maintenance entry to changelog"
}

Write-Host "Changelog archiving completed successfully"
