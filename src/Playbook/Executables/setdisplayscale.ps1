# Load the default user hive and set properties
REG LOAD HKU\Default_User C:\users\default\ntuser.dat
New-ItemProperty -Path registry::"HKU\Default_User\Control Panel\Desktop" -Name LogPixels -Value 96 -Type DWord
New-ItemProperty -Path registry::"HKU\Default_User\Control Panel\Desktop" -Name Win8DpiScaling -Value 1 -Type DWord
REG UNLOAD HKU\Default_User

# Define the SID pattern
$PatternSID = 'S-1-5-21-\d+-\d+-\d+-\d+$'

# Get the list of user profiles
$ProfileList = Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\*' | 
    Where-Object { $_.PSChildName -match $PatternSID } | 
    Select-Object @{Name="SID"; Expression={$_.PSChildName}}, 
                   @{Name="UserHive"; Expression={"$($_.ProfileImagePath)\ntuser.dat"}}, 
                   @{Name="Username"; Expression={$_.ProfileImagePath -replace '^(.*[\\\/])', ''}}

# Get the list of currently loaded user hives
$LoadedHives = Get-ChildItem Registry::HKEY_USERS | 
    Where-Object { $_.PSChildName -match $PatternSID } | 
    Select-Object @{Name="SID"; Expression={$_.PSChildName}}

# Determine which profiles are not loaded
$UnloadedHives = Compare-Object $ProfileList.SID $LoadedHives.SID | 
    Select-Object @{Name="SID"; Expression={$_.InputObject}}, 
                   UserHive, 
                   Username

# Process each profile
foreach ($item in $ProfileList) {
    if ($item.SID -in $UnloadedHives.SID) {
        reg load HKU\$($item.SID) $($item.UserHive) | Out-Null
    }

    "{0}" -f $($item.Username) | Write-Output
    New-ItemProperty -Path registry::"HKU\$($item.SID)\Control Panel\Desktop" -Name LogPixels -Value 96 -Type DWord -Force
    New-ItemProperty -Path registry::"HKU\$($item.SID)\Control Panel\Desktop" -Name Win8DpiScaling -Value 1 -Type DWord -Force

    if ($item.SID -in $UnloadedHives.SID) {
        [gc]::Collect()
        reg unload HKU\$($item.SID) | Out-Null
    }
}
