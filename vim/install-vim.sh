#!/bin/bash
# execute this script file using Bourne shell

source "$(dirname $0)/../share/colors.sh"    # color settings

source "$(dirname $0)/../share/common.sh"    # shared functions

function Install_Vim {
#{{{1

    # $1 test mode indicator, empty string means not test mode
    # $2 Install to directory, default is the same dir as script file
    #
    # Usage:
    #       Install_Vim $Test_Mode "$HOME/.sys/vim"

    local _test_mode=$1

    local _intall_to="$HOME/.sys/vim"
    if [ "$#" -gt 1 ]; then
        _install_to=$2    
    fi
    
    local _install_from="$(dirname $(readlink -f $0))" 

    local _program_name="vim"
    
    local _dot_vim_dir="$_install_to/.vim"

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

    local _dirs_to_delete=( \
        "$_install_to" \
    )

    local _copy_from=( \
        "$_install_from/.vimrc" \
        "$_install_from/after" \
        "$_install_from/colors" \
        "$_install_from/config" \
        "$_install_from/ftplugin" \
    )

    local _copy_to=( \
        "$_intall_to/.vimrc" \
        "$_dot_vim_dir/after" \
        "$_dot_vim_dir/colors" \
        "$_dot_vim_dir/config" \
        "$_dot_vim_dir/ftplugin" \
    )

    local _symlink_destination=( \
        "$_install_to/.vimrc" \
        "$_install_to/.vim" \
    )

    local _symlink_target=( \
        "$HOME/.vimrc" \
        "$HOME/.vim" \
    )

    Execute $_test_mode \
            "sudo apt remove vim -y" \
            "===> Remove previous $_program_name installation" 

    Remove_Symlinks $_test_mode \
                    "previous $_program_name" \
                    "${_symlink_target[@]}"

    Remove_Directories $_test_mode \
                       "previous $_program_name" \
                       "${_dirs_to_delete[@]}"
    
    Execute $_test_mode \
            "sudo apt install vim" \
            "===> Installing $_program_name" 

    Make_Directories $_test_mode \
                     "$_program_name" \
                     "${_dirs_to_create[@]}"

    Copy_Files $_test_mode \
               $_program_name \
	             "${_copy_from[@]}" \
	             "${_copy_to[@]}"

    Create_Symlinks $_test_mode \
                    $_program_name \
	                  "${_symlink_destination[@]}" \
	                  "${_symlink_target[@]}"

#}}}
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then

    # indicate script is being run directly	

    Test_Mode=$(Check_Test_Mode "$@")   # check if TEST mode

    Project_Name="Raspberry PI Vim Setup"

    Print_Header_Banner $Test_Mode "$Project_Name" 

    Update_System $Test_Mode

    # Install_Vim $Test_Mode "$(dirname $(readlink -f $0))" 
    Install_Vim $Test_Mode "$HOME/.sys/vim"

    Print_Footer_Banner "$Project_Name" 

fi	
