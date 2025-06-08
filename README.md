# Similar Image Search

## 内容

ローカルで実行する類似画像検索ツール

## 開発環境の構築

### 前提条件

1. **Rancher Desktop のインストール**
   - [Rancher Desktop](https://rancherdesktop.io/) からダウンロードしてインストール
   - インストール後、Rancher Desktop を起動
   - Container Runtime として **dockerd (moby)** を選択することを推奨

2. **VS Code Dev Containers 拡張機能**
   - VS Code に [Dev Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) 拡張機能をインストール

3. **Dev Containers CLI**
   ```bash
   npm install -g @devcontainers/cli
   ```

### Claude Code の起動

プロジェクトのルートで以下を実行します：

```pwsh
.\Script\Claude-Code.ps1
```

## トラブルシューティング

### よくある問題

1. **コンテナが見つからない場合**
   - Rancher Desktop が完全に起動しているか確認
   - Container Runtime が dockerd (moby) に設定されているか確認

2. **ポート競合エラー**
   - Rancher Desktop の設定で使用ポートを確認
   - 他のDocker環境（Docker Desktop等）が同時に起動していないか確認

3. **パフォーマンス問題**
   - Rancher Desktop の設定でCPU・メモリ割り当てを調整
   - WSL2 の場合は `.wslconfig` で制限を設定

詳細なセットアップ手順については、`RANCHER_SETUP.md` を参照してください。

## 参考

- [Rancher Desktop by SUSE](https://rancherdesktop.io/)
- [devcontainerでClaude Codeを動かす(Windows)](https://zenn.dev/acntechjp/articles/fc111da7542e00)
- https://knaka20blue.hatenablog.com/entry/2025/01/23/125300
- [GitHub MCP Server](https://github.com/github/github-mcp-server)
- [Dev Containers 公式ドキュメント](https://code.visualstudio.com/docs/devcontainers/containers)
