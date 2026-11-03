export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(
    sudo
    jsontools
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    fzf
    z
)

if [[ -r "$ZSH/oh-my-zsh.sh" ]]; then
  source "$ZSH/oh-my-zsh.sh"
else
  print -u2 'Oh My Zsh is missing. Run install.sh from your dotfiles checkout.'
fi
