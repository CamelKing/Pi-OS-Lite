#!/bin/bash
# execute this script file using Bourne shell

source "$(dirname $0)/../share/colors.sh"    # color settings

source "$(dirname $0)/../share/common.sh"    # shared functions

function Install_Git_Prompt {

    local _test_mode=$1

    local _program_name="git-prompt & git-completion"
    
    local _install_dir=$2
    
    # pull the git-prompt.sh from github repo
    local _download_git_prompt_command="curl --create-dirs -o $_install_dir/git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh"

    Execute "$_test_mode" \
            "\"$_download_git_prompt_command\"" \
            "===> Pulling git-prompt.sh from github repo" 

    # pull the git-completion.bash from github repo
    local _download_git_completion_command="curl --create-dirs -o $_install_dir/git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash"

    Execute "$_test_mode" \
            "\"$_download_git_completion_command\"" \
            "===> Pulling git-completion.bash from github repo" 

}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then

    # indicate script is being run directly	

    Test_Mode=$(Check_Test_Mode "$@")   # check if TEST mode

    Project_Name="PI OS Lite Development Mode Setup"

    Print_Header_Banner $Test_Mode "$Project_Name" 

    Update_System $Test_Mode

    # for Raspberry Pi, storing all files on $HOME/.sys
    # Install_Dir="$(dirname $(readlink -f $0))"
    Install_Dir="$HOME/.sys/bash"
    Install_Git_Prompt $Test_Mode $Install_Dir 

    Print_Main_Footer_Banner "$Project_Name" 

fi
