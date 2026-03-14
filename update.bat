@echo off
chcp 65001 >nul
cd /d %~dp0
echo =====================================
echo yt-dlp Menu Updater
echo =====================================
set PS=powershell -NoProfile -ExecutionPolicy Bypass -Command $ProgressPreference='SilentlyContinue';

echo Updating update.bat...
%PS% "Invoke-WebRequest https://github.com/n624-dev/yt-dlp-PowerShell-menu/releases/latest/download/update.bat -OutFile update.bat"

REM 新しい update.bat を別プロセスで起動し、自身は終了
REM --continued フラグで「続きから」と伝える
if "%1"=="--continued" goto :continued

cmd /c "%~dp0update.bat" --continued
exit

:continued
echo Updating menu.ps1...
%PS% "Invoke-WebRequest https://github.com/n624-dev/yt-dlp-PowerShell-menu/releases/latest/download/menu.ps1 -OutFile menu.ps1"

echo.
echo Done!
pause
```

## 仕組み
```
初回実行 (引数なし)
  │
  ├─ update.bat を上書きダウンロード
  │
  ├─ cmd /c update.bat --continued  ← 新プロセスで新しいファイルを起動
  │
  └─ exit  ← 自身（古いプロセス）を終了

新プロセス (--continued あり)
  │
  └─ :continued ラベルにジャンプして残りを実行
