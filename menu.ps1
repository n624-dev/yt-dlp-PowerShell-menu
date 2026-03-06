# 文字コード対策（必ず「UTF-8 (BOM付き)」で保存してください）
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8
Set-Location -Path $PSScriptRoot

function Show-Menu {
    Clear-Host
    Write-Host "==============================================================" -ForegroundColor Cyan
    Write-Host "                        yt-dlp メニュー"
    Write-Host "==============================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "1. 画質一覧を表示 (-F)"
    Write-Host "-------------------------ダウンロード-------------------------"
    Write-Host "2. MP4 Youtube bv*[ext=mp4]+ba[ext=m4a]/b[ext=mp4]"
    Write-Host "3. MP4 TVer bv*+ba/b"
    Write-Host "4. 指定なし bv*+ba/b"
    Write-Host "5. 音声のみ ba"
    Write-Host "6. MP4再エンコード bv*+ba/b"
    Write-Host "7. フォーマットIDを指定"
    Write-Host "--------------------------------------------------------------"
    Write-Host "8. yt-dlpをアップデート"
    Write-Host "9. 自分でコマンド入力 (PowerShell)"
    Write-Host "0. 終了"
    Write-Host ""
}

# yt-dlp の検出（同一フォルダ優先、なければPATHを検索）
$ytCmd = Get-Command ".\yt-dlp" -ErrorAction SilentlyContinue
if (-not $ytCmd) {
    $ytCmd = Get-Command "yt-dlp" -ErrorAction SilentlyContinue
}
if (-not $ytCmd) {
    Write-Host "警告: yt-dlp が見つかりません。スクリプトと同じフォルダに yt-dlp.exe を置くか、PATHに追加してください。" -ForegroundColor Yellow
    Read-Host -Prompt "続行するには Enter キー"
    exit
}

while ($true) {
    Show-Menu
    $choice = Read-Host "番号を選んでください"

    switch ($choice) {
        "1" {
            $url = Read-Host "URLを入力"
            if (-not $url) { Write-Host "URLが指定されていません"; Read-Host -Prompt "続行するには Enter"; continue }
            & $ytCmd.Path -F $url
            Read-Host -Prompt "続行するには Enter キー"
        }
        "2" {
            $url = Read-Host "URLを入力"
            if (-not $url) { Write-Host "URLが指定されていません"; Read-Host -Prompt "続行するには Enter"; continue }
            & $ytCmd.Path -f 'bv*[ext=mp4]+ba[ext=m4a]/b[ext=mp4]' --merge-output-format mp4 $url
            Read-Host -Prompt "続行するには Enter キー"
        }
        "3" {
            $url = Read-Host "URLを入力"
            if (-not $url) { Write-Host "URLが指定されていません"; Read-Host -Prompt "続行するには Enter"; continue }
            & $ytCmd.Path -f 'bv*+ba/b' --merge-output-format mp4 $url
            Read-Host -Prompt "続行するには Enter キー"
        }
        "4" {
            $url = Read-Host "URLを入力"
            if (-not $url) { Write-Host "URLが指定されていません"; Read-Host -Prompt "続行するには Enter"; continue }
            & $ytCmd.Path -f 'bv*+ba/b' $url
            Read-Host -Prompt "続行するには Enter キー"
        }
        "5" {
            $url = Read-Host "URLを入力"
            if (-not $url) { Write-Host "URLが指定されていません"; Read-Host -Prompt "続行するには Enter"; continue }

            Write-Host ""
            Write-Host "音声形式を選択してください"
            Write-Host "1. AAC (.m4a / .aac)"
            Write-Host "2. MP3 (.mp3)"
            Write-Host "3. Opus (.opus)"
            Write-Host "4. FLAC (.flac)"
            Write-Host "5. WAV (.wav)"

            $audioChoice = Read-Host "番号"

            switch ($audioChoice) {
                "1" { $format = "aac" }
                "2" { $format = "mp3" }
                "3" { $format = "opus" }
                "4" { $format = "flac" }
                "5" { $format = "wav" }
                default {
                    Write-Host "無効な番号"
                    Read-Host -Prompt "続行するには Enter"
                    continue
                }
            }

            # flac/wav は可逆/非圧縮なので --audio-quality は不要（ffmpeg の -q:a が無意味）。その他は高品質の VBR 指定（0）を付ける。
            if ($format -in @("flac", "wav")) {
                & $ytCmd.Path -f ba -x --audio-format $format $url
            }
            else {
                & $ytCmd.Path -f ba -x --audio-format $format --audio-quality 0 $url
            }

            Read-Host -Prompt "続行するには Enter キー"
        }
        "6" {
            $url = Read-Host "URLを入力"
            if (-not $url) { Write-Host "URLが指定されていません"; Read-Host -Prompt "続行するには Enter"; continue }
            & $ytCmd.Path -f 'bv*+ba/b' --recode-video mp4 $url
            Read-Host -Prompt "続行するには Enter キー"
        }
        "7" {
            $url = Read-Host "URLを入力"
            if (-not $url) { Write-Host "URLが指定されていません"; Read-Host -Prompt "続行するには Enter"; continue }
            $id = Read-Host "フォーマットIDを入力 (例: 137+140)"
            if (-not $id) { Write-Host "フォーマットIDが指定されていません"; Read-Host -Prompt "続行するには Enter"; continue }
            & $ytCmd.Path -f $id $url
            Read-Host -Prompt "続行するには Enter キー"
        }
        "8" {
            & $ytCmd.Path -U
            Read-Host -Prompt "続行するには Enter キー"
        }
        "9" {
            Write-Host "PowerShellモードです。終了してメニューに戻るには 'exit' と入力してください。"
            powershell
        }
        "0" {
            exit
        }
        default {
            Write-Host "無効な番号です。" -ForegroundColor Yellow
            Start-Sleep -Seconds 1 # 1秒待ってからメニューを再描画
        }
    }
}