#!/bin/bash
# execute this script file using Bourne shell

source "$(dirname $0)/../share/colors.sh"    # color settings

source "$(dirname $0)/../share/common.sh"    # shared functions

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then

    # indicate script is being run directly	

    Test_Mode=$(Check_Test_Mode "$@")   # check if TEST mode

    Print_Header_Banner "$Test_Mode"

    Term_Config_File="$HOME/.config/lxterminal/lxterminal.conf"
    Term_Config_Backup="$HOME/.config/lxterminal/lxterminal.conf.bak"

    Execute "$Test_Mode" \
            "cp -p ${Term_Config_File} ${Term_Config_Backup}" \
            "===> Backup Terminal Configuration File" 

    Execute "$Test_Mode" \
            "cp -p lxterminal.conf ${Term_Config_File}" \
            "===> Copying Terminal Configuration File" 

    Print_Footer_Banner

fi	

