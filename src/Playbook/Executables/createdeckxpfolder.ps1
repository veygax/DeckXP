$userDir = [Environment]::GetFolderPath('UserProfile')

$deckXPPath = Join-Path $userDir "DeckXP"

if (-not (Test-Path $deckXPPath)) {
    New-Item -Path $deckXPPath -ItemType Directory
}

[System.Environment]::SetEnvironmentVariable("deckxppath", $deckXPPath, [System.EnvironmentVariableTarget]::User)