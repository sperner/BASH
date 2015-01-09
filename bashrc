# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !

#export LANG="de_DE.iso885915@euro"
export LANG="de_DE.utf-8"

# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi


# Include Aliases
[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases

# Include ColorVars
[[ -f ~/.bash_colors ]] && . ~/.bash_colors

# Include Functions
[[ -f ~/.bash_functions ]] && . ~/.bash_functions

# Include Gentoo specific Stuff
[[ -f ~/.bash_gentoo ]] && . ~/.bash_gentoo

# Include Arch specific Stuff
[[ -f ~/.bash_arch ]] && . ~/.bash_arch

# Include specific Stuff for modern systems
[[ -f ~/.bash_higher ]] && . ~/.bash_higher

export TIMEFORMAT=$'\nreal %3R\tuser %3U\tsys %3S\tpcpu %P\n'
export HISTTIMEFORMAT="%H:%M > "
export HISTIGNORE="&:bg:fg:ll:h"

# Include Login-Script
[[ -f ~/.bash_login ]] && . ~/.bash_login

# Pre-Exec()
if [ $TERM == "xterm" ]
then
	[[ -f ~/.bash_preexec ]] && . ~/.bash_preexec
	#preexec_install
	preexec_xterm_title_install
fi

# Bash-Completion
[[ -f /etc/profile.d/bash-completion.sh ]] && source /etc/profile.d/bash-completion.sh

export PATH=$PATH:/usr/local/sbin:/usr/sbin:/sbin:~/.bin
