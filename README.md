# OSXBootstrap

# a precondition

* install xcode from AppStore. And Command line tools.
* <code>ssh-keygen -t rsa</code> and add setting to Deploy key

# instruction

~~~
% sudo xcodebuild -license
% git clone https://github.com/umiyosh/OSXBootstrap.git
% cd OSXBootstrap/
% ./bootstrap.sh
~~~

# Python環境セットアップ

## セットアップモード

`bin/pySetup.sh` は環境変数 `PY_SETUP_MODE` で動作を切り替えられます:

| モード | 説明 |
|--------|------|
| `legacy` | 既存動作（venv + pipx + pip + rye） |
| `uv` | uv によるセットアップのみ |
| `both` | 両方実行（デフォルト） |

```bash
# 既存動作のみ
PY_SETUP_MODE=legacy ./bin/pySetup.sh

# uv のみ
PY_SETUP_MODE=uv ./bin/pySetup.sh

# 両方（デフォルト）
./bin/pySetup.sh
```

## uv への段階移行

現在、Python環境管理は venv/pipx/rye から uv への段階移行中です:

1. **Phase 1（現在）**: `both` モードで両方のツールを並行運用
2. **Phase 2（移行期）**: uv の動作を検証し、問題なければ `uv` モードへ移行
3. **Phase 3（完了）**: legacy コードを削除

## パッケージリスト

| ファイル | 説明 |
|----------|------|
| `uvTools` | `uv tool install` でインストールするツール |
| `uvPythons` | `uv python install` でインストールする Python バージョン |
| `pythonPackages` | pip でインストールするパッケージ（legacy 用） |
| `pipsiPackages` | pipx でインストールするパッケージ（legacy 用） |

## PATH 設定

uv ツールを使用するには、PATH に uv のバイナリディレクトリを追加する必要があります。

**推奨（一度だけ実行）:**

```bash
uv tool update-shell
```

これにより、一般的なシェル設定ファイル（.bashrc, .zshrc 等）に自動で PATH が追加されます。

**手動で設定する場合:**

```bash
# バイナリディレクトリを確認
uv tool dir --bin

# shell config に追加（例: ~/.zshrc）
export PATH="$HOME/.local/bin:$PATH"
```

## 動作確認

```bash
# uv モードのみテスト
PY_SETUP_MODE=uv ./bin/pySetup.sh

# 確認
uv tool list
which ruff
which mypy
```

# See also

* [umiyosh/Brewfile](https://github.com/umiyosh/Brewfile)
* [umiyosh/dotfiles](https://github.com/umiyosh/dotfiles)

