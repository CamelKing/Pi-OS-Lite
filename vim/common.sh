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
 

    local _result=""

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
    # $1 test mode indicator, empty string means not test mode

    local _test_mode=$1

    SECONDS=0

    echo -e ""
    echo -e "$READ ============================================$NORM"
    echo -e "$INFO PI OS Lite Development Mode Setup Starting  $NORM"
    if [[ "$_test_mode" ]]; then
        echo -e ""
        echo -e "$WARN <<<< Currently in TEST MODE >>>> $NORM"
        echo -e "$WARN <<<< No Actual Installation >>>> $NORM"
        echo -e ""
    fi
    echo -e "$READ ============================================$NORM"
    echo -e ""
}

