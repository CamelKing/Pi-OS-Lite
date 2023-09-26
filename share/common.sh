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

function Print_Header_Banner {

    # clock start time
    # print installation start message banner
    # $1 test mode indicator, 't' for test mode

    local _test_mode=$1

    SECONDS=0

    echo -e ""
    echo -e "$READ ============================================$NORM"
    echo -e "$INFO PI OS Lite Development Mode Setup Starting  $NORM"
    if [[ "$_test_mode" == "t" ]]; then
        echo -e ""
        echo -e "$WARN <<<< Currently in TEST MODE >>>> $NORM"
        echo -e "$WARN <<<< No Actual Installation >>>> $NORM"
        echo -e ""
    fi
    echo -e "$READ ============================================$NORM"
    echo -e ""
}

function Print_Footer_Banner {

    # calculate elapsed time
    # print installation end message banner with elapsed time

    local _duration=$SECONDS
    local _elapsed=""
    if [[ "$_duration" -gt "60" ]]; then
        _elapsed="$(( _duration / 60 )) minutes and "
    fi 
    _elapsed="$_elapsed$(( _duration % 60 )) seconds"

    echo -e "$READ ============================================$NORM"
    echo -e "$INFO PI OS Lite Development Mode Setup Completed $NORM"
    echo -e "$INFO Elapsed Time: $_elapsed.                    $NORM"
    echo -e "$READ ============================================$NORM"
    echo -e ""
}

function Make_Directories {

    # $1 test mode indicator, 't' for test mode
    # $2... ($@ after shift 1) directories to be created (with parents)

    local _test_mode=$1
    shift 1

    echo -e "$INFO ===> Creating directories... $NORM"

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

    local _test_mode=$1
    shift 1

    echo -e "$INFO ===> Removing directories... $NORM"

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

function Create_Symlinks {

    # $1 test mode indicator, 't' for test mode
    # $2... ($@ after shift 1) combo of $_destination $_target arrays
    # usage: Create_Symlinks "$_test_mode" "${_destination[@]}" "${_target[@]}"


    local _destine
    local _command
    local _test_mode=$1
    shift 1
    local _input=("$@")
    # split into 2 equal size array 
    local _len=$(( ${#_input[@]} / 2 ))
    local _destination=("${_input[@]:0:$_len}")
    local _target=("${_input[@]:$_len}")

    echo -e "$INFO ===> Creating symlinks... $NORM"

    if [[ "$_test_mode" == "t" ]]; then
        echo -e "$READ Command to execute is: $NORM"
    fi

    for i in "${!_destination[@]}"; do
	_destine=${_destination[$i]}     
        if [ -e ${_destination[$i]} ]; then  # check file/dir exist
            _command="ln -sfv ${_destination[$i]} ${_target[$i]}"
            if [[ "$_test_mode" == "t" ]]; then
                echo -e "$WARN $_command $NORM"
            else
                eval "$_command"
            fi
	else
	    echo -e "$WARN $_destine does not exist, no symlink created $NORM"
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

    echo -e "$INFO $3 $NORM"
    if [[ "$_test_mode" == "t" ]]; then
        echo -e "$READ Command to execute is: \n$WARN $2 $NORM"
    else
        eval "$2"
    fi
    echo -e ""
}



