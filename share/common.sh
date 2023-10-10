#!/bin/zsh
# add -x on shebang for debug purpose

function Check_Test_Mode {

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
}

function _Print_Header_Banner {

    # clock start time
    # print installation start message banner
    # $1 test mode indicator, 't' for test mode
    # $@ (after shift 1) header banner messages

    local _test_mode=$1
    shift 1

    SECONDS=0

    echo -e ""
    echo -e "$READ ============================================$NORM"

    for _msg in "$@"; do
	# Remove leading and trailing double quotes
	_msg="${_msg%\"}"
	_msg="${_msg#\"}"
        echo -e "$INFO ${_msg} $NORM"
    done

    if [[ "$_test_mode" == "t" ]]; then
        echo -e "$WARN <<<< Currently in TEST MODE >>>> $NORM"
        echo -e "$WARN <<<< No Actual Installation >>>> $NORM"
    fi

    echo -e "$READ ============================================$NORM"
    echo -e ""
}

function _Print_Footer_Banner {

    # calculate elapsed time
    # print installation end message banner with elapsed time
    # $@ footer banner messages

    local _duration=$SECONDS
    local _elapsed=""
    if [[ "$_duration" -gt "60" ]]; then
        _elapsed="$(( _duration / 60 )) minutes and "
    fi 
    _elapsed="$_elapsed$(( _duration % 60 )) seconds"

    echo -e "$READ ============================================$NORM"

    for _msg in "$@"; do
	# Remove leading and trailing double quotes
	_msg="${_msg%\"}"
	_msg="${_msg#\"}"
        echo -e "$INFO ${_msg} $NORM"
    done

    echo -e "$READ Elapsed Time: $_elapsed.                    $NORM"
    echo -e "$READ ============================================$NORM"
    echo -e ""
}


function Print_Header_Banner {

    # print main installation start message banner
    
    _Print_Header_Banner $1 "\"$2 Started\""

}


function Print_Main_Footer_Banner {

    # print main installation end message banner

    _Print_Footer_Banner "\"$1 Completed\""

}

function Make_Directories {

    # $1 test mode indicator, 't' for test mode
    # $2 name of the program for which these dirs are for
    # $3... ($@ after shift 2) directories to be created (with parents)

    local _test_mode=$1
    local _program_name=$2
    shift 2

    echo -e "$INFO ===> Creating directories for $_program_name $NORM"

    if [[ "$_test_mode" == "t" ]]; then
        echo -e "$READ Command to execute is: $NORM"
    fi

    local _dir
    local _command="mkdir -p -v"
    for _dir in "$@"; do
        if [[ ! -z "$_dir" ]]; then
             if [[ "$_test_mode" == "t" ]]; then
                 echo -e "$WARN $_command $_dir $NORM"
             else
                 eval "$_command $_dir"
             fi
        fi
    done

    echo -e ""

}

function Remove_Directories {

    # $1 test mode indicator, 't' for test mode
    # $2... ($@ after shift 1) directories to be removed (recursive/forced)

    # $1 test mode indicator, 't' for test mode
    # $2 name of the program for which these dirs are for
    # $3... ($@ after shift 2) directories to be removed (recursive/forced)

    local _test_mode=$1
    local _program_name=$2
    shift 2

    echo -e "$INFO ===> Removing $_program_name directories $NORM"

    if [[ "$_test_mode" == "t" ]]; then
        echo -e "$READ Command to execute is: $NORM"
    fi

    local _dir
    local _command="rm -f -r -v"
    for _dir in "$@"; do
        if [[ ! -z "$_dir" ]]; then
             if [[ "$_test_mode" == "t" ]]; then
                 echo -e "$WARN $_command $_dir $NORM"
             else
                 eval "$_command $_dir"
             fi
        fi
    done

    echo -e ""
}

