@echo off
chcp 65001 >nul
cd /d %~dp0

echo =====================================
echo yt-dlp Menu Installer
echo =====================================

set PS=powershell -NoProfile -ExecutionPolicy Bypass -Command

set SEVEN_ZR_URL=https://www.7-zip.org/a/7zr.exe
set SEVEN_ZR_EXE=%~dp07zr.exe
set TEMP_DIR=%~dp0ffmpeg_temp
set ARCHIVE_NAME=ffmpeg.7z

echo [1/6] menu.ps1
%PS% "Invoke-WebRequest https://github.com/n624-dev/yt-dlp-PowerShell-menu/releases/latest/download/menu.ps1 -OutFile menu.ps1"

echo [2/6] 7zr.exe
%PS% "Invoke-WebRequest '%SEVEN_ZR_URL%' -OutFile '%SEVEN_ZR_EXE%'"

echo [3/6] yt-dlp.exe
%PS% "Invoke-WebRequest https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp.exe -OutFile yt-dlp.exe"

echo [4/6] FFmpeg
%PS% "Invoke-WebRequest https://www.gyan.dev/ffmpeg/builds/ffmpeg-release-essentials.7z -OutFile ffmpeg.7z"

mkdir "%TEMP_DIR%"
7zr x "%ARCHIVE_NAME%" -o"%TEMP_DIR%" >nul

echo FFmpeg をコピー中...
for %%F in (ffmpeg.exe ffplay.exe ffprobe.exe) do (
  for /r "%TEMP_DIR%" %%P in (%%F) do (
    copy /Y "%%P" "%~dp0" >nul
  )
)

echo 余分なファイルを削除中...
rd /s /q "%TEMP_DIR%"
del "%ARCHIVE_NAME%" 2>nul

echo [5/6] Deno
powershell -NoProfile -ExecutionPolicy Bypass -Command "irm https://deno.land/install.ps1 | iex"

echo [6/6] Shortcut

REM menu.ps1 の場所（このbatと同じフォルダ）
set "TARGET=%~dp0menu.ps1"

REM 同じフォルダにショートカットを作成
set "SHORTCUT=%~dp0yt-dlp Menu.lnk"

powershell -NoProfile -Command ^
"$WshShell = New-Object -ComObject WScript.Shell; ^
$Shortcut = $WshShell.CreateShortcut('%SHORTCUT%'); ^
$Shortcut.TargetPath = 'powershell.exe'; ^
$Shortcut.Arguments = '-NoProfile -ExecutionPolicy Bypass -File \"%TARGET%\"'; ^
$Shortcut.WorkingDirectory = '%~dp0'; ^
$Shortcut.Save()"

echo Shortcut created: %SHORTCUT%

echo 完了しました
pause
