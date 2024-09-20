$username = (Get-WmiObject -Class Win32_ComputerSystem).UserName

$Password = "deckxp"
Set-LocalUser -Name $username -Password (ConvertTo-SecureString -AsPlainText $Password -Force)

$RegPath = "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"

Set-ItemProperty -Path $RegPath -Name "AutoAdminLogon" -Value "1" -Type STRING
Set-ItemProperty -Path $RegPath -Name "DefaultUserName" -Value $username -Type STRING
Set-ItemProperty -Path $RegPath -Name "DefaultPassword" -Value $Password -Type STRING
Set-ItemProperty -Path $RegPath -Name "AutoLogonCount" -Value 1 -Type DWORD

Set-ItemProperty -Path "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "DisableCAD" -Value "1"

$PasswordLessPath = "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI"
Set-ItemProperty -Path $PasswordLessPath -Name "DevicePasswordLessBuildVersion" -Value "0"