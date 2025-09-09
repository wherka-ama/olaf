get-conversation-timestamp.ps1
# This script provides a properly formatted timestamp for conversation record filenames
# Format: YYYYMMDD-HHMM
#
# Usage:
#   From PowerShell: `. .\ack\tools\get-conversation-timestamp.ps1`
#   From CMD: `powershell -Command "& { . .\ack\tools\get-conversation-timestamp.ps1 }"`
#
# Purpose:
#   This tool ensures consistent timestamp formatting for conversation record filenames,
#   preventing AI models from making formatting errors when generating timestamps manually.
#
# Output:
#   A string in the format YYYYMMDD-HHMM (e.g., 2025-06-19-1245)

$timestamp = Get-Date -Format "YYYYMMDD-HHmm"
Write-Output $timestamp
