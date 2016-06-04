up() { cd $(eval printf '../'%.0s {1..$1}) && pwd; }

export HISTFILESIZE=20000
export HISTSIZE=10000
shopt -s histappend
# Combine multiline commands into one in history
shopt -s cmdhist
# Ignore duplicates, ls without options and builtin commands
HISTCONTROL=ignoredups
export HISTIGNORE="&:ls:[bf]g:exit:clear:exit"
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

#netinfo - shows network information for your system
netinfo ()
{
echo "--------------- Network Information ---------------"
/sbin/ifconfig | awk /'inet addr/ {print $2}'
/sbin/ifconfig | awk /'Bcast/ {print $3}'
/sbin/ifconfig | awk /'inet addr/ {print $4}'
/sbin/ifconfig | awk /'HWaddr/ {print $4,$5}'
myip=`lynx -dump -hiddenlinks=ignore -nolist http://checkip.dyndns.org:8245/ | sed '/^$/d; s/^[ ]*//g; s/[ ]*$//g' `
echo "${myip}"
echo "---------------------------------------------------"
}

extract () {
   if [ -f $1 ] ; then
     case $1 in
       *.tar.bz2)   tar xjf $1    ;;
       *.tar.gz)    tar xzf $1    ;;
       *.bz2)       bunzip2 $1    ;;
       *.rar)       rar x $1      ;;
       *.gz)        gunzip $1     ;;
       *.tar)       tar xf $1     ;;
       *.tbz2)      tar xjf $1    ;;
       *.tgz)       tar xzf $1    ;;
       *.zip)       unzip $1      ;;
       *.Z)         uncompress $1 ;;
       *.7z)        7z x $1       ;;
       *)           echo "'$1' cannot be extracted via extract()" ;;
     esac
   else
     echo "'$1' is not a valid file"
   fi
}

#dirsize - finds directory sizes and lists them for the current directory
dirsize ()
{
du -shx * .[a-zA-Z0-9_]* 2> /dev/null | \
egrep '^ *[0-9.]*[MG]' | sort -n > /tmp/list
egrep '^ *[0-9.]*M' /tmp/list
egrep '^ *[0-9.]*G' /tmp/list
rm -rf /tmp/list
}

# Finds 10 largest files in $1
big10() { du -a $1 | sort -n -r | head -n 10 }

