@echo off
title KING VON HAS REINCARNATED
color 0F
mode 1000

:: Download MP3 to %TEMP%
powershell -command "Invoke-WebRequest -Uri 'https://github.com/hoursinblack/quizlethack/raw/main/King%20Von%20-%20Armed%20%26%20Dangerous%20(Audio).mp3' -OutFile $env:TEMP\von.mp3"

:: Max out volume loop (requires nircmd or alternative tool)
start "" powershell -command "while ($true) { (New-Object -ComObject WScript.Shell).SendKeys([char]175); Start-Sleep -Milliseconds 300 }"

:: Fullscreen black window
start "" cmd /c "color 0F && mode con: cols=500 lines=300 && :a && cls && timeout /t 1 >nul && goto a"

:: Audio playback loop
start "" powershell -command "while ($true) { Start-Process -WindowStyle Hidden -FilePath 'wmplayer' -ArgumentList \"$env:TEMP\von.mp3\"; Start-Sleep -Seconds 30 }"
