#!/bin/bash
# add -x on shebang for debug purpose

# Public routines - functions named with
#   Pascal_Snake_Case, meant to be 
#   called from other .sh script file.
#
# Private routines - functions named with 
#   _snake_case, meant to be called by 
#   functions in this script file.

#---------------------------------------------
# Public routines section
#---------------------------------------------

function Check_Test_Mode { 
#{{{1

    # check if in "Test" mode.
    # test mode is indicated by -T or -t.
    # will only print command rather than runs it.
    # print an indicator message if Test Mode.

    # $@ all arguments passed to the main script
    # return test mode indicator as a string echoed
    #        - non test mode would be empty string
    #        - test mode would be returned as "test"

    # usage Test_Mode=$(Check_Test_Mode $@)
    # subsequently can just test with: 
    #     if [[ "$Test_Mode" ]];
 

    local _result="f"

    for arg in "$@"
    do
        if [[ "$arg" == "-T" || "$arg" == "-t" ]]; then
            _result="t"
            break
        fi
    done

    echo "$_result"

#}}}
} 


function Print_Header_Banner {
#{{{1

    # $1 - test mode indicator, 't' for test mode
    # $2 - name of installation process 
    #
    # print main installation start message banner
    #
    # usage:
    #   Print_Header_Banner "$Test_Mode" "Raspberry Pi OS Setup"

    _print_header_banner $1 "\"$2 Started\""


#}}}
}


function Print_Footer_Banner {
#{{{1

    # $1 - name of installation process 
    #      (should match the $2 by Print_Header_Banner)
    #
    # print main installation end message banner
    #
    # usage:
    #   Print_Footer_Banner "Raspberry Pi OS Setup"

    _print_footer_banner "\"$1 Completed\""

#}}}
}


function Make_Directories {
#{{{1

    # $1 test mode indicator, 't' for test mode
    # $2 name of the program for which these dirs are for
    # $3... ($@ after shift 2) directories to be created (with parents)

    local _test_mode=$1
    local _program_name=$2
    shift 2

    _execute_thru_files_list \
        "$_test_mode" \
        "mkdir -pv" \
        "===> Creating directories for $_program_name" \
        "9" \
        "" \
        "$@"

#     echo -e "$INFO ===> Creating directories for $_program_name $NORM"
#
    # if [[ "$_test_mode" == "t" ]]; then
        # echo -e "$DEBUG1 Command to execute is: $NORM"
    # fi
#
    # local _dir
    # local _command="mkdir -p -v"
    # for _dir in "$@"; do
        # if [[ ! -z "$_dir" ]]; then
             # if [[ "$_test_mode" == "t" ]]; then
                 # echo -e "$DEBUG2 $_command $_dir $NORM"
             # else
                 # eval "$_command $_dir"
             # fi
        # fi
    # done
#
    # echo -e ""
#

#}}}
}


function Remove_Directories {
#{{{1

    # $1 test mode indicator, 't' for test mode
    # $2 name of the program for which these dirs are for
    # $3... ($@ after shift 2) directories to be removed (recursive/forced)

    local _test_mode=$1
    local _program_name=$2
    shift 2

    _execute_thru_files_list \
        "$_test_mode" \
        "rm -rfv" \
        "===> Removing directories for $_program_name" \
        "2" \
        "not found" \
        "$@"
 
#}}}
}


function Copy_Files {
#{{{1

    # $1 test mode indicator, 't' for test mode
    # $2... ($@ after shift 1) combo of $_from $_to arrays
    #
    # usage: 
    # Copy_Files "$_test_mode" "${_from[@]}" "${_to[@]}"
    #
    # IMPORTANT:
    # ASSUME the passed in array $2... can be split into two equal arrays


    local _test_mode=$1
    shift 1

    _execute_thru_files_pairs $_test_mode \
                              "cp -vr" \
                              "===> Copying Files/Directories..." \
                              $@

#}}}
}


function Create_Symlinks {
#{{{1

    # $1 test mode indicator, 't' for test mode
    # $2... ($@ after shift 1) combo of $_target $_link_name arrays
    #
    # usage: 
    # Create_Symlinks "$_test_mode" "${_target[@]}" "${_link_name[@]}"
    #
    # IMPORTANT:
    # ASSUME the passed in array $2... can be split into two equal arrays

    local _test_mode=$1
    shift 1

    _execute_thru_files_pairs $_test_mode \
                              "ln -sfv" \
                              "===> Creating symlinks..." \
                              $@

#}}}
}


function Remove_Symlinks {
#{{{1

    # $1 test mode indicator, 't' for test mode
    # $2 name of the program for which these dirs are for
    # $3... ($@ after shift 2) symlinks to be removed

    local _test_mode=$1
    local _program_name=$2
    shift 2

    _execute_thru_files_list \
        "$_test_mode" \
        "rm -v" \
        "===> Removing symlinks for $_program_name" \
        "3" \
        "not found" \
        "$@"

#}}}
}


