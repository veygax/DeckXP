@echo off
setlocal

set "currentDir=%~dp0"
set "startupFolder=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"
set "scriptName=Scripts\postinstall.ps1"
set "shortcutPath=%startupFolder%\DeckXP-Postinstall.lnk"

powershell -Command ^
  $wShell = New-Object -ComObject WScript.Shell; ^
  $shortcut = $wShell.CreateShortcut('%shortcutPath%'); ^
  $shortcut.TargetPath = 'powershell.exe'; ^
  $shortcut.Arguments = '-ExecutionPolicy Bypass -File "%currentDir%%scriptName%"'; ^
  $shortcut.WorkingDirectory = '%currentDir%'; ^
  $shortcut.Save()

endlocal
