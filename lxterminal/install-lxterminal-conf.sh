#!/bin/bash
# execute this script file using Bourne shell

source "$(dirname $0)/../share/colors.sh"    # color settings

source "$(dirname $0)/../share/common.sh"    # shared functions

function Install_Desktop_Config {

    # $1 test mode indicator, empty string means not test mode
    # $2 Install to directory, default is the same dir as script file

    local _test_mode=$1
    local _sys_desktop_dir="$HOME/.sys/desktop"
    [ "$#" -gt 1 ] && _sys_desktop_dir=$2    
    local _install_from="$(dirname $(readlink -f $0))" 
    local _program_name="Pi OS Desktop"

    local _lxterm_conf_file="lxterminal.conf"
    local _lxterm_conf_dir="$HOME/.config/lxterminal"
    local _lxterm_conf="$_lxterm_conf_dir/$_lxterm_conf_file"

    local _menu_conf_file="lxde-pi-applications.menu"
    local _menu_conf_dir="$HOME/.config/menus"
    local _menu_conf="$_menu_conf_dir/$_menu_conf_file"

    local _dirs_to_create=( \
        "$_sys_desktop_dir" \
    )

    local _backup_from=( \
        "$_lxterm_conf" \
        "$_menu_conf" \
    )

    local _backup_to=( \
        "$_lxterm_conf.bak" \
        "$_menu_conf.bak" \
    )

    Make_Directories $_test_mode \
                     "$_program_name" \
                     "${_dirs_to_create[@]}"

    # Backup existing config + remove the config file / symlink

    if [ -f "$_lxterm_conf" ]; then

        # rm command will remove both the file and symlink
        # local _backup_cmd=( \
            # "cp -v -p $_lxterm_conf $_lxterm_conf.bak" \
            # "cp -v -p $_menu_conf $_menu_conf.bak" \
            # "rm -v -f $_lxterm_conf" \
            # "rm -v -f $_menu_conf" \
        # )
#
        # Execute_Commands_List \
            # $_test_mode \
            # "===> Backup $_program_name configuration file" \
            # "${_backup_cmd[@]}"

        Backup_Files $_test_mode \
                     "$_program_name" \
                     "${_backup_from[@]}" \
                     "${_backup_to[@]}"

        Remove_Symlinks $_test_mode \
                        "previous $_program_name" \
                        "${_symlink_target[@]}"

    fi

    # Copy config file to the .sys directory and create symlink to it

    local _copy_cmd=( \
        "mkdir -v -p $_sys_desktop_dir" \
        "cp -v -p $_install_from/$_lxterm_conf_file $_sys_desktop_dir/$_lxterm_conf_file" \
        "cp -v -p $_install_from/$_menu_conf_file $_sys_desktop_dir/$_menu_conf_file" \
    )

    Execute_Commands_List \
        $_test_mode \
        "===> Copy and link $_program_name conf file" \
        "${_copy_cmd[@]}"

    local _symlink_destination=( \
        "$_sys_desktop_dir/$_lxterm_conf_file" \
        "$_sys_desktop_dir/$_menu_conf_file" \
    )

    local _symlink_target=( \
        "$_lxterm_conf" \
        "$_menu_conf" \
    )

    Create_Symlinks $_test_mode \
                    "$_program_name" \
	                  "${_symlink_destination[@]}" \
	                  "${_symlink_target[@]}"

}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then

    # indicate script is being run directly	

    Test_Mode=$(Check_Test_Mode $@)   # check if TEST mode

    Project_Name="Raspberry PI Destop Setup"
    Project_Dir="$HOME/.sys/desktop"

    Print_Header_Banner $Test_Mode "$Project_Name" 
    
    Install_Desktop_Config $Test_Mode "$Project_Dir"
    
    Print_Footer_Banner "$Project_Name" 

fi	

