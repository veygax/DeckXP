param (
    [ValidateSet("APU", "WiFi", "Bluetooth", "SDCard", "Audio_CS35L41", "Audio_NAU88L21", "Audio_AMDAMPDriver")]
    [string]$Driver,
    [ValidateSet("OLED", "LCD")]
    [string]$Model
)

$isWin11 = (Get-WmiObject Win32_OperatingSystem).Caption -Match "Windows 11"

# OLED Functions
function Install-APUDriver_OLED {
    Write-Host "Installing APU Drivers for OLED display"
    $tempPath = "$env:TEMP\apu_driver_oled"
    $zipPath = "$tempPath.zip"
    
    Invoke-WebRequest -Uri "https://steamdeck-packages.steamos.cloud/misc/windows/drivers/GFX_Driver_48.0.8.40630.zip" -OutFile $zipPath
    Remove-Item -Recurse -Force $tempPath -ErrorAction Ignore
    Expand-Archive -Path $zipPath -DestinationPath $tempPath
    Start-Process "$tempPath\GFX_DriverGFX Driver_48.0.8.40630\Setup.exe" -ArgumentList "-install" -Wait
    Remove-Item $zipPath, $tempPath -Recurse -Force
}

function Install-WiFiDriver_OLED {
    Write-Host "Installing WiFi Drivers for OLED display"
    $tempPath = "$env:TEMP\wifi_driver_oled"
    $zipPath = "$tempPath.zip"
    
    Invoke-WebRequest -Uri "https://steamdeck-packages.steamos.cloud/misc/windows/drivers/FC66E-WIN_WiFi_driver.zip" -OutFile $zipPath
    Remove-Item -Recurse -Force $tempPath -ErrorAction Ignore
    Expand-Archive -Path $zipPath -DestinationPath $tempPath
    if ($isWin11) {
        Write-Host "Installing WiFi driver for Windows 11 (OLED)"
        pnputil /add-driver "$tempPath\FC66E-WIN_WiFi_driver\win11\Signed_1152921505697186177\drivers\be9ac925-f76a-4aab-bd0d-59f4e94c5fea\qcwlan64.inf" -install
    } else {
        Write-Host "Installing WiFi driver for Windows 10 (OLED)"
        pnputil /add-driver "$tempPath\FC66E-WIN_WiFi_driver\win10\Win10_1.0.123.1610_for_Quectel_206x\drivers\x64\qcwlan64.inf" -install
    }
    Remove-Item $zipPath, $tempPath -Recurse -Force
}

function Install-BluetoothDriver_OLED {
    Write-Host "Installing Bluetooth Drivers for OLED display"
    $tempPath = "$env:TEMP\bluetooth_driver_oled"
    $zipPath = "$tempPath.zip"
    
    Invoke-WebRequest -Uri "https://steamdeck-packages.steamos.cloud/misc/windows/drivers/FC66E-B_WIN_Bluetooth_driver.zip" -OutFile $zipPath
    Remove-Item -Recurse -Force $tempPath -ErrorAction Ignore
    Expand-Archive -Path $zipPath -DestinationPath $tempPath
    pnputil /add-driver "$tempPath\FC66E-B_WIN_Bluetooth_driver\BT\x64\qcbtuart.inf" -install
    Remove-Item $zipPath, $tempPath -Recurse -Force
}

function Install-SDCardDriver_OLED {
    Write-Host "Installing SD Card Drivers for OLED display"
    $tempPath = "$env:TEMP\sd_driver_oled"
    $zipPath = "$tempPath.zip"
    
    Invoke-WebRequest -Uri "https://steamdeck-packages.steamos.cloud/misc/windows/drivers/BayHub_SD_STOR_installV3.4.01.89_W10W11_logoed_20220228.zip" -OutFile $zipPath
    Remove-Item -Recurse -Force $tempPath -ErrorAction Ignore
    Expand-Archive -Path $zipPath -DestinationPath $tempPath
    Start-Process "$tempPath\BayHub_SD_STOR_ installV3.4.01.89_W10W11_logoed_20220228\setup.exe" -ArgumentList "-s" -Wait
    Remove-Item $zipPath, $tempPath -Recurse -Force
}

