@echo off
chcp 65001 >nul
cd /d %~dp0

echo =====================================
echo yt-dlp Menu Installer
echo =====================================

set PS=powershell -NoProfile -ExecutionPolicy Bypass -Command

echo [1/6] menu.ps1
%PS% "Invoke-WebRequest https://github.com/n624-dev/yt-dlp-PowerShell-menu/releases/latest/download/menu.ps1 -OutFile menu.ps1"

echo [2/6] 7zr.exe
%PS% "Invoke-WebRequest https://www.7-zip.org/a/7zr.exe -OutFile 7zr.exe"

echo [3/6] yt-dlp.exe
%PS% "Invoke-WebRequest https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp.exe -OutFile yt-dlp.exe"

echo [4/6] FFmpeg
%PS% "Invoke-WebRequest https://www.gyan.dev/ffmpeg/builds/ffmpeg-release-essentials.zip -OutFile ffmpeg.zip"

echo 展開中...
"%CD%\7zr.exe" e ffmpeg.zip -ir!ffmpeg.exe -ir!ffprobe.exe -y -r
del ffmpeg.zip

echo [5/6] Deno
powershell -NoProfile -ExecutionPolicy Bypass -Command "irm https://deno.land/install.ps1 | iex"

echo [6/6] Shortcut

set TARGET=%CD%\menu.ps1
set SHORTCUT=%USERPROFILE%\Desktop\yt-dlp Menu.lnk

powershell -NoProfile -Command ^
"$s=(New-Object -COM WScript.Shell).CreateShortcut('%SHORTCUT%'); ^
$s.TargetPath='powershell.exe'; ^
$s.Arguments='-ExecutionPolicy Bypass -File \"%TARGET%\"'; ^
$s.WorkingDirectory='%CD%'; ^
$s.Save()"

echo 完了しました
pause