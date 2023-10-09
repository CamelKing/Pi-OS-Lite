# Bash Shell Options {{{
#-----------------------

	# change to named directory
	shopt -s autocd

	# autocorrects cd misspellings
	shopt -s cdspell 

	# do not overwrite history
	shopt -s histappend

	#ignore upper and lowercase when TAB completion
	bind "set completion-ignore-case on"

# }}}

# System - Shell Prompt Customisation {{{
#----------------------------------------

	# enable ls color by setting CLICOLOR to 1
	export CLICOLOR=1

	# set the color for ls
	# {{{
	# LSCOLORS color code:
	# a = black
	# b = red
	# c = green
	# d = brown
	# e = blue
	# f = magenta
	# g = cyan
	# h = grey
	# A = dark grey
	# B = bold red
	# C = bold green
	# D = yellow
	# E = bold blue
	# F = magenta
	# G = cyan
	# H = white
	# x = default
	#
	# List of the positions in LSCOLORS:
	# 1  directory
	# 2  symbolic link
	# 3  socket
	# 4  pipe
	# 5  executable
	# 6  block device
	# 7  character device
	# 8  executable with setuid set
	# 9  executable with setguid set
	# 10 directory writable by others, with sticky bit
	# 11 directory writable by others, without sticky bit
	# }}}
	# Slightly bright color scheme
	# export LSCOLORS=GxFxCxDxBxegedabagaced
	# Muted color scheme
	export LSCOLORS=gxfxcxdxbxegedabagacad
	# Linux color
	# export LSCOLORS=ExGxBxDxCxEgEdxbxgxcxd

	# Show dirty state in prompt when in Git repos
	export GIT_PS1_SHOWDIRTYSTATE=1
	
	# Set Command Prompt
	# {{{
	# for the git branch prompt to work, must be before 
	# the git completion script below this section
	# ! note
	# 1/	for mac, pls use the escape sequence 
	#					\[\033[<color attr>;<color code>m\]
	#			and	\[\033[m\] to terminate color.
	#			Other escape sequence gives undesirable result
	#	2/ use single quotes especially for the $BRANCH,
	#		 else the prompt would not refresh correctly
	#		 for different git hub repos
	# }}}
	HOST="\[$Low_Intensity_Cyan\]\h"
	TIME="\[$Low_Intensity_Gray\]\t"
	LOCATION="\[$Blue\]\w"
	if [ -f $(brew --prefix)/etc/git-completion.bash ]; then
		GIT_PS1='$(__git_ps1 "[%s]")'
		BRANCH="\[$Reverse_Cyan\]$GIT_PS1\[$Cyan\]"
	else
		BRANCH=""
	fi
	LEAD="#\[$Reset_Color\]"
	PS1="\n$TIME $LOCATION $BRANCH\n$LEAD "
	PS2="  >> "

	# load various scripts for prompt completion
	# ! must be below the ps1 prompt setting above
	if [ -f /usr/local/bin/brew ]; then

		# Load git branch prompt script
		if [ -f $(brew --prefix)/etc/git-prompt.sh ]; then
			source $(brew --prefix)/etc/git-prompt.sh
		fi

		# load git command autocompletion script
		if [ -f $(brew --prefix)/etc/git-completion.bash ]; then
			source $(brew --prefix)/etc/git-completion.bash
		fi

		# load bash completion script
		if [ -f $(brew --prefix)/etc/bash_completion ]; then
			source $(brew --prefix)/etc/bash_completion
		fi

		export LDFLAGS="-L/usr/local/opt/icu4c/lib"
		export CPPFLAGS="-I/usr/local/opt/icu4c/include"

	fi
	

# }}}


