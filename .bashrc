#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

WHICH="/usr/bin/which"

$WHICH clyde > /dev/null 2>&1
if test $? -eq 0; then
clyde() {
	case $1 in 
		-S | -S[^sih]* | -R* | -U*)
		/usr/bin/sudo /usr/bin/clyde "$@" ;;
        	*)
		/usr/bin/clyde "$@" ;;
	esac
}
fi

export EDITOR="vim"
complete -cf sudo
PS1='[\u@\h \W]\$ '
