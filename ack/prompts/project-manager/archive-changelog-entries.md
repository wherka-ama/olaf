---
name: archive-changelog-entries
description: Archive changelog entries older than a specified number of days to maintain a clean and organized changelog register.
tags: [changelog, archive, maintenance, automation]
---

## Input Parameters
**IMPORTANT**: When you don't have entries provided, ask the USER to provide them.
- **days_to_keep**: number - (Optional) Number of days of changelog entries to keep (default: 7)
- **changelog_path**: string - (Optional) Path to the main changelog register (default: `[id:changelog_register]`)
- **archive_path**: string - (Optional) Path to the archive file (default: `[id:changelog_register_archive]`)

## Process

1. **Initialization**:
   - Verify file paths and permissions
   - Validate input parameters
   - Create backup of current files

2. **Archival Process**:
   - Identify entries older than specified days
   - Move old entries to archive file
   - Maintain proper formatting and structure
   - Preserve all metadata and timestamps

3. **Maintenance Entry**:
   - Add maintenance entry to changelog
   - Include summary of archived entries
   - Record archiving details

4. **Validation**:
   - Verify entry selection accuracy
   - Check file integrity
   - Confirm maintenance entry was added
   - Validate archive file format

## Output/Result Format
- Updated changelog register with recent entries only
- Archive file with older entries
- Maintenance entry in changelog
- Summary report of actions taken

## Output to USER
1. **Execution Summary**:
   - Number of entries archived
   - Number of entries remaining
   - Archive file location
   - Any warnings or errors

2. **Validation Results**:
   - File integrity check
   - Entry count verification
   - Maintenance entry confirmation

## Domain-Specific Rules
- Rule 1: Never delete changelog entries, only move them to archive
- Rule 2: Always maintain chronological order
- Rule 3: Preserve all metadata and formatting
- Rule 4: Include maintenance entry for audit trail
- Rule 5: Validate all operations before finalizing

## Required Actions
1. Verify file paths and permissions
2. Execute archival process
3. Add maintenance entry
4. Validate results
5. Report outcomes

## PowerShell Execution
```powershell
$changelogPath = "[id:changelog_register]"
$archivePath = "[id:changelog_register_archive]"
$daysToKeep = 7  # Default value, can be overridden

& "[id:tools_dir]archive-changelog-entries.ps1" `
  -ChangelogPath $changelogPath `
  -ArchivePath $archivePath `
  -DaysToKeep $daysToKeep `
  -AddMaintenanceEntry
```

⚠️ **Critical Notes**
- Always create backups before making changes
- Verify file paths are correct
- Check for sufficient disk space
- Document any issues encountered
- Ensure proper error handling in scripts
