up() { cd $(eval printf '../'%.0s {1..$1}) && pwd; }

export HISTFILESIZE=20000
export HISTSIZE=10000
shopt -s histappend
# Combine multiline commands into one in history
shopt -s cmdhist
# Ignore duplicates, ls without options and builtin commands
HISTCONTROL=ignoredups
export HISTIGNORE="&:ls:[bf]g:exit"
ghist() { history | grep $1; }

fawk() {
    first="awk '{print "
    last="}'"
    cmd="${first}\$${1}${last}"
    eval $cmd
}

# do sudo, or sudo the last command if no argument given
s() { 
    if [[ $# == 0 ]]; then
    	sudo $(history -p '!!')
    else
    	sudo "$@"
    fi
}

export GREP_OPTIONS='--color=auto'

PS1='\n[\u@\h]: \w\n$?> '
