# Create a harmless "persistence-like" entry in Run key
New-Item -Path HKCU:\Software\CySA -Force | Out-Null
New-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Run `
  -Name "CySA_Benign" -Value "notepad.exe" -Force | Out-Null

# Modify and then remove a test value to create registry churn
New-ItemProperty -Path HKCU:\Software\CySA -Name "TestValue" -Value "v1" -Force | Out-Null
Set-ItemProperty  -Path HKCU:\Software\CySA -Name "TestValue" -Value "v2"
Remove-ItemProperty -Path HKCU:\Software\CySA -Name "TestValue"

# Launch some processes to populate 4688 + Sysmon Event 1
Start-Process notepad.exe
Start-Process calc.exe
Start-Process "powershell.exe" -ArgumentList '-NoP -W Hidden -Command "Write-Output benign"'

