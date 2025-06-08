# Similar Image Search

## 内容

ローカルで実行する類似画像検索ツール

## 開発環境の構築

こちらを参考にさせていただきました。感謝。

[devcontainerでClaude Codeを動かす(Windows)](https://zenn.dev/acntechjp/articles/fc111da7542e00)

### 構成要素

- **DevContainer**: Docker/Podman環境でClaude Codeを実行
- **Firewall**: セキュアな開発環境設定
- **Claude Code**: Anthropic Claude統合開発環境
- **Node.js 20**: ランタイム環境

### インストール

- 上の記事を参照

### Claude Code の起動

プロジェクトのルートで以下を実行します。

```powershell
.\Script\Claude-Code.ps1
```

## 開発環境詳細

### DevContainer設定

- **ベースイメージ**: Node.js 20
- **追加ツール**: Git, zsh, fzf, gh CLI
- **セキュリティ**: iptables/ipsetによるファイアウォール
- **VS Code拡張**: ESLint, Prettier, GitLens

### ファイアウォール設定

開発環境では以下のドメインのみアクセス許可：

- GitHub API/Web/Git
- NPM Registry
- Anthropic API
- 関連サービス (Sentry, Statsig)

### 自動化機能

- Podman machine自動起動
- DevContainer自動ビルド・起動
- Claude Code自動実行
- インタラクティブ開発環境への移行

## 参考

- [devcontainerでClaude Codeを動かす(Windows)](https://zenn.dev/acntechjp/articles/fc111da7542e00)
- [Claude Code と Windows環境でのセットアップ](https://knaka20blue.hatenablog.com/entry/2025/01/23/125300)
- [Rancher Desktop by SUSE](https://rancherdesktop.io/)
- [GitHub MCP Server](https://github.com/github/github-mcp-server)

## ライセンス

このプロジェクトはApache-2.0ライセンスの下で公開されています。