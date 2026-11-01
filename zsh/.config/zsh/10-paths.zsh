typeset -U path PATH
path=(
    "$HOME/.local/bin"
    "$HOME/.bin"
    "$HOME/go/bin"
    $path
)

export PATH
