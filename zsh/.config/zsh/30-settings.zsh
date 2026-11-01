if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR=vim
else
  export EDITOR=nvim
fi

alias cl=clear
GOPATH="$HOME/go"
