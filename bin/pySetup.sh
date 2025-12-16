#!/usr/bin/env bash
# =============================================================================
# pySetup.sh - Python 環境セットアップスクリプト
# =============================================================================
# 使用方法:
#   PY_SETUP_MODE=legacy ./bin/pySetup.sh  # 既存動作のみ
#   PY_SETUP_MODE=uv ./bin/pySetup.sh      # uv セットアップのみ
#   PY_SETUP_MODE=both ./bin/pySetup.sh    # 両方（デフォルト）
#   ./bin/pySetup.sh                        # both と同じ
# =============================================================================

set -euo pipefail

# -----------------------------------------------------------------------------
# 定数
# -----------------------------------------------------------------------------
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
readonly SCRIPT_DIR
readonly PYVERSION="python3.13"
readonly PYENV="3.13"
readonly UV_TOOLS_FILE="${SCRIPT_DIR}/uvTools"
readonly UV_PYTHONS_FILE="${SCRIPT_DIR}/uvPythons"
readonly PIPSI_PACKAGES_FILE="${SCRIPT_DIR}/pipsiPackages"
readonly PYTHON_PACKAGES_FILE="${SCRIPT_DIR}/pythonPackages"

# デフォルトモード
PY_SETUP_MODE="${PY_SETUP_MODE:-both}"

# -----------------------------------------------------------------------------
# ログ関数
# -----------------------------------------------------------------------------
log_info() {
    echo "[INFO] $*"
}

log_warn() {
    echo "[WARN] $*" >&2
}

log_error() {
    echo "[ERROR] $*" >&2
}

log_section() {
    echo ""
    echo "========================================"
    echo " $*"
    echo "========================================"
}

# -----------------------------------------------------------------------------
# ユーティリティ関数
# -----------------------------------------------------------------------------
read_list_file() {
    local file="$1"
    if [[ ! -f "$file" ]]; then
        log_warn "File not found: $file"
        return 0  # ファイルが無い場合は空として扱う（set -e との相性のため）
    fi
    # コメント除去してから空行除外
    sed 's/#.*//' "$file" | awk '{$1=$1}; NF'
}

check_command() {
    local cmd="$1"
    if ! command -v "$cmd" &>/dev/null; then
        log_error "Command not found: $cmd"
        return 1
    fi
}

# -----------------------------------------------------------------------------
# uv PATH 警告
# -----------------------------------------------------------------------------
check_uv_path() {
    local uv_bin_dir
    uv_bin_dir="$(uv tool dir --bin 2>/dev/null || echo "")"

    if [[ -z "$uv_bin_dir" ]]; then
        log_warn "Could not determine uv tool bin directory"
        return 0
    fi

    if [[ ":$PATH:" != *":$uv_bin_dir:"* ]]; then
        log_warn "uv tool directory is not in PATH: $uv_bin_dir"
        log_warn "Add the following to your shell config:"
        log_warn "  export PATH=\"$uv_bin_dir:\$PATH\""
    else
        log_info "uv tool directory is in PATH: $uv_bin_dir"
    fi
}

# -----------------------------------------------------------------------------
# Legacy セットアップ (既存動作)
# -----------------------------------------------------------------------------
setup_legacy() {
    log_section "Legacy Python Setup"

    # 依存コマンドの存在確認
    if ! check_command "$PYVERSION"; then
        log_error "$PYVERSION is not installed. Install via: brew install python@3.13"
        return 1
    fi
    if ! check_command "pipx"; then
        log_error "pipx is not installed. Install via: brew install pipx"
        return 1
    fi

    local original_dir
    original_dir="$(pwd)"

    # venv 作成
    log_info "Creating venv at ~/python_v${PYENV}"
    cd ~
    $PYVERSION -m venv "python_v${PYENV}"
    cd "$original_dir"

    # PATH 設定
    export PATH=~/.local/bin:$PATH

    # venv アクティベート
    log_info "Activating venv"
    # shellcheck disable=SC1090
    source ~/python_v${PYENV}/bin/activate

    # pipx パッケージインストール
    log_info "Installing pipx packages"
    while IFS= read -r package; do
        [[ -z "$package" ]] && continue
        log_info "  Installing: $package"
        pipx install "$package" || log_warn "Failed to install: $package"
    done < <(read_list_file "$PIPSI_PACKAGES_FILE")

    # pip パッケージインストール
    log_info "Installing pip packages"
    pip install -r "$PYTHON_PACKAGES_FILE"

    # rye インストール
    log_info "Installing rye"
    curl -sSf https://rye-up.com/get | bash

    log_info "Legacy setup completed"
}

# -----------------------------------------------------------------------------
# uv セットアップ (新規)
# -----------------------------------------------------------------------------
setup_uv() {
    log_section "uv Python Setup"

    # uv コマンド確認
    if ! check_command "uv"; then
        log_error "uv is not installed. Install via: brew install uv"
        return 1
    fi

    log_info "uv version: $(uv --version)"

    # Python バージョンインストール
    if [[ -f "$UV_PYTHONS_FILE" ]]; then
        log_info "Installing Python versions via uv"
        while IFS= read -r version; do
            [[ -z "$version" ]] && continue
            log_info "  Installing Python $version"
            uv python install "$version" || log_warn "Failed to install Python $version"
        done < <(read_list_file "$UV_PYTHONS_FILE")
    else
        log_warn "uvPythons file not found, skipping Python installation"
    fi

    # uv tools インストール
    if [[ -f "$UV_TOOLS_FILE" ]]; then
        log_info "Installing tools via uv"
        while IFS= read -r tool; do
            [[ -z "$tool" ]] && continue
            log_info "  Installing tool: $tool"
            uv tool install --upgrade "$tool" || log_warn "Failed to install tool: $tool"
        done < <(read_list_file "$UV_TOOLS_FILE")
    else
        log_warn "uvTools file not found, skipping tool installation"
    fi

    # PATH 警告チェック
    check_uv_path

    log_info "uv setup completed"
}

# -----------------------------------------------------------------------------
# メイン処理
# -----------------------------------------------------------------------------
main() {
    log_info "Python setup mode: $PY_SETUP_MODE"

    case "$PY_SETUP_MODE" in
        legacy)
            setup_legacy
            ;;
        uv)
            setup_uv
            ;;
        both)
            setup_legacy
            setup_uv
            ;;
        *)
            log_error "Unknown mode: $PY_SETUP_MODE"
            log_error "Valid modes: legacy, uv, both"
            exit 1
            ;;
    esac

    log_section "Python Setup Complete"
}

main "$@"
