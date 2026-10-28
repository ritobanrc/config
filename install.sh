#!/usr/bin/env bash
# Install dependencies and stow the editor, terminal and shell configs.
#
# Usage: ./install.sh [--skip-packages] [stow-package...]
#   --skip-packages   don't install system packages with pacman (no sudo needed)
#   stow-package      which packages to stow (default: editor terminal shell)
#
# Safe to re-run: existing files that would conflict with stow are moved to
# <file>.bak.<timestamp>, and steps that are already done are skipped.
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

PACMAN_PACKAGES=(
    # core (npm pulls in a nodejs; don't name nodejs, it conflicts with nodejs-lts-*)
    git stow make gcc unzip curl wget tar gzip python npm rustup
    # editor
    neovim vim ripgrep fd tree-sitter-cli zathura zathura-pdf-mupdf tesseract-data-eng
    # books and papers (zotero-bin comes from the AUR)
    zathura-djvu calibre
    # terminal
    alacritty ttf-hack-nerd
    # shell
    zsh tmux zoxide fzf eza lf
)

# Mirrors ensure_installed in editor/.config/nvim/lua/plugins/lsp.lua
# (mason package name : binary it provides)
MASON_PACKAGES=(
    lua-language-server:lua-language-server
    rust-analyzer:rust-analyzer
    clangd:clangd
    python-lsp-server:pylsp
    tinymist:tinymist
    texlab:texlab
)

skip_packages=0
stow_packages=()
for arg in "$@"; do
    case "$arg" in
        --skip-packages) skip_packages=1 ;;
        -h|--help) sed -n '2,9p' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
        *) stow_packages+=("$arg") ;;
    esac
done
(( ${#stow_packages[@]} )) || stow_packages=(editor terminal shell)

step() { printf '\n\033[1;34m==> %s\033[0m\n' "$*"; }
has() { command -v "$1" >/dev/null 2>&1; }
wants() { [[ " ${stow_packages[*]} " == *" $1 "* ]]; }

if (( ! skip_packages )); then
    step "Installing system packages"
    if has pacman; then
        sudo pacman -S --needed "${PACMAN_PACKAGES[@]}"
    else
        echo "pacman not found; install these manually: ${PACMAN_PACKAGES[*]}" >&2
    fi
fi

step "Updating git submodules"
git -C "$REPO" submodule update --init --recursive

if has rustup; then
    step "Setting up the Rust toolchain"
    rustup default >/dev/null 2>&1 || rustup default stable
    rustup component add rust-src rust-analyzer
fi

if wants shell && [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    step "Installing oh-my-zsh"
    # Clone rather than running the upstream installer, which overwrites ~/.zshrc
    git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh"
fi

step "Stowing: ${stow_packages[*]}"
for pkg in "${stow_packages[@]}"; do
    [[ -d "$REPO/$pkg" ]] || { echo "No such package: $pkg" >&2; exit 1; }
    # Move aside anything stow would refuse to overwrite
    while IFS= read -r -d '' src; do
        rel="${src#"$REPO/$pkg/"}"
        target="$HOME/$rel"
        if [[ -e "$target" || -L "$target" ]] && [[ "$(readlink -f "$target")" != "$src" ]]; then
            backup="$target.bak.$(date +%s)"
            echo "Backing up $target -> $backup"
            mv "$target" "$backup"
        fi
    done < <(find "$REPO/$pkg" -name .git -prune -o \( -type f -o -type l \) -print0)
    stow -d "$REPO" -t "$HOME" -R "$pkg"
done

if wants zotero; then
    # The profile directory has a random name, so link user.js in by hand
    for profile in "$HOME"/.zotero/zotero/*.default*/; do
        [[ -d "$profile" ]] || { echo "Run Zotero once, then re-run this step" >&2; break; }
        ln -sfn "$HOME/.config/zotero/user.js" "$profile/user.js"
    done
fi

if wants editor && has nvim; then
    step "Installing neovim plugins"
    nvim --headless "+Lazy! restore" +qa

    missing=()
    for entry in "${MASON_PACKAGES[@]}"; do
        [[ -x "$HOME/.local/share/nvim/mason/bin/${entry#*:}" ]] || missing+=("${entry%%:*}")
    done
    if (( ${#missing[@]} )); then
        step "Installing language servers: ${missing[*]}"
        nvim --headless "+MasonInstall ${missing[*]}" +qa
    fi
fi

if wants shell && has zsh && [[ "$(getent passwd "$USER" | cut -d: -f7)" != */zsh ]]; then
    step "Changing login shell to zsh"
    chsh -s "$(command -v zsh)"
fi

step "Done"
