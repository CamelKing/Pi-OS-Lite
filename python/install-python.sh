#!/bin/bash
# execute this script file using Bourne shell

source "$(dirname $0)/../share/colors.sh"    # color settings

source "$(dirname $0)/../share/common.sh"    # shared functions

function Install_Python {

    # $1 test mode indicator, empty string means not test mode
    # $2 python venv directory, default is $HOME/.sys/python
    # $3 dev directory, where some python setting files will be stored
    #                   default is $HOME/dev

    local _test_mode=$1
    local _venv_dir="$HOME/.sys/python"
    [ "$#" -gt 1 ] && _venv_dir=$2    
    local _dev_dir="$HOME/dev"
    [ "$#" -gt 2 ] && _dev_dir=$3    
    local _install_from="$(dirname $(readlink -f $0))" 
    local _program_name="python"
    local _pylintrc=".pylintrc"

    local _dirs_to_handle=( \
        "$_venv_dir" \
        "$_dev_dir" \
    )

    local _symlink_destination=( \
        "$_venv_dir/$_pylintrc" \
    )

    local _symlink_target=( \
        "$_dev_dir/$_pylintrc" \
    )

    local _copy_from=( \
        "$_install_from/$_pylintrc" \
    )

    local _copy_to=( \
        "$_venv_dir/$_pylintrc" \
    )

		# remove previous python venv
    Remove_Symlinks $_test_mode \
                    "previous $_program_name venv" \
                    "${_symlink_target[@]}"

    Remove_Directories $_test_mode \
                       "previous $_program_name venv" \
                       "${_dirs_to_handle[@]}"

		# setup python venv

    local _venv_setup_cmd=( \
            "sudo apt install python3-full" \
            "python -m venv  ~/.sys/python" \
    )

    Make_Directories $_test_mode \
                     "new $_program_name venv" \
                     "${_dirs_to_handle[@]}"

    Execute_Commands_List \
        $_test_mode \
        "===> Setup new $_program_name venv" \
        "${_venv_setup_cmd[@]}"

    # installing python packages in VENV with pip
    # must activate python venv then run pip

    local _activate="source ~/.sys/python/bin/activate"
    local _pip_install_cmd=( \
            "$_activate && pip install -U pip" \
            "$_activate && pip install flake8 autopep8 yapf" \
            "$_activate && pip install pylint beautifulsoup4" \
            "$_activate && pip install pytest coverage" \
            "$_activate && pip install numpy pandas" \
            "$_activate && pip install pandas-datareader matplotlib" \
            "$_activate && pip install jupyterlab" \
    )

    Execute_Commands_List \
        $_test_mode \
        "===> Install packages for $_program_name" \
        "${_pip_install_cmd[@]}"

    # copy .pylintrc and create symlink for it   

    Copy_Files $_test_mode \
               "$_program_name pylint rc file" \
	             "${_copy_from[@]}" \
	             "${_copy_to[@]}"

    Create_Symlinks $_test_mode \
                    "$_program_name pylint rc file" \
	                  "${_symlink_destination[@]}" \
	                  "${_symlink_target[@]}"

}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then

    # indicate script is being run directly	

    Test_Mode=$(Check_Test_Mode "$@")   # check if TEST mode

    Project_Name="Raspberry PI Python Setup"

    Print_Header_Banner $Test_Mode "$Project_Name" 
    
    Install_Python $Test_Mode "$HOME/.sys/python" "$HOME/dev"
    
    Print_Footer_Banner "$Project_Name" 

fi	

