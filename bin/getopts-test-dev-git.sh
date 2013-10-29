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
\t\t~\$ path/to/getopts-test.sh -vi myaction1 -t \"two words\" -a -q --test=\"three wor ds\" myaction2 -- -x\n\
\tResult is:\n\
\t\t- the first common options 'v' and 'i' are parsed and considered by the library,\n\
\t\t- the third common option 'q' is parsed but NOT considered by the library as it is after a custom option,\n\
\t\t- the custom 't' and 'test' options are parsed and considered by this script and their multi-words arguments are red,\n\
\t\t- the custom 'a' option is parsed and considered by this script,\n\
\t\t- the last common option 'x' is NOT parsed at all as it is after '--'.";
SYNOPSIS="$LIB_SYNOPSIS_ACTION"

# for custom options, write an info string about usage
# you can use the common library options string with $COMMON_OPTIONS_INFO
OPTIONS="<bold>-t, --test=ARG</bold>\ttest a short and long option with argument\n\
\t<bold>-a</bold>\t\ta single short option to test options order\n$COMMON_OPTIONS_INFO"

OPTIONS_ALLOWED="t:a${COMMON_OPTIONS_ALLOWED}"
LONG_OPTIONS_ALLOWED="test:,${COMMON_LONG_OPTIONS_ALLOWED}"

echo

echo "short options arguments: '${OPTIONS_ALLOWED}'";
echo "long options arguments: '${LONG_OPTIONS_ALLOWED}'";
echo

echo "received arguments: '$@'";
echo


rearrangeoptions () {
    SCRIPT_OPTS=$(getopt -q -s bash -n "$0" -o "${OPTIONS_ALLOWED}" -l "${LONG_OPTIONS_ALLOWED}" -- "$@")
    export SCRIPT_OPTS
    return 0
}

rearrangeoptions "$@"
eval set -- "$SCRIPT_OPTS";
echo "rearranged arguments: '$@'";
echo

echo "parsing common options";
parsecommonoptions "$@"
echo


OPTIND=1
while getopts ":${OPTIONS_ALLOWED}" OPTION; do
    OPTARG="${OPTARG#=}"
    echo "$OPTION : $OPTARG"
    case $OPTION in
        -)  # for long options with argument, use fct 'getlongoptionarg ( $arg )'
            LONGOPTARG="`getlongoptionarg \"${OPTARG}\"`"
            case $OPTARG in
                test*) _echo " - option 'test': receiving argument \"${LONGOPTARG}\"";;
            esac ;;
    esac
done

echo
libdebug "$*"
exit 0

# Endfile
