#!/bin/bash
# execute this script file using Bourne shell

source "$(dirname $0)/../share/colors.sh"    # color settings

source "$(dirname $0)/../share/common.sh"    # shared functions

function Install_Bash {

    # $1 test mode indicator, empty string means not test mode
    # $2 Installation directory, default is the same dir as script file

    local _test_mode=$1

    local _install_dir="$HOME/.sys/bash"
    [ "$#" -gt 1 ] && _install_dir=$2 

    local _program_name="Bash"
    

}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then

    # indicate script is being run directly	

    Test_Mode=$(Check_Test_Mode "$@")   # check if TEST mode

    Project_Name="Raspberry PI Bash Shell Setup"

    Print_Header_Banner $Test_Mode "$Project_Name" 

    Update_System $Test_Mode

    Install_Bash $Test_Mode "$HOME/.sys/bash" 

    Print_Main_Footer_Banner "$Project_Name" 

fi
