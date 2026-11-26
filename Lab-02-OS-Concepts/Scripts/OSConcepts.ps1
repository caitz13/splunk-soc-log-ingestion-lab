# --- Run as Administrator ---

# Enable useful audit subcategories (success/failure)
$subcats = @(
  'Process Creation',
  'Registry',
  'Security System Extension',
  'System Integrity',
  'MPSSVC Rule-Level Policy Change',
  'Filtering Platform Policy Change',
  'Other Policy Change Events',
  'Other System Events'      # includes 4719 policy changes
)
foreach ($s in $subcats) {
  auditpol /set /subcategory:"$s" /success:enable /failure:enable | Out-Null
}

# Include FULL command line in 4688 events
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System\Audit" `
  /v ProcessCreationIncludeCmdLine_Enabled /t REG_DWORD /d 1 /f | Out-Null

# --- Time sync sanity (helps SIEM correlation) ---

# If domain-joined, use domain hierarchy; otherwise use manual peers
$domainJoined = (Get-CimInstance Win32_ComputerSystem).PartOfDomain
if ($domainJoined) {
  w32tm /config /syncfromflags:domhier /update | Out-Null
} else {
  # A small, reliable peer list; 0x9 = client + special poll
  w32tm /config /manualpeerlist:"time.windows.com,0x9 time.cloudflare.com,0x9 time.google.com,0x9" `
        /syncfromflags:manual /update | Out-Null
}

# Ensure Windows Time service is enabled and running
Set-Service -Name W32Time -StartupType Automatic
if ((Get-Service W32Time).Status -ne 'Running') { Start-Service W32Time }

# Force a resync and show status
w32tm /resync /force
w32tm /query /status
w32tm /query /peers


