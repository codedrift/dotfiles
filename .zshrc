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

zplug 'denysdovhan/spaceship-zsh-theme', as:theme

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

export EDITOR='vim'

export HISTCONTROL=erasedups:ignorespace

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
alias aptdistupgrade='sudo apt update && sudo apt dist-upgrade && sudo apt autoremove'

#purge all docker images and containers
alias dockercleanall='docker rm $(docker ps -a -q) && docker rmi $(docker images -q)'

#get lunch info for sipgate GmbH. requires jq to parse json
sgfood () {
	curl -s "http://altepost.sipgate.net/api.php" | jq '.meals | .[] | "\(.name) (\(.type))"' | sed 's/"//g'
}

take () {
	mkdir -p $1
	cd $1
}

deletebranch ()  {
    git branch -d $1
    git push origin :$1
}

# Usage: scratch <name>
scratch () {
    SCRATCHFOLDER=$HOME/git/notes/scratch
    SCRATCHTIME=`date +%Y-%m-%d.%H:%M:%S`
    SCRATCHFILE="scratch_${SCRATCHTIME}_$1.txt"
    echo "Opening new scratch file $SCRATCHFOLDER/$SCRATCHFILE"
    touch $SCRATCHFOLDER/$SCRATCHFILE
    code $SCRATCHFOLDER/$SCRATCHFILE
}

# use alt(arrow) to move through words
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word