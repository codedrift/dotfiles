source ~/.zplug/init.zsh

zplug "zsh-users/zsh-completions"
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

zplug "sorin-ionescu/prezto", use:modules/history/init.zsh defer:2
zplug "sorin-ionescu/prezto", use:modules/completion/init.zsh defer:2

zplug 'denysdovhan/spaceship-zsh-theme', as:theme

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load

export JAVA_HOME='/usr/lib/jvm/java-8-oracle'
export IDEA_JDK='/usr/lib/jvm/java-8-oracle'

export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/code

export EDITOR='vim'
export HISTCONTROL=erasedups:ignorespace

alias ls='ls --color=auto'
alias ll='ls -la --color=auto'
alias gac='git add -A && git commit -v'
alias gp='git push'
alias gs='git status'
alias gl='git pull'
alias aptupdate='sudo apt-get update'
alias aptinstall='sudo apt-get install'
alias aptdistupgrade='sudo apt update && sudo apt dist-upgrade && sudo apt autoremove'

#purge all docker images and containers
alias dockercleanall='docker rm $(docker ps -a -q) && docker rmi $(docker images -q)'

#get lunch info for sipgate GmbH. requires jq to parse json
sgfood () {
	curl -s "http://altepost.sipgate.net/api.php" | jq '.meals | .[] | "\(.name) (\(.type))"' | sed 's/"//g'
}

# use alt(arrow) to move through words
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word