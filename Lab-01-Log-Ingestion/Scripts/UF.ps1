$IndexerIP     = 10.0.0.24     # e.g., 192.168.0.10
$ReceiverPort  = 9997
$SplunkHome    = "C:\Program Files\SplunkUniversalForwarder"
$LocalPath     = Join-Path $SplunkHome "etc\system\local"
New-Item -ItemType Directory -Force -Path $LocalPath | Out-Null

# Tell the UF where to send data
@"
[tcpout]
defaultGroup = indexer_group

[tcpout:indexer_group]
server = 10.0.0.24:9997
useACK = true
"@ | Set-Content -Encoding ASCII -Path (Join-Path $LocalPath "outputs.conf")

# Basic Windows event logs (uncomment Sysmon if you use it)
@"
[default]
host = $env:COMPUTERNAME

[WinEventLog://Application]
disabled = 0
index = wineventlog

[WinEventLog://Security]
disabled = 0
index = wineventlog

[WinEventLog://System]
disabled = 0
index = wineventlog

[WinEventLog://Microsoft-Windows-Windows Firewall With Advanced Security/Firewall]
disabled = 0
renderXml = 1
index = wineventlog


[WinEventLog://Microsoft-Windows-Sysmon/Operational]
disabled = 0
renderXml = true
sourcetype = XmlWinEventLog:Microsoft-Windows-Sysmon/Operational
index = sysmon

"@ | Set-Content -Encoding ASCII -Path (Join-Path $LocalPath "inputs.conf")

# Start/Restart the UF service
$SplunkExe = Join-Path $SplunkHome "bin\splunk.exe"
& $SplunkExe restart
Set-Service -Name SplunkForwarder -StartupType Automatic 