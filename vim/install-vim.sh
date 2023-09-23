#!/bin/bash
# execute this script filei using Bourne shell

function Make_Directories {

    # $@ array of directories to be created

    echo -e "$INFO ===> Creating directories... $NORM"

    if [[ "$Test_Mode" ]]; then
        echo -e "$READ Command to execute is: $NORM"
    fi

    local _dir
    local _command="mkdir -p -v"
    for _dir in "$@"; do
        if [[ ! -z "$_dir" ]]; then
             if [[ "$Test_Mode" ]]; then
                 echo -e "$WARN $_command $_dir $NORM"
             else
                 eval "$_command $_dir"
             fi
        fi
    done

    echo -e ""

}

function Remove_Directories {

    # $@ array of directories to be removed (recursive/forced)

    echo -e "$INFO ===> Removing directories... $NORM"

    if [[ "$Test_Mode" ]]; then
        echo -e "$READ Command to execute is: $NORM"
    fi

    local _dir
    local _command="rm -f -r -v"
    for _dir in "$@"; do
        if [[ ! -z "$_dir" ]]; then
             if [[ "$Test_Mode" ]]; then
                 echo -e "$WARN $_command $_dir $NORM"
             else
                 eval "$_command $_dir"
             fi
        fi
   done

    echo -e ""
}

function Execute {

    # print message and execute the command to install
    # only echo the command if in test mode
    # $1 - command to execute
    # $2 - message to be printed as $INFO

    echo -e "$INFO $2 $NORM"
    if [[ "$Test_Mode" ]]; then
        echo -e "$READ Command to execute is: \n$WARN $1 $NORM"
    else
        eval "$1"
    fi
    echo -e ""
}


function Print_Footer_Banner {

    # calculate elapsed time
    # print installation end message banner with elapsed time

    local _duration=$SECONDS
    local _elapsed=""
    if [[ "$_duration" -gt "60" ]]; then
        _elapsed="$(( _duration / 60 )) minutes and "
    fi 
    _elapsed="$_elapsed$(( _duration % 60 )) seconds"

    echo -e ""
    echo -e "$READ ============================================$NORM"
    echo -e "$INFO PI OS Lite Development Mode Setup Completed $NORM"
    echo -e "$INFO Elapsed Time: $_elapsed.                    $NORM"
    echo -e "$READ ============================================$NORM"
    echo -e ""
}

# import all color settings for message printing
source "$(dirname $0)/colors.sh"

# import all common routines and functions
source "$(dirname $0)/common.sh"

# check if in TEST mode or REAL installation
Test_Mode=$(Check_Test_Mode "$@")

# print starting banner and start clocking elapsed time
Print_Header_Banner "$Test_Mode"

# update system
Message="===> Updating system software"
Command="sudo apt update && sudo apt upgrade -y"
Execute "$Command" "$Message"

# need to make sure all standard vim file has been 
# downloaded from git before installing vim
Vim_Dir="$HOME/.vim"
Dirs_To_Make=( \
    "$Vim_Dir" \
    "$Vim_Dir/swap" \
    "$Vim_Dir/view" \
    "$Vim_Dir/undo" \
    "$Vim_Dir/backup" \
    "$Vim_Dir/plugged" \
    "$Vim_Dir/session" \
    "$Vim_Dir/autoload" \
    "$Vim_Dir/etc" \
)

# remove previous installation of vim
Message="===> Remove previous Vim installation"
Command="sudo apt remove vim -y"
Execute "$Command" "$Message"

Remove_Directories "$Vim_Dir"

# install vim
Message="===> Start Vim installation"
Command="sudo apt install vim"
Execute "$Command" "$Message"

Make_Directories "${Dirs_To_Make[@]}"

# prints ending banner with elapsed time
Print_Footer_Banner

