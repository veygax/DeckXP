$username = (Get-WmiObject -Class Win32_ComputerSystem).UserName

$Password = "deckxp"
net user $username $Password /expires:never

$RegPath = "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"

Set-ItemProperty -Path $RegPath -Name "DefaultUserName" -Value $username
Set-ItemProperty -Path $RegPath -Name "AutoAdminLogon" -Value "1"
Set-ItemProperty -Path $RegPath -Name "DefaultPassword" -Value $Password

Set-ItemProperty -Path "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "DisableCAD" -Value "1"