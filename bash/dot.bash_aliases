
# Remove all previously defined alias {{{1
#-------------------------------------
    unalias -a
#}}}


# Shell command {{{
#--------------------------

    # reload the bash shell rc file
    alias reload='source $HOME/.bashrc'
    # misc unix command shortcut
    alias cls="clear && printf '\e[3J'"

# }}}


# dircolors and LS_COLORS #{{{1
#-------------------------

    # enable color support of ls and also add handy aliases
    if [ -x /usr/bin/dircolors ]; then
        # Output commands to set the LS_COLORS environment variable.
        # use local .dircolors if one exists
        # else use defaults
        test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)"\
            || eval "$(dircolors -b)"
    fi

# }}} 


# ls and dir {{{1
#------------

    # set file related utilities auto colored
    alias ls='ls -hGt --color=auto'
    alias l='ls -1F'
    alias la='ls -AF'
    alias ll='ls -lAF'

    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

# }}}


# grep {{{1
#------------

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'

# }}}


# files system management/navigation {{{1
#------------------------------------

    # mkdir and cd into the new dir
    md () { mkdir -p "$@" && [ $# -ge 1 ] && cd "$1"; }

    # do not delete / or prompt if deleting more than 3 files at a time
    alias rm='rm -irv'

    # confirmation - some need, some removed #
    alias mv='mv -i'
    alias cp='cp -i'

    # updating file time and date
    alias touchpwd='find . -exec touch {} +'
    alias touchall='find . -maxdepth 1 -exec touch {} +'

    # file system manuevering - up 'n' folders
    alias ..='cd ..'
    alias ..2='cd ../..'
    alias ..3='cd ../../..'
    alias ..4='cd ../../../..'
    alias ~='cd ~'

# }}}


# git {{{1
#----------------

	# add all changes to staging
	alias gitadd='git add .'
	# check commit log
	# alias gitlog='git log --oneline --decorate --all' 
	alias gitlog="git log --pretty=tformat:'%C(white)%cs %C(cyan)%s %C(auto)%d %Creset' -10"
	# check staging status
	alias gitstatus='git status --short'
	# commit from staging
	alias gitcommit='git commit -m'
	# push to github
	alias gitpush='git push origin main'

	# git repo listing utilities
	# root dir for current project .git
	alias gitroot='git rev-parse --show-toplevel'
	# list files in current dir tracked by git (excl .gitignore)
	alias gitls='git ls-files -oc --exclude-standard'
	# list repo files tracked by git (excl .gitignore) 
	alias gitll='cd $(gitroot) >/dev/null && gitls && cd - >/dev/null'

# }}}



# Access website {{{1
#----------------

    alias pyref='xdg-open https://docs.python.org/3/reference/index.html'
    alias pylib='xdg-open https://docs.python.org/3/library/index.html'

#}}}
 

