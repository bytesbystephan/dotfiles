#!/usr/bin/env bash
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

fail() {
    printf '%s\n' "$*" >&2;
    return 1;
}

require() {
    command -v "$1" >/dev/null 2>&1 || fail "Required command missing: $1";
}

message() {
    local width=40
    local padding=$(( (width - ${#1}) / 2 ))
    printf '\n----------------------------------------\n'
    printf '%*s%s\n' "$padding" '' "$1"
    printf '%s\n\n' '----------------------------------------'
}

load_namespaces() {
    namespaces=()
    local name

    while IFS= read -r name || [[ -n "$name" ]]; do
        [[ -z "$name" || "$name" == \#* ]] && continue
        [[ "$name" =~ ^[a-zA-Z0-9_-]+$ && -d "$DOTFILES_DIR/$name" ]] || {
            fail "Invalid Stow namespace: $name"; return 1;
        }
        namespaces+=("$name")
    done < "$DOTFILES_DIR/packages/stow"

    [[ ${#namespaces[@]} -gt 0 ]] || fail 'No Stow namespaces configured'
}

link_dotfiles() {
    require stow || return 1

    local args=(--dir="$DOTFILES_DIR" --target="$HOME" --no-folding --restow)

    # Custom stow output
    local output status=0
    output=$(stow "${args[@]}" --simulate "${namespaces[@]}" 2>&1) || status=$?
    if [[ -n "$output" ]]; then
        printf '%s\n' "$output" | sed '/^WARNING: in simulation mode so not modifying filesystem\.$/d' >&2
    fi
    if (( status != 0 )); then
        fail 'Link preflight failed. Resolve conflicts manually; existing files were preserved';
        return 1;
    fi

    stow "${args[@]}" "${namespaces[@]}"
}
