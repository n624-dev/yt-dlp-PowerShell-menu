# yt-dlp-simple-menu

`yt-dlp` の複雑なコマンドを覚えることなく、番号選択だけで動画や音声をダウンロードできる PowerShell スクリプトです。

## 🚀 特徴
- **直感的なメニュー操作**: 1〜9の番号を選ぶだけで主要な機能にアクセス可能。
- **MP4最適化**: YouTubeやTVerなど、サイトに合わせた最適な形式で保存。
- **音声抽出**: AAC, MP3, Opus, FLAC, WAV への変換に対応。
- **ポータブル**: インストール不要。スクリプトと本体を置くだけで動作します。

## 🛠 事前準備
本スクリプトを使用するには、以下のツールをダウンロードし、スクリプトと同じフォルダに配置してください。
1. **[yt-dlp.exe](https://github.com/yt-dlp/yt-dlp/releases)**
2. **[ffmpeg.exe / ffprobe.exe](https://ffmpeg.org/download.html)** (音声変換や動画結合に必要)

## 📦 使い方
1. 本リポジトリをダウンロードまたはクローンします。
2. スクリプトと同じフォルダに `yt-dlp.exe` などを配置します。
3. `yt-dlp-menu.ps1` を右クリックし、「PowerShell で実行」を選択してください。
   - ※ 実行ポリシーのエラーが出る場合は、PowerShellで `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser` を実行してください。

## ⚠️ 免責事項
- 本ツールは、学習および個人的な視聴を目的とした利用を想定しています。
- 各プラットフォームの利用規約を遵守し、著作権を侵害する行為（違法アップロード動画のダウンロード等）には絶対に使用しないでください。
- 本ツールの利用により生じたいかなる損害についても、作者は一切の責任を負いません。

## 📄 ライセンス
[MIT License](LICENSE)
