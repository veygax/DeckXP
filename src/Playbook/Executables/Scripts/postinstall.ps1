$scriptPath = $MyInvocation.MyCommand.Path


Start-Sleep -Seconds 1  # Optional delay
Start-Process -FilePath "cmd.exe" -ArgumentList "/c del `"$scriptPath`"" -WindowStyle Hidden