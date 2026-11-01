#!/usr/bin/env bash
set -euo pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/common.sh"

require apt-get

packages=()

while IFS= read -r package || [[ -n "$package" ]]; do
    [[ -z "$package" || "$package" == \#* ]] && continue
    [[ "$package" =~ ^[a-z0-9][a-z0-9+.-]*$ ]] || { fail "Invalid apt package: $package"; exit 1; }
    packages+=("$package")
done < "$DOTFILES_DIR/packages/apt"

[[ ${#packages[@]} -gt 0 ]] || { fail 'Empty apt package manifest'; exit 1; }

privilege=()

if [[ $EUID -ne 0 ]]; then
    require sudo; privilege=(sudo);
fi

"${privilege[@]}" apt-get update
"${privilege[@]}" apt-get install -y "${packages[@]}"
