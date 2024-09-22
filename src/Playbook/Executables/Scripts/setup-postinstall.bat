@echo off
setlocal

set "currentDir=%~dp0"
set "startupFolder=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"
set "scriptName=postinstall.ps1"
set "setScaleScript=setdisplayscale.ps1"
set "setLandscapeScript=setdisplaytolandscape.ps1"
set "targetFolder=%userprofile%\DeckXP\Scripts"
set "shortcutPath=%startupFolder%\DeckXP-Postinstall.lnk"

if not exist "%targetFolder%" (
    mkdir "%targetFolder%"
)

copy "%currentDir%Scripts\%scriptName%" "%targetFolder%" /Y
copy "%currentDir%Scripts\%setScaleScript%" "%targetFolder%" /Y
copy "%currentDir%Scripts\%setLandscapeScript%" "%targetFolder%" /Y

powershell -Command ^
  $wShell = New-Object -ComObject WScript.Shell; ^
  $shortcut = $wShell.CreateShortcut('%shortcutPath%'); ^
  $shortcut.TargetPath = 'powershell.exe'; ^
  $shortcut.Arguments = '-ExecutionPolicy Bypass -File "%targetFolder%\%scriptName%"'; ^
  $shortcut.WorkingDirectory = '%targetFolder%'; ^
  $shortcut.Save()

endlocal