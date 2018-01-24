############# zplug config #############
# run
# curl -sL zplug.sh/installer | zsh
# to install zplug itself

source ~/.zplug/init.zsh

zplug "zsh-users/zsh-completions"
#zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-autosuggestions"
zplug "plugins/pass/", from:oh-my-zsh

#fzf - load correct history file -> load fzf bin -> load fzf keybindings
zplug "sorin-ionescu/prezto", use:modules/history/init.zsh
zplug "junegunn/fzf-bin", \
    from:gh-r, \
    as:command, \
    rename-to:fzf, \
    use:"*linux*amd64*"
zplug "junegunn/fzf", use:"shell/*.zsh"

zplug "sorin-ionescu/prezto", use:modules/history/init.zsh
zplug "sorin-ionescu/prezto", use:modules/completion/init.zsh

zplug "plugins/kubectl", from:oh-my-zsh

zplug "plugins/yarn/yarn.plugin.zsh", from:oh-my-zsh

zplug "~/.zsh", from:local, use:"theme.zsh-theme", as:theme

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load

############# exports #############
export JAVA_HOME='/usr/lib/jvm/default-java'
export IDEA_JDK='/usr/lib/jvm/default-java'

export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/code/go
export PATH=$PATH:$GOPATH

SCALA_HOME=$HOME/scala
export PATH=$PATH:$SCALA_HOME/bin

export PATH=$PATH:$HOME/.config/yarn/global/node_modules/.bin
export PATH=$PATH:$HOME/scripts/bin
export PATH=$PATH:$HOME/.cargo/bin
export PATH=$PATH:/opt/node/bin

export EDITOR='vim'

export HISTCONTROL=erasedups:ignorespace

#use exact match for fzf
export FZF_DEFAULT_OPTS="-e"

############# aliases #############
alias ls='ls --color=auto'
alias ll='ls -la --color=auto'

BLUE='\033[0;34m'
NC='\033[0m' # No Color

alias gac='git add -A && git commit -v'
alias gd='echo "\n${BLUE}########## Cached ##########${NC}" && git --no-pager diff --cached && echo "\n${BLUE}########## Unstaged ##########${NC}" && git --no-pager diff'
alias gp='git push'
alias gs='git status'
alias gco='git checkout'
alias gl='git pull'
alias glo='git log --stat --graph --oneline | head -n 20'
alias gc='git clone'

alias aptupdate='sudo apt-get update'
alias aptinstall='sudo apt-get install'
alias aptdistupgrade='sudo apt-get update && sudo apt-get dist-upgrade -y && sudo apt-get autoremove -y'

alias ports='sudo netstat -tulpn'

#purge all docker images and containers
alias dockercleanall='docker rm $(docker ps -a -q) && docker rmi $(docker images -q)'

take () {
	mkdir -p $1
	cd $1
}

cdl () {
    cd $1 && ls
}

findin () {
    cd $1 && selected_find=$(fzf)
    echo $selected_find | xclip -sel clip
}

api_token () {
    API_TOKEN=$(curl -s --request POST \
--header 'Content-Type: application/x-www-form-urlencoded' \
--header 'Accept: application/json' \
--data-urlencode "username=$1" \
--data-urlencode "password=$2" \
--data-urlencode "client_id=sipgate-app-web" \
--data-urlencode "grant_type=password" \
https://api.sipgate.com/login/sipgate-apps/protocol/openid-connect/token | jq -r '.access_token')
    echo 'Stored token in $API_TOKEN'
}

api_token_dev () {
    API_TOKEN_DEV=$(curl -s --request POST \
--header 'Content-Type: application/x-www-form-urlencoded' \
--header 'Accept: application/json' \
--data-urlencode "username=$1" \
--data-urlencode "password=$2" \
--data-urlencode "client_id=sipgate-app-web" \
--data-urlencode "grant_type=password" \
https://api.dev.sipgate.com/login/sipgate-apps/protocol/openid-connect/token | jq -r '.access_token')
    echo 'Stored token in $API_TOKEN_DEV'
}

if [ -f "$HOME/.zsh_local" ]; then source "$HOME/.zsh_local"; fi


# use alt(arrow) to move through words
bindkey "\e[1;5C" forward-word
bindkey "\e[1;5D" backward-word
