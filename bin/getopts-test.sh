#!/bin/bash
# getopts
#
# getopts-test.sh -vi -t "two words" -a -q --test="three wor ds" -- -x
#

######## Inclusion of the lib
LIBFILE="`dirname $0`/../src/piwi-bash-library.sh"
if [ -f "$LIBFILE" ]; then source "$LIBFILE"; else
    PADDER=$(printf '%0.1s' "#"{1..1000})
    printf "\n### %*.*s\n    %s\n    %s\n%*.*s\n\n" 0 $(($(tput cols)-4)) "ERROR! $PADDER" \
        "Unable to find required library file '$LIBFILE'!" \
        "Sent in '$0' line '${LINENO}' by '`whoami`' - pwd is '`pwd`'" \
        0 $(tput cols) "$PADDER";
    exit 1
fi
######## !Inclusion of the lib

NAME="Bash-Lib script options & arguments test"
VERSION="0.0.1-test"
DESCRIPTION="A script to test custom script options & arguments usage ...\n\
\tTo test it, run:\n\
\t\t~\$ path/to/getopts-test.sh myaction1 -vi -t \"two words\" -a -f --test=\"three wor ds\" myaction2 -- myaction3 -x\n\
\tResult is:\n\
\t\t- the first common options 'v' and 'i' are parsed and considered by the library,\n\
\t\t- the third common option 'q' is parsed but NOT considered by the library as it is after a custom option,\n\
\t\t- the custom 't' and 'test' options are parsed and considered by this script and their multi-words arguments are red,\n\
\t\t- the custom 'a' option is parsed and considered by this script,\n\
\t\t- the last common option 'x' is NOT parsed at all as it is after '--'.";
SYNOPSIS="$LIB_SYNOPSIS_ACTION"

# for custom options, write an info string about usage
# you can use the common library options string with $COMMON_OPTIONS_FULLINFO
OPTIONS="<bold>-t, --test=ARG</bold>\ttest a short and long option with argument\n\
\t<bold>-a</bold>\t\ta single short option to test options order\n\n\
\t<underline>Common options</underline> (to use first):\n\
\t${COMMON_OPTIONS_FULLINFO}";

OPTIONS_ALLOWED="t:a${COMMON_OPTIONS_ALLOWED}"
LONG_OPTIONS_ALLOWED="test:,${COMMON_LONG_OPTIONS_ALLOWED}"
SYNOPSIS_ERROR="${0}  [-${COMMON_OPTIONS_ALLOWED_MASK}]\n\t[-a]  [-t [=value]]  [--test [=value]]  --  <arguments>";

quietecho "_ go"

echo
echo "# command line analysis:"
echo "- allowed short options: '${OPTIONS_ALLOWED}'";
echo "- allowed long options: '${LONG_OPTIONS_ALLOWED}'";
echo "- received arguments: '$@'";
echo
echo "# re-arranging options and arguments:"
rearrangescriptoptions "$@"
echo "- 'SCRIPT_OPTS' is now '${SCRIPT_OPTS[@]}'"
echo "- 'SCRIPT_ARGS' is now '${SCRIPT_ARGS[@]}'"
[ "${#SCRIPT_OPTS[@]}" -gt 0 ] && set -- "${SCRIPT_OPTS[@]}";
[ "${#SCRIPT_ARGS[@]}" -gt 0 ] && set -- "${SCRIPT_ARGS[@]}";
[ "${#SCRIPT_OPTS[@]}" -gt 0 -a "${#SCRIPT_ARGS[@]}" -gt 0 ] && set -- "${SCRIPT_OPTS[@]}" -- "${SCRIPT_ARGS[@]}";
parsecommonoptions_strict
echo "- rearranged arguments: '$@'";
echo

echo "# first loop for the 't' or 'test' option"
echo "# to test it, run:"
echo "#      ~\$ $0 -t \"two words\" --test=\"three wor ds\" -- -x"
OPTIND=1
while getopts ":at:${OPTIONS_ALLOWED}" OPTION; do
    OPTARG="${OPTARG#=}"
    case $OPTION in
        t) _echo " - option 't': receiving argument \"${OPTARG}\"";;
        -)  # for long options with argument, use fct 'getlongoptionarg ( $arg )'
            LONGOPTARG="`getlongoptionarg \"${OPTARG}\"`"
            case $OPTARG in
                test*) _echo " - option 'test': receiving argument \"${LONGOPTARG}\"";;
                ?) echo " - unknown long option '$OPTARG'";;
            esac ;;
        ?) echo " - unknown option '$OPTION'";;
    esac
done
echo

echo "# second loop for the 'a' option"
echo "# to test it, run:"
echo "#      ~\$ $0 -via -- -x OR ~\$ $0 -vi -a -- -x"
OPTIND=1
while getopts ":at:${OPTIONS_ALLOWED}" OPTION; do
    case $OPTION in
        a) echo " - test option A";;
        ?) echo " - unknown option '$OPTION'";;
    esac
done
echo

echo "# test for the last 'action' argument";
echo "# to test it, run:"
echo "#      ~\$ $0 ... action -x"
lastarg=$(getlastargument)
echo " - last argument is '${lastarg}'"
echo

echo "# test for the 'action' arguments";
echo "# to test it, run:"
echo "#      ~\$ $0 action1 action2 ... -x"
getnextargument
echo " - first argument is '$ARGUMENT'"
getnextargument
echo " - next argument is '$ARGUMENT'"
echo
echo "# finally:"
echo " - 'ARGIND' is: $ARGIND"
echo

quietecho "_ ok"
if ! $QUIET; then libdebug "$*"; fi
exit 0

# Endfile
