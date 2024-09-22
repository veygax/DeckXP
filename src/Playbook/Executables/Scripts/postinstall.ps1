$landscapeScript = Resolve-Path "setdisplaytolandscape.ps1"

powershell -ExecutionPolicy Unrestricted -File $landscapeScript 0 90

# Optional delay
Start-Sleep -Seconds 1

$startupFolder = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup"
$startupShortcut = [System.IO.Path]::Combine($startupFolder, "DeckXP-Postinstall.lnk")
if (Test-Path $startupShortcut) {
    Remove-Item $startupShortcut -Force
}
