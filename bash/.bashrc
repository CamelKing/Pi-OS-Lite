# This is a highly simlified .bashrc, customised to development needs
# Original file has been backuped as .bashrc.bak

    # If not running interactively, don't do anything
    case $- in
        *i*) ;;
          *) return;;
    esac


# Shell system settings
# =====================

    HISTSIZE=1000
    HISTFILESIZE=2000
    HISTCONTROL=ignoreboth # no dups, no space start
    shopt -s histappend    # append, no overwrite
    shopt -s checkwinsize  # check and adjust lines and cols after each command
    shopt -s globstar      # '**' will match all files and dirs
    shopt -s autocd        # type dir name and auto cd into it
    shopt -s cdspell       # auto correct spelling mistake when cd


# Bash utilities 
# ==============

    # bash completion
    if [ -f /usr/share/bash-completion/bash_completion ]; then
      . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
      . /etc/bash_completion
    fi
    bind "set completion-ignore-case on" # ignore case on tab auto completion

    # git completion
    if [ -f ~/src/setup-pi-os-lite/bash/git-prompt.sh ]; then
        source ~/src/setup-pi-os-lite/bash/git-prompt.sh
    fi	
    if [ -f ~/src/setup-pi-os-lite/bash/git-completion.bash ]; then
        source ~/src/setup-pi-os-lite/bash/git-completion.bash
        export GIT_PS1_SHOWDIRTYSTATE=1
	export GIT_PS1_SHOWUNTRACKEDFILES=1
	export GIT_PS1_SHOWCOLORHINTS=true
    fi

# Colors
# ======

    _reset_color="\e[0m"
    _black="\e[0;30m"
    _red="\e[0;31m"
    _green="\e[0;32m"
    _yellow="\e[0;33m"
    _blue="\e[0;34m"
    _magenta="\e[0;35m"
    _cyan="\e[0;36m"
    _gray="\e[0;37m"
    _bright_yellow="\e[1;33m"
    _low_intensity_gray="\e[2;37m"
    _reverse_red="\e[0;30;41m"
    _reverse_green="\e[0;30;42m"
    _reverse_yellow="\e[0;30;43m"
    _reverse_blue="\e[0;30;44m"
    _reverse_magenta="\e[0;30;45m"
    _reverse_cyan="\e[0;30;46m"
    _reverse_white="\e[0;30;47m"

    # simple color prompt: grey path, blue prompt and green command
    # PS1='\w \$ '
    _when="$_low_intensity_gray\A"
    _where="$_low_intensity_gray\W"
    _lead="$_cyan\$$_reset_color"
    if [ -f ~/src/setup-pi-os-lite/bash/git-completion.bash ]; then
        _git_ps1='$(__git_ps1 "[%s]")'
        _branch="$_reset_color$_git_ps1"
    else
        _branch=""
    fi
    # PS1="$_when $_where $_branch $_lead "
    export PS1="$_when $_where $_branch $_lead "

    # colored GCC warnings and errors
    export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'


# Misc.
# =====

    # make less more friendly for non-text input files, see lesspipe(1)
    [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"


# Alias
# =====

    # ls
    alias ls='ls --color=auto --group-directories-first -hF'
    alias ll='ls -ogl'
    alias la='ll -A'
    alias lc='ls -C'

    # grep
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'

    # rc files
    alias reload='source ~/.bashrc'
    alias brc='vim ~/.bashrc'
    alias vrc='vim ~/.vimrc'

    # console
    alias cls='clear'
    alias bye='logout'
    alias down='shutdown'

    # include alias definitions, if any
    if [ -f ~/.bash_aliases ]; then
        . ~/.bash_aliases
    fi


