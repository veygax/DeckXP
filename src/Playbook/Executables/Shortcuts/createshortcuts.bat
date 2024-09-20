@echo off
setlocal

:: Define variables
set "steamPath=C:\Program Files (x86)\Steam\Steam.exe"
set "desktop=%USERPROFILE%\Desktop"
set "shortcutPath=%desktop%\Return to Gaming Mode.lnk"
set "iconUrl=https://drive.google.com/uc?export=download&id=1KdbDLKe36HtutAfzo6zzUcNEKZ1_WMYq"
set "iconFolder=%USERPROFILE%\DeckXP"
set "iconPath=%iconFolder%\steam_bigpicture.ico"

if not exist "%iconFolder%" mkdir "%iconFolder%"

if not exist "%iconPath%" (
    echo Icon not found, downloading...
    powershell -Command "Invoke-WebRequest -Uri '%iconUrl%' -OutFile '%iconPath%'"
)
powershell -Command ^
  $wShell = New-Object -ComObject WScript.Shell; ^
  $shortcut = $wShell.CreateShortcut('%shortcutPath%'); ^
  $shortcut.TargetPath = '%steamPath%'; ^
  $shortcut.Arguments = '-start steam://open/bigpicture'; ^
  $shortcut.IconLocation = '%iconPath%'; ^
  $shortcut.Save()

endlocal
