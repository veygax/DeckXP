$username = (Get-WmiObject -Class Win32_ComputerSystem).UserName.Split('\')[-1]

$Password = ""
Set-LocalUser -Name $username -Password (ConvertTo-SecureString -AsPlainText $Password -Force)

$RegPath = "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"

Set-ItemProperty -Path $RegPath -Name "AutoAdminLogon" -Value "1"
Set-ItemProperty -Path $RegPath -Name "DefaultUserName" -Value $username
Set-ItemProperty -Path $RegPath -Name "DefaultPassword" -Value $Password
Set-ItemProperty -Path $RegPath -Name "AutoLogonCount" -Value 1

Set-ItemProperty -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "DisableCAD" -Value "1"

$PasswordLessPath = "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI"
Set-ItemProperty -Path $PasswordLessPath -Name "DevicePasswordLessBuildVersion" -Value "0"