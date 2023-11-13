alias gen-ssh="ssh-keygen -t ed25519 -C $1"
alias ll="lsd -la"
alias ss="source ~/.zshrc"

if [[ "$__ZSH_THEME_OS" == "Linux" ]]; then
  alias copy-ssh="xclip -selection c < ~/.ssh/$1"
fi
