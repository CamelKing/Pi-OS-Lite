#!/bin/bash
# execute this script file using Bourne shell

source "$(dirname $0)/../share/colors.sh"    # color settings

source "$(dirname $0)/../share/common.sh"    # shared functions

function Install_Bash {

    # $1 test mode indicator, empty string means not test mode
    # $2 Installation directory, default is the same dir as script file

    local _test_mode=$1

    local _install_to="$HOME/.sys/bash"
    [ "$#" -gt 1 ] && _install_to=$2 

    local _install_from="$(dirname $(readlink -f $0))" 

    local _program_name="Bash"

    local _dirs_to_create=( \
        "$_install_to" \
    )

    local _dirs_to_delete=( \
        "$_install_to" \
    )

    local _copy_from=( \
        "$_install_from/dot.bashrc" \
        "$_install_from/dot.bash_aliases" \
    )

    local _copy_to=( \
        "$_install_to/.bashrc" \
        "$_install_to/.bash_aliases" \
    )

    local _symlink_destination=( \
        "$_install_to/.bashrc" \
        "$_install_to/.bash_aliases" \
    )

    local _symlink_target=( \
        "$HOME/.bashrc" \
        "$HOME/.bash_aliases" \
    )

    Remove_Symlinks $_test_mode \
                    "previous $_program_name symlinks" \
                    "${_symlink_target[@]}"
  
    Remove_Directories $_test_mode \
                       "previous $_program_name files" \
                       "${_dirs_to_delete[@]}"

    Make_Directories $_test_mode \
                     "$_program_name files" \
                     "${_dirs_to_create[@]}"

    Copy_Files $_test_mode \
               "$_program_name files" \
	             "${_copy_from[@]}" \
	             "${_copy_to[@]}"

    Create_Symlinks $_test_mode \
                    "$_program_name symlinks" \
	                  "${_symlink_destination[@]}" \
	                  "${_symlink_target[@]}"


    local _apt_install_cmd=( \
        "sudo apt install fortune cowsay lolcat -y" \
    )

    Execute_Commands_List \
        $_test_mode \
        "===> Install misc. shell utilities" \
        "${_apt_install_cmd[@]}"

}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then

    # indicate script is being run directly	

    Test_Mode=$(Check_Test_Mode "$@")   # check if TEST mode

    Project_Name="Raspberry PI Bash Shell Setup"

    Print_Header_Banner $Test_Mode "$Project_Name" 

    # Update_System $Test_Mode

    Install_Bash $Test_Mode "$HOME/.sys/bash" 

    Print_Footer_Banner "$Project_Name" 

fi
