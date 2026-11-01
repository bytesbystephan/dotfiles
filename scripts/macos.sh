#!/usr/bin/env bash

[[ -s "$DOTFILES_DIR/packages/Brewfile" ]] || { fail 'Missing or empty Brewfile'; exit 1; }

if ! command -v brew >/dev/null 2>&1; then
    for brew_path in /opt/homebrew/bin/brew /usr/local/bin/brew; do
        if [[ -x "$brew_path" ]]; then eval "$("$brew_path" shellenv)"; break; fi
    done
fi

if ! command -v brew >/dev/null 2>&1; then
    require curl

    installer=$(mktemp)

    if ! curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh -o "$installer"; then
        rm -f "$installer"; exit 1
    fi

    /bin/bash "$installer" || { rm -f "$installer"; exit 1; }
    rm -f "$installer"

    case "$(uname -m)" in
        arm64) eval "$(/opt/homebrew/bin/brew shellenv)" ;;
        *) eval "$(/usr/local/bin/brew shellenv)" ;;
    esac
fi

brew bundle --file="$DOTFILES_DIR/packages/Brewfile"
