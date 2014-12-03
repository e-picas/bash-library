#!/usr/bin/env bash
# getopts
#
# getopts-test.sh -vi -t "two words" -a -q --test="three wor ds" -- -x
#

######## Inclusion of the lib
LIBFILE="`dirname $0`/../src/piwi-bash-library.sh"
if [ -f "${LIBFILE}" ]; then source "${LIBFILE}"; else
    PADDER=$(printf '%0.1s' "#"{1..1000})
    printf "\n### %*.*s\n    %s\n    %s\n%*.*s\n\n" 0 $(($(tput cols)-4)) "ERROR! ${PADDER}" \
        "Unable to find required library file '${LIBFILE}'!" \
        "Sent in '$0' line '${LINENO}' by '`whoami`' - pwd is '`pwd`'" \
        0 $(tput cols) "${PADDER}";
    exit 1
fi
######## !Inclusion of the lib

quietecho "_ go"
echo

# command line "as is"
echo "> original script's arguments are: $*"
echo

# definitions of short and long options
OPTIONS_ALLOWED="t:u::a${COMMON_OPTIONS_ALLOWED}"
LONG_OPTIONS_ALLOWED="test1:,test2::,${COMMON_LONG_OPTIONS_ALLOWED}"

# check
echo "> script settings:"
echo " - short options are:         ${OPTIONS_ALLOWED}"
shortopts_table=( $(get_short_options_array) )
echo " - short options table is:    ${shortopts_table[@]}"
echo " - long options are:          ${LONG_OPTIONS_ALLOWED}"
longopts_table=( $(get_long_options_array) )
echo " - long options table is:     ${longopts_table[@]}"
echo

# rearrangement of options & arguments using 'getopt'
rearrange_script_options_new "$0" "$@"
echo "> re-arranging options & arguments:"
echo " - SCRIPT_PARAMS are: $SCRIPT_PARAMS"
echo " - SCRIPT_OPTS are:   ${SCRIPT_OPTS[@]}"
echo " - SCRIPT_ARGS are:   ${SCRIPT_ARGS[@]}"
eval set -- "$SCRIPT_PARAMS"
echo

# parse common options
parse_common_options_strict
echo "> parsing common options ..."
echo

# check of new script arguments
echo "> script's arguments are now: $*"
echo

# loop over options
echo "> options loop:"
OPTIND=1
while getopts ":${OPTIONS_ALLOWED}" OPTION; do

    # OPTIND is the current option index

    # OPTNAME should be the one letter name of short option
    OPTNAME="$OPTION"

    # OPTARG should be the optional argument of the option
    OPTARG="$(get_option_arg "${OPTARG:-}")"

#    echo "> for option index '${OPTIND}' option is '${OPTNAME}' with argument '${OPTARG}'"
    case "$OPTION" in

        # case of long options
        -)

            # LONGOPTIND should be the same as OPTIND

            # LONGOPTNAME should be the name of the long option
            LONGOPTNAME="$(get_long_option "$OPTARG")"

            # LONGOPTARG should be the optional argument of the option
            LONGOPTARG="$(get_long_option_arg "$OPTARG")"

            # special load of arg if it is required (no mandatory equal sign)
            optiondef=$(get_long_option_declaration "$LONGOPTNAME")
#            if [ -z "$LONGOPTARG" ] && [ "${optiondef: -1}" = ':' ] && [ "${optiondef: -2}" != '::' ]; then
            if [ -z "$LONGOPTARG" ] && [ "${optiondef: -1}" = ':' ]; then
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
echo

# loop over arguments
echo "> arguments loop:"
if [ "${#SCRIPT_ARGS[@]}" -gt 0 ]; then
    while [[ "$ARGIND" -lt "${#SCRIPT_ARGS[@]}" ]]; do
        get_next_argument
        echo " - [${ARGIND}] argument is '$ARGUMENT'"
    done
fi
echo

# read any piped content via '/dev/stdin'
read_from_pipe '/dev/stdin'
echo "> caught piped content:"
if [ -n "$SCRIPT_INPUT" ]; then
    echo " - $SCRIPT_INPUT"
else
    echo " - none"
fi
echo

quietecho "_ ok"
if ! $QUIET; then libdebug "$*"; fi
exit 0

# Endfile
