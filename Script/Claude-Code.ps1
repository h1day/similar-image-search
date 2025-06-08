# スクリプトの開始を通知
Write-Host "--- DevContainer 起動・接続スクリプト (Rancher Desktop版) ---"

# --- Step 1: Rancher Desktop の起動確認 ---
Write-Host "Rancher Desktop / Docker の起動状況を確認しています..."
try {
    # docker version コマンドでDockerデーモンが起動しているか確認
    $dockerVersion = docker version --format "{{.Server.Version}}" 2>$null
    if ($dockerVersion) {
        Write-Host "Docker デーモンが起動しています (バージョン: $dockerVersion)"
    } else {
        throw "Docker デーモンに接続できません"
    }
} catch {
    Write-Error "Docker デーモンが起動していないか、アクセスできません: $($_.Exception.Message)"
    Write-Host "Rancher Desktop を起動してから再度実行してください。"
    exit 1 # エラーが発生したらスクリプトを終了
}

# --- Step 2: DevContainer の起動 ---
Write-Host "現在のフォルダで DevContainer を起動しています..."
try {
    # devcontainer up はコンテナをビルド/起動し、必要なツールをインストールします
    # Rancher Desktop では docker がデフォルトなので --docker-path は不要
    devcontainer up --workspace-folder .
    Write-Host "DevContainer の起動処理が完了しました。"
} catch {
    Write-Error "DevContainer の起動に失敗しました: $($_.Exception.Message)"
    exit 1 # エラーが発生したらスクリプトを終了
}

# --- Step 3: DevContainer のコンテナIDを取得 ---
Write-Host "DevContainer のコンテナIDを検索しています..."
$currentFolder = (Get-Location).Path
# devcontainer up が設定するラベルを使ってコンテナを特定
# `docker ps` の出力から ID だけを抽出
# .Trim() で取得した文字列の不要な空白を削除
$containerId = $(docker ps --filter "label=devcontainer.local_folder=$currentFolder" --format "{{.ID}}").Trim()

if (-not $containerId) {
    Write-Error "現在のフォルダ ('$currentFolder') に対応する DevContainer のコンテナIDが見つかりませんでした。"
    Write-Error "'devcontainer up' が正常に完了し、コンテナが起動しているか確認してください。"
    
    # デバッグ情報として実行中のコンテナ一覧を表示
    Write-Host "現在実行中のコンテナ一覧:"
    docker ps --format "table {{.ID}}\t{{.Image}}\t{{.Labels}}"
    
    exit 1 # コンテナが見つからない場合はスクリプトを終了
}
Write-Host "コンテナIDが見つかりました: $containerId"

# --- Step 4: コンテナ内でコマンドを実行し、インタラクティブシェルに入る ---
Write-Host "コンテナ ($containerId) 内で 'claude' コマンドを実行し、その後 zsh セッションを開始します..."
try {
    # docker exec -it はインタラクティブなセッションを開始します
    # zsh -c 'claude; exec zsh' の意味:
    #   zsh を非対話モードで起動し、以下のコマンドを実行
    #   'claude;' -> claude コマンドを実行
    #   'exec zsh' -> 現在のプロセス (非対話 zsh) を対話式 zsh に置き換える
    # これにより、claude コマンドが実行された後、自動的にインタラクティブな zsh プロンプトが表示されます。
    docker exec -it $containerId zsh -c 'claude; exec zsh'

    # このコマンドが実行されると、現在のPowerShellセッションはコンテナ内の zsh が終了するまで待機します。
    Write-Host "インタラクティブセッションが終了しました。"

} catch {
    Write-Error "コンテナ内でのコマンド実行に失敗しました: $($_.Exception.Message)"
    exit 1 # エラーが発生したらスクリプトを終了
}

# スクリプトの終了を通知
Write-Host "--- スクリプト完了 ---"
