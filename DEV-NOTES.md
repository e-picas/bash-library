Development Notes
=================


## Search about script options, arguments and piped input

The goal is to be able to:

-   mix short and long options
-   mix arguments and options
-   redirect a previous command result by a pipe
-   use required and optional options'arguments

If the `getopt` command is available and is the "new" version, the best seems
to let it re-arrange options as it works quite fine in most of cases

    getopt --test > /dev/null
    if [ -n $? ] && [ $? -ne 4 ]; then
        echo "your version og 'getopt' is not enough!" >2
        exit 1
    fi

The rules for options'arguments must be:

-   for short options:
    -   if the argument is required, it can be written just after the option, separated
        by an equal sign eventually, or as the next argument, separated by a space
    -   if the argument is optional, it must be written just after the option, separated
        by an equal sign eventually
-   for long options:
    -   if the argument is required, it can be written separated from the option by an
        equal sign or a space
    -   if the argument is optional, it must be written separated from the option by an
        equal sign (no space is allowed as the argument is optional)


    # command line "as is"
    echo "> original script's arguments are: $*"
    
    # read any piped content via '/dev/stdin'
    read_from_pipe '/dev/stdin'
    echo "> piped content is: $SCRIPT_INPUT"
    
    # definitions of short and long options
    OPTIONS_ALLOWED="t:u::a${COMMON_OPTIONS_ALLOWED}"
    LONG_OPTIONS_ALLOWED="test1:,test2::,${COMMON_LONG_OPTIONS_ALLOWED}"
    
    # check
    echo "> short options are: ${OPTIONS_ALLOWED}"
    shortopts_table=( $(get_short_options_array) )
    echo "> short options table is: ${shortopts_table[@]}"
    echo "> long options are: ${LONG_OPTIONS_ALLOWED}"
    longopts_table=( $(get_long_options_array) )
    echo "> long options table is: ${longopts_table[@]}"
    
    # rearrangement of options & arguments using 'getopt'
    rearrange_script_options_new "$0" "$@"
    echo "> SCRIPT_PARAMS are: $SCRIPT_PARAMS"
    eval set -- "$SCRIPT_PARAMS"
    
    # check of new script arguments
    echo "> script's arguments are now:"
    echo "  $*"
    
    # loop over options
    OPTIND=1
    while getopts ":${OPTIONS_ALLOWED}" OPTION; do
    
        # OPTIND is the current option index
    
        # OPTNAME should be the one letter name of short option
        OPTNAME="$OPTION"
    
        # OPTARG should be the optional argument of the option
        OPTARG="$(get_option_arg "${OPTARG:-}")"

        #echo "> for option index '${OPTIND}' option is '${OPTNAME}' with argument '${OPTARG}'"
        case "$OPTNAME" in
    
            # case of long options
            -)
    
                # LONGOPTIND should be the same as OPTIND
    
                # LONGOPTNAME should be the name of the long option
                LONGOPTNAME="$(get_long_option "$OPTARG")"
    
                # LONGOPTARG should be the required or optional argument of the option
                LONGOPTARG="$(get_long_option_arg "$OPTARG")"
                # special load of arg if it is required (no mandatory equal sign)
                optiondef_ind=$(array_search "$LONGOPTNAME" "${longopts_table[@]}")
                [ -z "$optiondef_ind" ] && optiondef_ind=$(array_search "${LONGOPTNAME}:" "${longopts_table[@]}");
                [ -z "$optiondef_ind" ] && optiondef_ind=$(array_search "${LONGOPTNAME}::" "${longopts_table[@]}");
                optiondef="${longopts_table[${optiondef_ind}]}"
                if [ -n "$LONGOPTARG" ]||[ "${optiondef: -1}" = ':' ]; then
                    LONGOPTARG="${!OPTIND}"
                    OPTIND=$((OPTIND + 1))
                fi
    
                case "$LONGOPTION" in
                    *) echo " - [${OPTIND}] long option '${LONGOPTNAME}' with arg '${LONGOPTARG}'";;
                    \?) echo " - [${OPTIND}] unknown long option '${LONGOPTNAME}'";;
                esac
                ;;
    
            # case of short options
            *) echo " - [${OPTIND}] option '$OPTION' with arg '$OPTARG'";;
            \?) echo " - [${OPTIND}] unknown option '$OPTION'";;
    
        esac
    done
