for config in "$HOME"/.config/zsh/*.zsh(N); do
  source "$config"
done
unset config