function Execute {
#{{{1

    # construct arguments so that arguments with 
    # spaces can be passed on correctly

    local _p1=""
    local _p2=""
    local _p3=""
    if [ "$1" ]; then
        _p1="$1"
        if [ "$2" ]; then
            _p2="\"$2\""
            if [ "$3" ]; then
                _p3="\"$3\""
            fi
        fi
    fi

    _execute "$_p1" "$_p2" "$_p3"

#}}}
}


function Execute_Commands_List {
#{{{1

    # $1 test mode indicator, 't' for test mode
    # $2 messages to be printed
    # $3... ($@ after shift 2) Commands to execute

    local _test_mode=$1
    local _msg=$2
    shift 2

    _execute_commands_list \
        "$_test_mode" \
        "$_msg" \
        "$@"

#}}}
}


function Update_System {
#{{{1

    # perform a total system update
    # $1 test mode indicator, 't' for test mode

    local _test_mode=$1

    _execute "$_test_mode" \
             "sudo apt update && sudo apt upgrade -y" \
             "===> Updating system software" 

#}}}
}

#---------------------------------------------
# Private routines section
#---------------------------------------------

function _print_header_banner {
#{{{1

    # clock start time
    # print installation start message banner
    #
    # $1 test mode indicator, 't' for test mode
    # $2... ($@ after shift 1) header banner messages
    #
    # Note: messages with space in between should be
    #       passed in with surround quotes, eg. ""\"$msg\""
    #       else every space will be printed on a new line
    #
    # usage: 
    #   _print_header_banner "$_test_mode" \
    #                        "\"$_message_with_space\"" \
    #                        "$_message_with_no_space"

    local _test_mode=$1
    shift 1

    SECONDS=0

    echo -e ""
    echo -e "$READ ============================================$NORM"

    for _msg in "$@"; do
        echo -e "$INFO $(_strip_quotes "$_msg") $NORM"
    done

    if [[ "$_test_mode" == "t" ]]; then
        echo -e "$DEBUG1 Currently in TEST MODE $NORM"
        echo -e "$DEBUG1 No Actual Installation $NORM"
    fi

    echo -e "$READ ============================================$NORM"
    echo -e ""

#}}}
}


function _print_footer_banner {
#{{{1

    # calculate elapsed time
    # print installation end message banner with elapsed time
    #
    # $@ footer banner messages
    #
    # Note: messages with space in between should be
    #       passed in with surround quotes, eg. ""\"$msg\""
    #       else every space will be printed on a new line
    #
    # usage: 
    #   _print_footer_message "\"$_message_with_space\"" \
    #                         "$_message_with_no_space"

    local _duration=$SECONDS
    local _elapsed=""
    if [[ "$_duration" -gt "60" ]]; then
        _elapsed="$(( _duration / 60 )) minutes and "
    fi 
    _elapsed="$_elapsed$(( _duration % 60 )) seconds"

    echo -e "$READ ============================================$NORM"

    for _msg in "$@"; do
        echo -e "$INFO $(_strip_quotes "$_msg") $NORM"
    done

    echo -e "$READ Elapsed Time: $_elapsed.                    $NORM"
    echo -e "$READ ============================================$NORM"
    echo -e ""

#}}}
}


function _execute {
#{{{1

    # print message and execute the command to install
    # only echo the command if in test mode
    # $1 - test mode indicator, 't' for test mode
    # $2 - command to execute
    # $3 - optional message to be printed as $INFO

    local _test_mode=$1

    # only print non empty message line
    if [ ! -z "$3" ]; then
        local _msg=$(_strip_quotes "$3")
        echo -e "$INFO $_msg $NORM"
    fi

    # only print command if test mode, else execute it
    local _command=$(_strip_quotes "$2")
    if [[ "$_test_mode" == "t" ]]; then
        echo -e "$DEBUG1 Command to execute is: \n$DEBUG2 $_command $NORM"
    else
        eval "$_command"
    fi

    # empty line at end of execution
    echo -e ""

#}}}
}


function _strip_quotes {
#{{{1

    # Remove leading and trailing double quotes
    # of the passed in string $1 if any and
    # return the result as an echoed string
    local _str="${1#\"}"
    echo "${_str%\"}"

#}}}    
}


function _check_items {
#{{{1

    local _pass="f"

    # perform check on item if required
    case $1 in
        1)
            [ -f $2 ] && _pass="t" ;;

        2)
            [ -d $2 ] && _pass="t" ;;

        3)
            [ -L $2 ] && _pass="t" ;;

        4)
            [ -e $2 ] && _pass="t" ;;

        9)
            [ ! -e $2 ] && _pass="t" ;;

        *)
            _pass="f" ;;
    esac

    [ "$1" = "" ] && _pass="t"

    echo "$_pass"

#}}}
}


