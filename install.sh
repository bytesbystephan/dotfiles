#!/usr/bin/env bash
set -euo pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/scripts/common.sh"

load_namespaces

message "Installing dependencies"

case "$(uname -s)" in
    Darwin) source "$DOTFILES_DIR/scripts/macos.sh" ;;

    Linux) bash "$DOTFILES_DIR/scripts/linux.sh" ;;

  *) fail 'Unsupported operating system'; exit 1 ;;
esac


message "Installing Oh-My-Zsh"

bash "$DOTFILES_DIR/scripts/oh-my-zsh.sh"

link_dotfiles

message 'Setup complete'
