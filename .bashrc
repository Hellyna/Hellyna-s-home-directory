# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

#set -o vi

# We set the PATH first before doing anything else

#if [ -d ${HOME}/bin ]; then
#    PATH=${PATH}:${HOME}/bin
#fi

if [ -d ${HOME}/.opt/bin ]; then
    PATH=${PATH}:${HOME}/.opt/bin
fi

#if [ -d ${HOME}/.opt/install/bin ]; then 
#    PATH=${PATH}:${HOME}/.opt/install/bin 
#fi

#if test -d ${HOME}/.opt/src/depot_tools; then
#    PATH=${PATH}:${HOME}/.opt/src/depot_tools
#fi
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=50000
HISTFILESIZE=5000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

complete -cf sudo

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
# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

#export PROMPT_COMMAND='PS1="\n\\[\033[4;34m\\]\@\\[\\033[0m\\]   \\[\033[4;34m\\]\! lines\\[\\033[0m\\]   \\[\033[4;34m\\]\j jobs\\[\\033[0m\\]\`if [[ \$? = "0" ]]; then echo "\\[\\033[32m\\]"; else echo "\\[\\033[31m\\]"; fi\`   [\u@\h]   \\[\\033[36m\\]\w\n\\[\033[0;34m\]\$ ==>\\[\\033[0m\\]"'
if [ -f $HOME/.hellyna-git-prompt ]; then
    . $HOME/.hellyna-git-prompt
fi


function __git_prompt {
    local output="$(evil_git_prompt)"
    if test "$output" != ""; then
        git_output="$output   "
    else
        git_output=""
    fi

    local prompt_git_color="\[\033[0;38;5;180m\]"
    if test "$TERM" = "linux"; then
        prompt_git_color="\[\033[0;33m\]"
    fi
    echo "${prompt_git_color}$git_output\[\033[0m\]"
}

function __prompt_time {
    local prompt_time_color="\[\033[1;34m\]"
    if test "$TERM" = "linux"; then
        prompt_time_color="\[\033[1;34m\]"
    fi 
    echo "${prompt_time_color}\@\[\033[0m\]"
}

function __prompt_pwd {
    local prompt_pwd_color="\[\033[0;38;5;116m\]"
    if test "$TERM" = "linux"; then
        prompt_pwd_color="\[\033[1;36m\]"
    fi
    echo "${prompt_pwd_color}\w\[\033[0m\]"
}

function __prompt_arrow {
    local prompt_arrow_color="\[\033[0;38;5;176m\]"
    if test "$TERM" = "linux"; then
        prompt_arrow_color="\[\033[1;37m\]"
    fi
    echo "${prompt_arrow_color}\$ >>\[\033[0m\]"
}

function __prompt_background_jobs {
    local prompt_background_jobs_color="\[\033[1;34m\]"
    if test "$TERM" = "linux"; then
        prompt_background_jobs_color="\[\033[1;33m\]"
    fi
    echo "${prompt_background_jobs_color}\j jobs\[\033[0m\]"
}

function __set_prompt_return_value_color {
    local success_color="\[\033[0;38;5;114m\]"
    local failure_color="\[\033[0;38;5;174m\]"
    if test "$TERM" = "linux"; then
        success_color="\[\033[0;32m\]"
        failure_color="\[\033[0;31m\]"
    fi
    if [ "$1" = "0" ]; then
        echo "${success_color}"
    else
        echo "${failure_color}"
    fi
}

function __prompt_user_host {
    local prompt_user_host_color=""
    echo "${prompt_user_host_color}[\u@\h]\[\033[0m\]"
}

function __prompt_command {
    RET=$?
    RET_COLOR=$(__set_prompt_return_value_color $RET)
    PS1="\n$(__prompt_time)   $(__prompt_background_jobs)   $(__git_prompt)$RET_COLOR$(__prompt_user_host)\n$(__prompt_pwd)\n$(__prompt_arrow)"
}

export PROMPT_COMMAND='__prompt_command'

export PATH