function Install-AudioDriver_CS35L41_OLED {
    Write-Host "Installing Audio Drivers (CS35L41)"
    $tempPath = "$env:TEMP\cs35l41_driver"
    $zipPath = "$tempPath.zip"
    
    Invoke-WebRequest -Uri "https://steamdeck-packages.steamos.cloud/misc/windows/drivers/Audio1_cs35l41-V1.2.1.0.zip" -OutFile $zipPath
    Remove-Item -Recurse -Force $tempPath -ErrorAction Ignore
    Expand-Archive -Path $zipPath -DestinationPath $tempPath
    pnputil /add-driver "$tempPath\cs35l41-V1.2.1.0\cs35l41.inf" -install
    Remove-Item $zipPath, $tempPath -Recurse -Force
}

function Install-AudioDriver_NAU88L21_OLED {
    Write-Host "Installing Audio Drivers (NAU88L21)"
    $tempPath = "$env:TEMP\NAU88L21_driver"
    $zipPath = "$tempPath.zip"
    
    Invoke-WebRequest -Uri "https://steamdeck-packages.steamos.cloud/misc/windows/drivers/Audio2_NAU88L21_x64_1.0.9.1_WHQL.zip" -OutFile $zipPath
    Remove-Item -Recurse -Force $tempPath -ErrorAction Ignore
    Expand-Archive -Path $zipPath -DestinationPath $tempPath
    pnputil /add-driver "$tempPath\NAU88L21_x64_1.0.9.1_WHQL\NAU88L21.inf" -install
    Remove-Item $zipPath, $tempPath -Recurse -Force
}

function Install-AMDAMPDriver_OLED {
    Write-Host "Installing AMD AMP Drivers"
    $tempPath = "$env:TEMP\amdampdriver_driver"
    $zipPath = "$tempPath.zip"
    
    Invoke-WebRequest -Uri "https://steamdeck-packages.steamos.cloud/misc/windows/drivers/amdampdriver.zip" -OutFile $zipPath
    Remove-Item -Recurse -Force $tempPath -ErrorAction Ignore
    Expand-Archive -Path $zipPath -DestinationPath $tempPath
    pnputil /add-driver "$tempPath\amdampdriver\amdi2scodec.inf" -install
    Remove-Item $zipPath, $tempPath -Recurse -Force
}

# LCD Functions
function Install-APUDriver_LCD {
    Write-Host "Installing APU Drivers for LCD display"
    $tempPath = "$env:TEMP\apu_driver_lcd"
    $zipPath = "$tempPath.zip"
    
    Invoke-WebRequest -Uri "https://steamdeck-packages.steamos.cloud/misc/windows/drivers/Aerith_Sephiroth_Windows_Driver_2309131113.zip" -OutFile $zipPath
    Remove-Item -Recurse -Force $tempPath -ErrorAction Ignore
    Expand-Archive -Path $zipPath -DestinationPath $tempPath
    Start-Process "$tempPath\GFX Driver_48.0.8.30928_230906a1-394729E-2309131113\Setup.exe" -ArgumentList "-install" -Wait
    Remove-Item $zipPath, $tempPath -Recurse -Force
}

function Install-WiFiDriver_LCD {
    Write-Host "Installing WiFi Fix"
    Start-Process -FilePath ".\SteamDeck-Windows-WiFi-Fix-main\Setup.bat" -Wait
}

function Install-BluetoothDriver_LCD {
    Write-Host "Installing Bluetooth Drivers for LCD display"
    $tempPath = "$env:TEMP\bluetooth_driver_lcd"
    $zipPath = "$tempPath.zip"
    
    Invoke-WebRequest -Uri "https://steamdeck-packages.steamos.cloud/misc/windows/drivers/FC66E-B_WIN_Bluetooth_driver.zip" -OutFile $zipPath
    Remove-Item -Recurse -Force $tempPath -ErrorAction Ignore
    Expand-Archive -Path $zipPath -DestinationPath $tempPath
    pnputil /add-driver "$tempPath\FC66E-B_WIN_Bluetooth_driver\BT\x64\qcbtuart.inf" -install
    Remove-Item $zipPath, $tempPath -Recurse -Force
}

