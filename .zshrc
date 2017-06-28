############# zplug config #############
# run
# curl -sL zplug.sh/installer | zsh
# to install zplug itself

source ~/.zplug/init.zsh

zplug "zsh-users/zsh-completions"
#zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-history-substring-search", defer:3

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

zplug 'themes/jreese', from:oh-my-zsh, as:theme

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load

############# exports #############
export JAVA_HOME='/usr/lib/jvm/java-8-oracle'
export IDEA_JDK='/usr/lib/jvm/java-8-oracle'

export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/code/go
export PATH=$PATH:$GOPATH

SCALA_HOME=$HOME/scala
export PATH=$PATH:$SCALA_HOME/bin

export PATH=$PATH:$HOME/.config/yarn/global/node_modules/.bin
export PATH=$PATH:$HOME/scripts/bin
export PATH=$PATH:$HOME/.cargo/bin

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
alias gd='echo "\n${BLUE}########## Cached ##########${NC}" && git diff --cached && echo "\n${BLUE}########## Unstaged ##########${NC}" && git diff'
alias gp='git push'
alias gs='git status'
alias gco='git checkout'
alias gl='git pull'
alias glo='git log --graph --oneline'

alias aptupdate='sudo apt-get update'
alias aptinstall='sudo apt-get install'
alias aptdistupgrade='sudo apt update && sudo apt dist-upgrade -y && sudo apt autoremove -y'

#purge all docker images and containers
alias dockercleanall='docker rm $(docker ps -a -q) && docker rmi $(docker images -q)'

take () {
	mkdir -p $1
	cd $1
}

cdl () {
    cd $1 && ls
}

# use alt(arrow) to move through words
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word


starttmux() {
    if [ -z "$HOSTS" ]; then
       echo -n "Please provide of list of hosts separated by spaces [ENTER]: "
       read HOSTS
    fi

    local hosts=( $HOSTS )


    tmux new-window "ssh ${hosts[0]}"
    unset hosts[0];
    for i in "${hosts[@]}"; do
        tmux split-window -h  "ssh $i"
        tmux select-layout tiled > /dev/null
    done
    tmux select-pane -t 0
    tmux set-window-option synchronize-panes on > /dev/null

}
