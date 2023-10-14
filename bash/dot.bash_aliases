
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


# Access website {{{1
#----------------

    alias pyref='xdg-open https://docs.python.org/3/reference/index.html'
    alias pylib='xdg-open https://docs.python.org/3/library/index.html'

#}}}
 