function _execute_thru_files_pairs {
#{{{1

    # $1 - test mode indicator, 't' for test mode
    # $2 - command to execute on every pair of from..to
    # $3 - optional message to be printed as $INFO
    #      "" to skip
    # $4... ($@ after shift 3) combo of $_from $_to arrays
    #
    # usage: 
    # _execute_thru_files_pairs "$_test_mode" \
    #                           "ln -svf" \
    #                           "Creating Symlink" \
    #                           "${_from[@]}" \
    #                           "${_to[@]}"
    #
    # IMPORTANT:
    # ASSUME the passed in array $4 ... can be split into two equal arrays

    local _test_mode=$1
    local _cmd=$2
    local _msg=$3
    shift 3

    # split into 2 equal size array 
    local _input=("$@")
    local _len=$(( ${#_input[@]} / 2 ))
    local _from=("${_input[@]:0:$_len}")
    local _to=("${_input[@]:$_len}")

    # print verbose messages
    if [ ! -z "$_msg" ]; then
        echo -e "$INFO $_msg $NORM"
    fi

    if [[ "$_test_mode" == "t" ]]; then
        echo -e "$DEBUG1 Command to execute is: $NORM"
    fi

    # loop thru arrays, construct the full command 
    # line and execute/print it
    local _full_command_line
    for i in "${!_to[@]}"; do
        if [ -e ${_from[$i]} ]; then  # check file/dir exist
            _full_command_line="$_cmd ${_from[$i]} ${_to[$i]}"
            if [[ "$_test_mode" == "t" ]]; then
                echo -e "$DEBUG2 $_full_command_line $NORM"
            else
                eval "$_full_command_line"
            fi
        else
            echo -e "$WARN ${_from[$i]} does not exist $NORM"
        fi
    done

    # spacing line at end of execution
    echo -e ""

#}}}
}


function _execute_thru_files_list {
#{{{1

    # $1 - test mode indicator, 't' for test mode
    # $2 - command to execute on every element of array
    # $3 - optional message to be printed as $INFO
    #      "" to skip
    # $4 - optional check on array elements
    #      "" no check
    #      "1" check if file exist
    #      "2" check if directory exist
    #      "3" check if symlink exist
    #      "4" check if filenode exist (directory/file/link)
    #      "9" check if filenode does not exist (directory/file/link)
    # $5 - optional error message to be appended after item name
    #      "" to disable
    # $6... ($@ after shift 4) array to be acted on
    #
    # usage: 
    # _execute_thru_files_list \
    #   "$_test_mode" \
    #   "rm -rfv" \
    #   "Removing Directories" \
    #   "2" \
    #   "${_dirs[@]}" 
    #
    # IMPORTANT:
    # There would be no test on the items array,
    # as such it is up to the calling function
    # to perform the checks, and display/surpress
    # any error messages
    
    local _test_mode=$1
    local _cmd=$2
    local _msg=$3
    local _chk=$4
    local _err_msg=$5
    shift 5
    local _items=("$@")

    # print verbose messages
    if [ ! -z "$_msg" ]; then
        echo -e "$INFO $_msg $NORM"
    fi

    # Using a variable to ensure this line 
    # will be onl printed once, IF there
    # is any action to be executed.
    if [[ "$_test_mode" == "t" ]]; then
        local _debug_msg="$DEBUG1 Command to execute is: $NORM\n"
    fi

    # loop thru arrays, construct the full command 
    # line and execute/print it
    for i in "${!_items[@]}"; do

        local _full_command_line
        # perform a check on the item before executing command
        if [ "$(_check_items "$_chk" "${_items[$i]}")" = "t" ]; then
            # construct command and execute on item
            _full_command_line="$_cmd ${_items[$i]}"
            if [[ "$_test_mode" == "t" ]]; then
                echo -e "$_debug_msg$DEBUG2 $_full_command_line $NORM"
                # clear the string so no more one time msg
                _debug_msg="" 
            else
                eval "$_full_command_line"
            fi
        else
            if [[ ! -z $_err_msg ]]; then
                echo -e "$WARN ${_items[$i]} $_err_msg $NORM"
            fi
        fi

    done

    # spacing line at end of execution
    echo -e ""

#}}}
}


function _execute_commands_list {
#{{{1

    # $1 - test mode indicator, 't' for test mode
    # $2 - optional message to be printed as $INFO
    #      "" to skip
    # $3... ($@ after shift 2) array to be acted on
    #
    # usage: 
    # _execute_commands_list \
    #   "$_test_mode" \
    #   "Setting up git" \
    #   "${_commands[@]}" 
    #
    
    local _test_mode=$1
    local _msg=$2
    shift 2
    local _commands=("$@")

    # print verbose messages
    if [ ! -z "$_msg" ]; then
        echo -e "$INFO $_msg $NORM"
    fi

    # Using a variable to ensure this line 
    # will be onl printed once, IF there
    # is any action to be executed.
    if [[ "$_test_mode" == "t" ]]; then
        local _debug_msg="$DEBUG1 Command to execute is: $NORM\n"
    fi

    # loop thru commands list, print if test mode
    # else execute
    for i in "${!_commands[@]}"; do
        if [[ "$_test_mode" == "t" ]]; then
            echo -e "$_debug_msg$DEBUG2 ${_commands[$i]} $NORM"
            # clear the string so no more one time msg
            _debug_msg="" 
        else
            eval "${_commands[$i]}"
        fi
    done

    # spacing line at end of execution
    echo -e ""

#}}}
}



