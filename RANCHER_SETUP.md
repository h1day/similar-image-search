# Rancher Desktop セットアップガイド

## Rancher Desktop インストール・設定手順

### 1. Rancher Desktop のダウンロード・インストール

1. [Rancher Desktop 公式サイト](https://rancherdesktop.io/) にアクセス
2. Windows版をダウンロード
3. インストーラーを実行してインストール

### 2. Rancher Desktop の初期設定

1. Rancher Desktop を起動
2. **初回起動時の設定:**
   - Container Runtime: **dockerd (moby)** を選択（推奨）
   - Kubernetes: 必要に応じて有効/無効を選択
   - Memory: 4GB以上を推奨
   - CPU: 2コア以上を推奨

3. **詳細設定（オプション）:**
   - `Settings` → `Behavior` → Port Forwarding を確認
   - WSL Integration が有効になっているか確認

### 3. 必要なツールのインストール

```powershell
# Node.js がインストールされていない場合
winget install OpenJS.NodeJS

# Dev Containers CLI のインストール
npm install -g @devcontainers/cli

# VS Code Dev Containers 拡張機能のインストール
# VS Code の拡張機能マーケットプレースから "Dev Containers" を検索してインストール
```

### 4. 動作確認

```powershell
# Docker が利用可能か確認
docker version

# Dev Containers CLI が利用可能か確認
devcontainer --version
```

### 5. プロジェクトの起動

```powershell
# プロジェクトディレクトリに移動
cd C:\work\similar-image-search

# Rancher Desktop 対応スクリプトを実行
.\Script\Claude-Code.ps1
```

## トラブルシューティング

### Docker デーモンに接続できない

```powershell
# Rancher Desktop の状態確認
# Windows タスクマネージャーで Rancher Desktop が起動しているか確認

# Docker デーモンの状態確認
docker info
```

### ポート競合エラー

- Docker Desktop と Rancher Desktop を同時に起動していないか確認
- Rancher Desktop の設定で使用ポートを変更

### パフォーマンス問題

- Rancher Desktop の Memory/CPU 設定を増やす
- WSL2 使用時は `.wslconfig` ファイルを調整:

```ini
# %UserProfile%\.wslconfig
[wsl2]
memory=4GB
processors=2
```

### 権限エラー

- PowerShell を管理者権限で実行
- Docker グループへのユーザー追加を確認

## 参考リンク

- [Rancher Desktop 公式ドキュメント](https://docs.rancherdesktop.io/)
- [Dev Containers 公式ドキュメント](https://containers.dev/)
- [Claude Code 公式リポジトリ](https://github.com/anthropics/claude-code)
