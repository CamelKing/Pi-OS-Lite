#!/bin/bash
# execute this script file using Bourne shell

source "$(dirname $0)/../share/colors.sh"    # color settings

source "$(dirname $0)/../share/common.sh"    # shared functions

function Install_Python {

    # $1 test mode indicator, empty string means not test mode
    # $2 Install to directory, default is the same dir as script file

    local _test_mode=$1
    local _install_to="$HOME/.sys/python"
    [ "$#" -gt 1 ] && _copy_to=$2    
    local _install_from="$(dirname $(readlink -f $0))" 
    local _program_name="python"

		# sudo apt install pylint - this was done automatically by Pi OS
    sudo apt install pyhon3-full
    sudo apt install flake8 
    sudo apt install python3-autopep8 
    sudo apt install python3-yapf # no bin file, overlapped autopep8
    sudo apt install python3-pytest 
    sudo apt install python3-coverage # no bin file
		sudo apt install numpy # couldnt find in apt and already exist
		sudo apt install python3-pandas 
		sudo apt install python3-matplotlib # already exist
    # jupyterlab
		# sudo apt install pandas-datareader # not found, unless git 
		# pip install beautifulsoup4

#     # Backup existing config + remove the config file / symlink
#
    # if [ -f "$_config" ]; then
#
        # local _backup_cmd=( \
            # "cp -v -p $_config $_config.bak" \
            # "rm -v -f $_config" \
        # )
#
        # Execute_Commands_List \
            # $_test_mode \
            # "===> Backup $_program_name configuration file" \
            # "${_backup_cmd[@]}"
#
    # fi
#
    # # Copy config file to the .sys directory and create symlink to it
#
    # local _copy_cmd=( \
        # "mkdir -v -p $_copy_to" \
        # "cp -v -p $_copy_from/$_conf_file $_copy_to/$_conf_file" \
    # )
#
    # Execute_Commands_List \
        # $_test_mode \
        # "===> Copying $_program_name configuration file" \
        # "${_copy_cmd[@]}"
#
    # Create_Symlinks $_test_mode \
                    # $_conf_file \
										# "$_copy_to/$_conf_file" \
										# $_config
#
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then

    # indicate script is being run directly	

    Test_Mode=$(Check_Test_Mode "$@")   # check if TEST mode

    Project_Name="Raspberry PI Python Setup"

    Print_Header_Banner $Test_Mode "$Project_Name" 
    
    Install_Python $Test_Mode "$HOME/.sys/python"
    
    Print_Footer_Banner "$Project_Name" 

fi	