function Install-SDCardDriver_LCD {
    Write-Host "Installing SD Card Drivers for LCD display"
    $tempPath = "$env:TEMP\sd_driver_lcd"
    $zipPath = "$tempPath.zip"
    
    Invoke-WebRequest -Uri "https://steamdeck-packages.steamos.cloud/misc/windows/drivers/BayHub_SD_STOR_installV3.4.01.89_W10W11_logoed_20220228.zip" -OutFile $zipPath
    Remove-Item -Recurse -Force $tempPath -ErrorAction Ignore
    Expand-Archive -Path $zipPath -DestinationPath $tempPath
    Start-Process "$tempPath\BayHub_SD_STOR_installV3.4.01.89_W10W11_logoed_20220228\setup.exe" -ArgumentList "-s" -Wait
    Remove-Item $zipPath, $tempPath -Recurse -Force
}

function Install-AudioDriver_CS35L41_LCD {
    Write-Host "Installing Audio Drivers (CS35L41)"
    $tempPath = "$env:TEMP\cs35l41_driver"
    $zipPath = "$tempPath.zip"
    
    Invoke-WebRequest -Uri "https://steamdeck-packages.steamos.cloud/misc/windows/drivers/cs35l41-V1.2.1.0.zip" -OutFile $zipPath
    Remove-Item -Recurse -Force $tempPath -ErrorAction Ignore
    Expand-Archive -Path $zipPath -DestinationPath $tempPath
    pnputil /add-driver "$tempPath\cs35l41-V1.2.1.0\cs35l41.inf" -install
    Remove-Item $zipPath, $tempPath -Recurse -Force
}

function Install-AudioDriver_NAU88L21_LCD {
    Write-Host "Installing Audio Drivers (NAU88L21)"
    $tempPath = "$env:TEMP\NAU88L21_driver"
    $zipPath = "$tempPath.zip"
    
    Invoke-WebRequest -Uri "https://steamdeck-packages.steamos.cloud/misc/windows/drivers/NAU88L21_x64_1.0.6.0_WHQL%20-%20DUA_BIQ_WHQL.zip" -OutFile $zipPath
    Remove-Item -Recurse -Force $tempPath -ErrorAction Ignore
    Expand-Archive -Path $zipPath -DestinationPath $tempPath
    pnputil /add-driver "$tempPath\NAU88L21_x64_1.0.6.0_WHQL - DUA_BIQ_WHQL\NAU88L21.inf" -install
    Remove-Item $zipPath, $tempPath -Recurse -Force
}


# Driver installation logic based on the display type
switch ($Driver) {
    "APU"             { if ($Model -eq "OLED") { Install-APUDriver_OLED } else { Install-APUDriver_LCD } }
    "WiFi"         { if ($Model -eq "OLED") { Install-WiFiDriver_OLED } else { Install-WiFiDriver_LCD } }
    "Bluetooth"       { if ($Model -eq "OLED") { Install-BluetoothDriver_OLED } else { Install-BluetoothDriver_LCD } }
    "SDCard"          { if ($Model -eq "OLED") { Install-SDCardDriver_OLED } else { Install-SDCardDriver_LCD } }
    "Audio_CS35L41"   { if ($Model -eq "OLED") { Install-AudioDriver_OLED } else { Install-AudioDriver_CS35L41_LCD } }
    "Audio_NAU88L21"  { if ($Model -eq "OLED") { Install-AudioDriver_OLED } else { Install-AudioDriver_NAU88L21_LCD } }
    "Audio_AMDAMPDriver"    { Install-AMDAMPDriver_OLED }
    default           { Write-Host "Invalid option. Please specify a valid driver to install." }
}
