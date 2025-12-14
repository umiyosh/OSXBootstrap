# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## リポジトリ概要

macOS開発環境の初期セットアップを自動化するシェルスクリプト群。新しいMacを手に入れた際に、一連のスクリプトを実行することで開発環境を構築する。

## 前提条件

- Xcode (AppStoreからインストール) + Command Line Tools
- SSHキーの生成とGitHubへの登録

## 実行方法

```bash
sudo xcodebuild -license
git clone https://github.com/umiyosh/OSXBootstrap.git
cd OSXBootstrap/
./bootstrap.sh
```

## アーキテクチャ

### bootstrap.sh（メインエントリーポイント）

1. 関連リポジトリのクローン・更新
   - `~/Brewfile/` - Homebrew設定
   - `~/dotfiles/` - 設定ファイル
   - `~/dotfiles_private/` - プライベート設定
   - `~/.config/karabiner/` - Karabiner設定
   - `~/.config/alacritty/` - Alacritty設定

2. 各言語環境のセットアップ（`bin/`配下のスクリプト）

3. mvimのインストール

### bin/ディレクトリ

| スクリプト | 説明 | バージョン管理ツール |
|-----------|------|---------------------|
| `pySetup.sh` | Python環境 | venv + pipx + rye |
| `goSetup.sh` | Go環境 | gvm |
| `nodeSetup.sh` | Node.js環境 | nodebrew |
| `rbSetup.sh` | Ruby環境 | rbenv |
| `plSetup.sh` | Perl環境 | cpanm |
| `scalaSetup.sh` | Scala環境 | scalaenv |
| `misc.sh` | macOS設定 + mackup restore |

### パッケージリストファイル

各言語のパッケージリストはルートディレクトリに配置:
- `goPackages` - Go tools (gopls, goimports, staticcheck等)
- `nodePackages` - npm packages (prettier, bash-language-server, claude-code等)
- `pythonPackages` - pip packages (httpie, awscli, flake8等)
- `rubyPackages` - gems (bundler, chef等)
- `perlPackages` - CPAN modules
- `pipsiPackages` - pipxでインストールするパッケージ

## 関連リポジトリ

- [umiyosh/Brewfile](https://github.com/umiyosh/Brewfile) - Homebrew設定
- [umiyosh/dotfiles](https://github.com/umiyosh/dotfiles) - 設定ファイル

## 個別スクリプトの実行

特定の言語環境のみセットアップする場合:

```bash
./bin/pySetup.sh   # Python
./bin/goSetup.sh   # Go
./bin/nodeSetup.sh # Node.js
./bin/rbSetup.sh   # Ruby
./bin/plSetup.sh   # Perl
./bin/misc.sh      # macOS設定
```
