#!/usr/bin/env bash
set -euo pipefail
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/common.sh"

if [[ ! -f "$HOME/.oh-my-zsh/oh-my-zsh.sh" ]]; then
  if [[ -e "$HOME/.oh-my-zsh" || -L "$HOME/.oh-my-zsh" ]]; then
    fail 'Existing ~/.oh-my-zsh is incomplete. Resolve it manually before retrying.'
    exit 1
  fi
  require git
  git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh"
fi

plugin_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
if [[ ! -f "$plugin_dir/zsh-autosuggestions.plugin.zsh" ]]; then
  if [[ -e "$plugin_dir" || -L "$plugin_dir" ]]; then
    fail "Existing $plugin_dir is incomplete. Resolve it manually before retrying."
    exit 1
  fi
  require git
  git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git "$plugin_dir"
fi

syntax_plugin_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
if [[ ! -f "$syntax_plugin_dir/zsh-syntax-highlighting.plugin.zsh" ]]; then
  if [[ -e "$syntax_plugin_dir" || -L "$syntax_plugin_dir" ]]; then
    fail "Existing $syntax_plugin_dir is incomplete. Resolve it manually before retrying."
    exit 1
  fi
  require git
  git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git "$syntax_plugin_dir"
fi
