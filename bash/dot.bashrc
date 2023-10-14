# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files 
# (in the package bash-doc) for examples


# Pi OS - If not running interactively, don't do anything {{{1
#---------------------------------------------------------
    case $- in
        *i*) ;;
        *) return;;
    esac
# }}}


# Command line history {{{1
#----------------------

    # for setting history length see HISTSIZE 
    # and HISTFILESIZE in bash(1)
    HISTSIZE=1000
    HISTFILESIZE=2000

    # don't put duplicate lines or lines starting 
    # with space in the history.
    # See bash(1) for more options
    HISTCONTROL=ignoreboth

    # append to the history file, don't overwrite it
    shopt -s histappend

# }}}


# Shell Option {{{1
#--------------

    # check the window size after each command and, if necessary,
    # update the values of LINES and COLUMNS.
    shopt -s checkwinsize

    # If set, the pattern "**" used in a pathname expansion context will
    # match all files and zero or more directories and subdirectories.
    shopt -s globstar

    # type dir name and auto cd into it
    shopt -s autocd        

# }}}


# App Behaviour {{{1
#---------------

    # make less more friendly for non-text input files, see lesspipe(1)
    [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# }}}


# Git related {{{1
#-------------

    # git prompt
    if [ -f ~/.sys/git/git-prompt.sh ]; then
        source ~/.sys/git/git-prompt.sh
    fi	

    # git completion
    if [ -f ~/.sys/git/git-completion.bash ]; then
        source ~/.sys/git/git-completion.bash
        export GIT_PS1_SHOWDIRTYSTATE=1
        export GIT_PS1_SHOWUNTRACKEDFILES=1
        export GIT_PS1_SHOWCOLORHINTS=true
    fi

# }}}


# Prompt and Colors Settings {{{1
#----------------------------

    # Colors {{{2
    # -------

        # _reset_color="\e[0m"
        _reset_color="\[\e[00m\]"
        _black="\[\e[00;30m\]"
        _red="\[\e[00;31m\]"
        _green="\[\e[00;32m\]"
        _yellow="\[\e[00;33m\]"
        _blue="\[\e[00;34m\]"
        _magenta="\[\e[00;35m\]"
        _cyan="\[\e[00;36m\]"
        _gray="\[\e[00;37m\]"
        _bright_yellow="\[\e[01;33m\]"
        _low_intensity_gray="\[\e[02;37m\]"
        _reverse_red="\[\e[00;30;41m\]"
        _reverse_green="\[\e[00;30;42m\]"
        _reverse_yellow="\[\e[00;30;43m\]"
        _reverse_blue="\[\e[00;30;44m\]"
        _reverse_magenta="\[\e[00;30;45m\]"
        _reverse_cyan="\[\e[0;30;46m\]"
        _reverse_white="\[\e[0;30;47m\]"

        # colored GCC warnings and errors
        export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'



    # }}}

    # set a fancy prompt (non-color, unless we know we "want" color)
    case "$TERM" in
        xterm-color|*-256color) color_prompt=yes;;
    esac

    # uncomment for a colored prompt, if the terminal 
    # has the capability; turned off by default to not 
    # distract the user: the focus in a terminal window
    # should be on the output of commands, not on the prompt
    force_color_prompt=yes

    if [ -n "$force_color_prompt" ]; then
        if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
            # We have color support; assume it's compliant 
            # with Ecma-48 (ISO/IEC-6429). 
            # (Lack of such support is extremely rare, and such
            # a case would tend to support setf rather than setaf.)
            color_prompt=yes
        else
            color_prompt=
        fi
    fi

    # set variable identifying the chroot you work in
    # (used in the prompt below)
    if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
        debian_chroot=$(cat /etc/debian_chroot)
    fi

    # setup the prompt for both color and non color
    if [ "$color_prompt" = yes ]; then
        _when="$_low_intensity_gray\A"
        _chroot="$_low_intensity_gray${debian_chroot:+($debian_chroot)}"
        _where="$_gray\W"
        _lead="$_cyan\$$_reset_color"
    else
        _when="\A"
        _chroot="${debian_chroot:+($debian_chroot)}"
        _where="\W"
        _lead="\$"
    fi

    # append git branch in prompt
    if [ -f ~/.sys/git/git-completion.bash ]; then
        _git_ps1='$(__git_ps1 "[%s]")'
        # _branch="$_reset_color$_git_ps1"
        _branch="$_yellow$_git_ps1"
    else
        _branch=""
    fi
    
    # Final prompt
    export PS1="$_when $_chroot$_where$_branch $_lead "

    # Unset all variables {{{2
        unset color_prompt force_color_prompt
        unset _reset_color _black _red _green _yellow _blue _magenta
        unset _cyan _gray _bright_yellow _low_intensity_gray
        unset _reverse_red _reverse_green _reverse_yellow
        unset _reverse_magenta _reverse_cyan _reverse_white
    # }}}

# }}}


# Alias {{{1
#-------

    # Alias definitions is centralised and stored in .bash_aliases 

    if [ -f ~/.bash_aliases ]; then
        . ~/.bash_aliases
    fi

# }}}


# Programmable Completion {{{1
#-------------------------

    # enable programmable completion features 
    # (you don't need to enable this, if it's already 
    # enabled in /etc/bash.bashrc and /etc/profile 
    # sources /etc/bash.bashrc).
    if ! shopt -oq posix; then
        if [ -f /usr/share/bash-completion/bash_completion ]; then
            . /usr/share/bash-completion/bash_completion
        elif [ -f /etc/bash_completion ]; then
            . /etc/bash_completion
        fi
        # ignore case on tab auto completion
        bind "set completion-ignore-case on"
    fi

# }}}

# Welcome message
#-----------------
cls
fortune -s | cowsay -f stegosaurus | lolcat --seed 0 --spread 1.0
# fortune -s | cowsay -f $(ls /usr/share/cowsay/cows | shuf -n1) | lolcat --seed 0 --spread 1.0
echo ""
