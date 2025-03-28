alias ls='lsd'
alias ll='lsd -al'

alias vim='nvim'
v() {
  local file
  file=$(eval $FZF_DEFAULT_COMMAND | fzf)
  if [[ -n $file ]]; then
    nvim "$file"
  fi
}

alias conf='cd ~/.config'
alias nconf='cd ~/.config/nvim'

alias src='source ~/.config/zsh/.zshrc'
alias zshrc='vim ~/.config/zsh/.zshrc'
alias aliases='vim ~/.config/zsh/aliases'

alias cheat='nvim $HOME/.config/cheat.md'