function Copy_Files {

    # $1 test mode indicator, 't' for test mode
    # $2... ($@ after shift 1) combo of 
    #       $_dirs_to_copy_from $_dirs_to_copy_to arrays
    # usage: Copy_Files "$_test_mode" "${_copy_from[@]}" "${_copy_to[@]}"

    local _command
    local _test_mode=$1
    shift 1
    local _input=("$@")
    # split into 2 equal size array 
    local _len=$(( ${#_input[@]} / 2 ))
    local _copy_from=("${_input[@]:0:$_len}")
    local _copy_to=("${_input[@]:$_len}")

    echo -e "$INFO ===> Copying Files/Directories... $NORM"

    if [[ "$_test_mode" == "t" ]]; then
        echo -e "$READ Command to execute is: $NORM"
    fi

    for i in "${!_copy_from[@]}"; do
        if [ -e ${_copy_from[$i]} ]; then  # check file/dir exist
            _command="cp -r ${_copy_from[$i]} ${_copy_to[$i]}"
            if [[ "$_test_mode" == "t" ]]; then
                echo -e "$WARN $_command $NORM"
            else
                eval "$_command"
            fi
	else
	    echo -e "$WARN ${_copy_from[$i]} does not exist $NORM"
	fi
    done
    echo -e ""
}


function Create_Symlinks {

    # $1 test mode indicator, 't' for test mode
    # $2... ($@ after shift 1) combo of $_target $_link_name arrays
    # usage: Create_Symlinks "$_test_mode" "${_target[@]}" "${_link_name[@]}"


    local _command
    local _test_mode=$1
    shift 1
    local _input=("$@")
    # split into 2 equal size array 
    local _len=$(( ${#_input[@]} / 2 ))
    local _target=("${_input[@]:0:$_len}")
    local _link_name=("${_input[@]:$_len}")

    echo -e "$INFO ===> Creating symlinks... $NORM"

    if [[ "$_test_mode" == "t" ]]; then
        echo -e "$READ Command to execute is: $NORM"
    fi

    for i in "${!_target[@]}"; do
        if [ -e ${_target[$i]} ]; then  # check file/dir exist
            _command="ln -sfv ${_target[$i]} ${_link_name[$i]}"
            if [[ "$_test_mode" == "t" ]]; then
                echo -e "$WARN $_command $NORM"
            else
                eval "$_command"
            fi
        else
            echo -e "$WARN ${_target[$i]} does not exist, no symlink created $NORM"
        fi
    done

    echo -e ""
}

function Remove_Symlinks {

    # $1 test mode indicator, 't' for test mode
    # $2 name of the program for which these dirs are for
    # $3... ($@ after shift 2) symlinks to be removed

    local _test_mode=$1
    local _program_name=$2
    shift 2

    echo -e "$INFO ===> Removing $_program_name symlinks $NORM"

    if [[ "$_test_mode" == "t" ]]; then
        echo -e "$READ Command to execute is: $NORM"
    fi

    local _dir
    local _command="rm "
    for _dir in "$@"; do
        if [[ ! -z "$_dir" ]]; then
             if [[ "$_test_mode" == "t" ]]; then
                 echo -e "$WARN $_command $_dir $NORM"
             else
                 eval "$_command $_dir"
             fi
        fi
    done

    echo -e ""
}


function Execute {

    # print message and execute the command to install
    # only echo the command if in test mode
    # $1 test mode indicator, 't' for test mode
    # $2 - command to execute
    # $3 - message to be printed as $INFO

    local _test_mode=$1

    # Remove leading and trailing double quotes
    local _command=$2
    _command="${_command%\"}"
    _command="${_command#\"}"

    echo -e "$INFO $3 $NORM"
    if [[ "$_test_mode" == "t" ]]; then
        echo -e "$READ Command to execute is: \n$WARN $_command $NORM"
    else
        eval "$_command"
    fi
    echo -e ""
}


function Update_System {

    # perform a total system update
    # $1 test mode indicator, 't' for test mode

    local _test_mode=$1

    Execute "$Test_Mode" \
            "sudo apt update && sudo apt upgrade -y" \
            "===> Updating system software" 

}
