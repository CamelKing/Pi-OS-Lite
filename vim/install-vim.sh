#!/bin/bash
# execute this script file using Bourne shell

source "$(dirname $0)/../share/colors.sh"    # color settings

source "$(dirname $0)/../share/common.sh"    # shared functions

function Create_Symlink {

    # split passed in array into 2 equal size array
    # create symlink using matching elements from the two arrays
    # first array being the destination files/directories being link to
    # second array being path name of the symlinks
    # usage: Create_Symlinks "$_test_mode" "${_destination[@]}" "${_target[@]}"
    # $1 test mode indicator, 't' for test mode
    # $@ after shift 1 = combination of $_destination $_target arrays


    local _test_mode=$1
    shift 1
    local _input=("$@")
    local _len=$(( ${#_input[@]} / 2 ))
    local _destination=("${_input[@]:0:$_len}")
    local _target=("${_input[@]:$_len}")
    local _destine

    for i in "${!_destination[@]}"; do
        _destine=${_destination[$i]}     
        if [ -e ${_destination[$i]} ]; then
            echo -e "ln -sf ${_destination[$i]} ${_target[$i]}"
        else
            echo -e "$WARN Can not create symlink for $_destine $NORM"
        fi
    done

}

function Install_Vim {

    # $1 test mode indicator, empty string means not test mode

    local _test_mode=$1

    local _program_name="vim"
    
    local _install_dir=$2
    
    local _dot_vim_dir="$HOME/.vim"

    local _dirs_to_create=( \
        "$_dot_vim_dir" \
        "$_dot_vim_dir/swap" \
        "$_dot_vim_dir/view" \
        "$_dot_vim_dir/undo" \
        "$_dot_vim_dir/backup" \
        "$_dot_vim_dir/plugged" \
        "$_dot_vim_dir/session" \
        "$_dot_vim_dir/autoload" \
        "$_dot_vim_dir/etc" \
    )

    local _symlink_destination=( \
        "$_install_dir/.vimrc" \
        "$_install_dir/after" \
        "$_install_dir/colors" \
        "$_install_dir/config" \
        "$_install_dir/ftplugin" \
    )

     local _symlink_target=( \
        "$HOME/.vimrc" \
        "$_dot_vim_dir/after" \
        "$_dot_vim_dir/colors" \
        "$_dot_vim_dir/config" \
        "$_dot_vim_dir/ftplugin" \
    )

    Execute "$_test_mode" \
            "sudo apt remove vim -y" \
            "===> Remove previous $_program_name installation" 

    Remove_Directories "$_test_mode" "$_program_name" "$_dot_vim_dir"

    Execute "$_test_mode" \
            "sudo apt install vim" \
            "===> Start $_program_name installation" 

    Make_Directories "$_test_mode" "$_program_name" "${_dirs_to_create[@]}"

    Create_Symlinks "$_test_mode" \
	            "${_symlink_destination[@]}" \
	            "${_symlink_target[@]}"


    # download the plugin manager for vim
    # local _plug_vim_url="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
    # local _plug_vim_dir="$_dot_vim_dir/autoload/plug.vim"
    # cd $HOME > /dev/null
    # eval "curl -fLo $_plug_vim_dir --create-dirs $_plug_vim_url"
    # cd - > /dev/null

}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then

    # indicate script is being run directly	

    Test_Mode=$(Check_Test_Mode "$@")   # check if TEST mode

    Project_Name="PI OS Lite Development Mode Setup"

    Print_Header_Banner $Test_Mode "$Project_Name" 

    Update_System $Test_Mode

    Install_Vim $Test_Mode "$(dirname $(readlink -f $0))" 

    Print_Main_Footer_Banner "$Project_Name" 

fi	
