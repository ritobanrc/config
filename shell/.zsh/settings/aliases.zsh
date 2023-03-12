#!/usr/bin/zsh

alias q='exit 0'
alias d='clear'

alias ls='exa'
#alias la='ls -Ah'
#alias ll='ls -lAh'

alias mkx='chmod +x'
alias mkdir='mkdir -pv'
alias grep='grep --color=auto'
alias debug="set -o nounset; set -o xtrace"

alias dh='dirs -v'
alias du='du -kh'
alias df='df -kTh'

if hash nvim >/dev/null 2>&1; then
    alias vim='nvim'
    alias v='nvim'
    alias sv='sudo nvim'
else
    alias v='vim'
    alias sv='sudo vim'
fi

alias gp='git pull'
alias gf='git fetch'
alias gc='git clone'
alias gs='git status'
alias gb='git branch'
alias gm='git merge'
alias gch='git checkout'
alias gcm='git commit -m'
alias glg='git log --stat'
alias gpo='git push origin HEAD'
alias gwch='git whatchanged -p --abbrev-commit --pretty=medium'

alias pls='pacman -Ql'        # list files
alias pup='sudo pacman -Syu' # update
alias pin='sudo pacman -S'    # install
alias pun='sudo pacman -Rs'   # remove
alias pcc='sudo pacman -Scc'  # clear cache
alias prm='sudo pacman -Rnsc' # really remove, configs and all

alias please='sudo'

alias cfv='nvim ~/.config/nvim/init.vim'
alias cfa='nvim ~/.config/alacritty/alacritty.yml'
alias cfz='nvim ~/.zshrc'

# aliases inside tmux session
if [[ $TERM == *tmux* ]]; then
    alias :sp='tmux split-window'
    alias :vs='tmux split-window -h'
fi

alias rcp='rsync -v --progress'
alias rmv='rcp --remove-source-files'

alias calc='python -qi -c "from math import *"'
alias brok='sudo find . -type l -! -exec test -e {} \; -print'
alias timer='time read -p "Press enter to stop"'

# shellcheck disable=2142
alias xp='xprop | awk -F\"'" '/CLASS/ {printf \"NAME = %s\nCLASS = %s\n\", \$2, \$4}'"
alias get='curl --continue-at - --location --progress-bar --remote-name --remote-time'

alias ex=""

alias ssh="ssh -Y"

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
