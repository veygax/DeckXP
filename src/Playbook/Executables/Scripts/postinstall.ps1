$landscapeScript = Resolve-Path "setdisplaytolandscape.ps1"
$scaleScript = Resolve-Path "setdisplayscale.ps1"

powershell -ExecutionPolicy Unrestricted -File $landscapeScript
powershell -ExecutionPolicy Unrestricted -File $scaleScript

# Optional delay
Start-Sleep -Seconds 1

$startupFolder = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup"
$startupShortcut = [System.IO.Path]::Combine($startupFolder, "DeckXP-Postinstall.lnk")
if (Test-Path $startupShortcut) {
    Remove-Item $startupShortcut -Force
}
