#!/bin/bash
# execute this script file using Bourne shell

source "$(dirname $0)/../share/colors.sh"    # color settings

source "$(dirname $0)/../share/common.sh"    # shared functions

function Install_lxterminal_config {

    # $1 test mode indicator, empty string means not test mode
    # $2 Install to directory, default is the same dir as script file

    local _test_mode=$1

    local _copy_to="$HOME/.sys/lxterminal"
    if [ "$#" -gt 1 ]; then
        _copy_to=$2    
    fi
    
    local _copy_from="$(dirname $(readlink -f $0))" 

    local _program_name="LXTerminal"
    local _conf_file="lxterminal.conf"

    local _file_location="$HOME/.config/lxterminal"
    local _config="$_file_location/$_conf_file"
    local _backup="$_file_location/$_conf_file.bak"


    # Backup current config + remove the config file / symlink
    if [ -f "$_config" ]; then

        Execute "$Test_Mode" \
                "cp -v -p $_config $_backup" \
                "===> Backup $_program_name Configuration File" 
        
        Execute "$Test_Mode" "rm -v -f $_config" 

    fi

    # Copy config file to the .sys directory and create symlink to it

    Execute "$Test_Mode" \
            "mkdir -v -p $_copy_to" \
            "===> Copying $_program_name Configuration File" 

    Execute "$Test_Mode" \
            "cp -v -p $_copy_from/$_conf_file $_copy_to/$_conf_file" 

    Execute "$Test_Mode" \
            "mkdir -v -p $_file_location" 

    Create_Symlinks "$_test_mode" \
	            "$_copy_to/$_conf_file" \
	            "$_config"

}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then

    # indicate script is being run directly	

    Test_Mode=$(Check_Test_Mode "$@")   # check if TEST mode

    Project_Name="Raspberry PI Configuration Setup"

    Print_Header_Banner $Test_Mode "$Project_Name" 
    
    Install_lxterminal_config "$Test_Mode" "$HOME/.sys/lxterminal"
    
    # Term_Config_File="$HOME/.config/lxterminal/lxterminal.conf"
    # Term_Config_Backup="$HOME/.config/lxterminal/lxterminal.conf.bak"

    # Execute "$Test_Mode" \
    #         "cp -p ${Term_Config_File} ${Term_Config_Backup}" \
    #         "===> Backup Terminal Configuration File" 

    # Execute "$Test_Mode" \
    #         "cp -p lxterminal.conf ${Term_Config_File}" \
    #         "===> Copying Terminal Configuration File" 

    Print_Footer_Banner "$Project_Name" 

fi	

