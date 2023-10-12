#!/bin/bash
# execute this script file using Bourne shell

source "$(dirname $0)/../share/colors.sh"    # color settings

source "$(dirname $0)/../share/common.sh"    # shared functions

function Install_Git {

    # $1 test mode indicator, empty string means not test mode
    # $2 Installation directory, default is the same dir as script file

    local _test_mode=$1

    local _install_dir="$HOME/.sys/git"
    [ "$#" -gt 1 ] && _install_dir=$2

    local _program_name="git"

    local _git_config_cmd=( \
        "git config --global user.email \"kongyukloong@gmail.com\"" \
        "git config --global user.name \"Camel King\"" \
        "git config --global pull.rebase true" \
        "git config -l" \
        )


    # Install git

    Execute "$_test_mode" \
            "sudo apt install git -y" \
            "===> Installing $_program_name" 

    # git config settings

    Execute_Commands_List "$_test_mode" \
            "===> Setting up $_program_name" \
            "${_git_config_cmd[@]}"
   
    # pull the git-prompt.sh from github repo

    Execute "$_test_mode" \
            "curl --create-dirs -o $_install_dir/git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh" \
            "===> Downloading git-prompt" 

    # pull the git-completion.bash from github repo
    
    Execute "$_test_mode" \
            "curl --create-dirs -o $_install_dir/git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash" \
            "===> Downloading git-completion" 

}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then

    # indicate script is being run directly	

    Test_Mode=$(Check_Test_Mode "$@")   # check if TEST mode

    Project_Name="Raspberry PI Git Setup"

    Print_Header_Banner $Test_Mode "$Project_Name" 

    Update_System $Test_Mode

    # Install_Vim $Test_Mode "$(dirname $(readlink -f $0))" 
    Install_Git $Test_Mode "$HOME/.sys/git"

    Print_Footer_Banner "$Project_Name" 

fi	
