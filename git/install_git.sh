#!/bin/bash
# execute this script file using Bourne shell

source "$(dirname $0)/../share/colors.sh"    # color settings

source "$(dirname $0)/../share/common.sh"    # shared functions

function Install_Git {

    # $1 test mode indicator, empty string means not test mode
    # $2 Installation directory, default is the same dir as script file

    local _test_mode=$1

    local _install_Dir="$HOME/.sys/git"
    if [ "$#" -gt 1 ]; then                                              
         _install_dir=$2                                                  
    fi 

    # Downloading / Upgrading Git
    
    local _program_name="git"
 
    Execute "$_test_mode" \
            "\"sudo apt install git -y\"" \
            "===> Installing $_program_name" 

    local _command="git config --global user.email \"kongyukloong@gmail.com\""
    Execute "$_test_mode" "\"$_command\"" "===> Setting up $_program_name" 

    local _command="git config --global user.name \"Camel King\""
    Execute "$_test_mode" "\"$_command\"" 

    local _command="git config --global pull.rebase true"
    Execute "$_test_mode" "\"$_command\"" 

    
    # pull the git-prompt.sh from github repo

    local _program_name="git-prompt"

    local _download_git_prompt_command="curl --create-dirs -o $_install_dir/git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh"

    Execute "$_test_mode" \
            "\"$_download_git_prompt_command\"" \
            "===> Downloading $_program_name" 

    # pull the git-completion.bash from github repo
    
    local _program_name="git-completion"

    local _download_git_completion_command="curl --create-dirs -o $_install_dir/git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash"

    Execute "$_test_mode" \
            "\"$_download_git_completion_command\"" \
            "===> Downloading $_program_name" 


}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then

    # indicate script is being run directly	

    Test_Mode=$(Check_Test_Mode "$@")   # check if TEST mode

    Project_Name="Raspberry PI Configuration Setup"

    Print_Header_Banner $Test_Mode "$Project_Name" 

    Update_System $Test_Mode

    # Install_Vim $Test_Mode "$(dirname $(readlink -f $0))" 
    Install_Git $Test_Mode "$HOME/.sys/git"

    Print_Main_Footer_Banner "$Project_Name" 

fi	
