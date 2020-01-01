source ~/.zplug/init.zsh

zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-autosuggestions"

export HISTCONTROL=erasedups:ignorespace

#use exact match for fzf
export FZF_DEFAULT_OPTS="-e"

#fzf - load correct history file -> load fzf bin -> load fzf keybindings
zplug "sorin-ionescu/prezto", use:modules/history/init.zsh
zplug "junegunn/fzf-bin", \
    from:gh-r, \
    as:command, \
    rename-to:fzf, \
    use:"*darwin*amd64*"
zplug "junegunn/fzf", use:"shell/*.zsh"

zplug "plugins/yarn/yarn.plugin.zsh", from:oh-my-zsh
zplug "plugins/docker", from:oh-my-zsh

zplug "~/.zsh", from:local, use:"theme.zsh-theme", as:theme

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load

unset zle_bracketed_paste

export EDITOR='vim'

############# aliases #############
alias ls='ls'
alias ll='ls -lah'

BLUE='\033[0;34m'
NC='\033[0m' # No Color

alias gac='git add -A && git commit -v'
alias gp='git push'
alias gs='git status'
alias gco='git checkout'
alias gl='git pull --rebase'
alias gsl='git stash && git pull --rebase'
alias gcm='git commit -m'
alias glo='git log --stat --graph --oneline | head -n 20'
alias gc='git clone'

alias ..='cd ..'
alias ....='cd ../..'
alias ......='cd ../../..'
alias ........='cd ../../../..'

alias ports='sudo netstat -tulpn'

#purge all docker images and containers
gd () {
    echo "\n${BLUE}########## Cached ##########${NC}"
    git --no-pager diff --cached
    echo "\n${BLUE}########## Unstaged ##########${NC}"
    git --no-pager diff
}

dockercleanall () {
    docker rm $(docker ps -a -q)
    docker rmi $(docker images -q)
    docker system prune
}

take () {
	mkdir -p $1
	cd $1
}

llg () {
	ll | grep -i $1
}

cdl () {
    cd $1 && ls
}

findin () {
    cd $1 && selected_find=$(fzf)
    echo $selected_find | xclip -sel clip
}

if [ -f "$HOME/.zsh_local" ]; then source "$HOME/.zsh_local"; fi
