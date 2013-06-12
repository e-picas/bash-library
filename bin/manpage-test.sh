#!/bin/bash
# manpage

######## Inclusion of the lib
LIBFILE="`dirname $0`/../src/bash-library.sh"
if [ -f "$LIBFILE" ]; then source "$LIBFILE"; else
    PADDER=$(printf '%0.1s' "#"{1..1000})
    printf "\n### %*.*s\n    %s\n    %s\n%*.*s\n\n" 0 $(($(tput cols)-4)) "ERROR! $PADDER" \
        "Unable to find required library file '$LIBFILE'!" \
        "Sent in '$0' line '${LINENO}' by '`whoami`' - pwd is '`pwd`'" \
        0 $(tput cols) "$PADDER";
    exit 1
fi
######## !Inclusion of the lib

NAME="Bash-Lib script manpage test"
VERSION="0.0.1-test"
DESCRIPTION="A script to test library automatic manpages ...\n\
\tTo test it, run:\n\
\t\t~\$ path/to/manpage-test.sh\n\
\tResult is the default script manpage using in-script variables ${MANPAGE_INFOS[@]}.\n\
\tThen run:\n\
\t\t~\$ path/to/manpage-test.sh --testusage\n\
\tResult is a simple custom manpage using in-script variable USAGE.\n\
\tThen run:\n\
\t\t~\$ path/to/manpage-test.sh --library\n\
\tResult is the default library manpage.\n\n\
You can use option '-v' to add the DEPENDENCIES section of the default manpage.";
SYNOPSIS="$LIB_SYNOPSIS"

# for custom options, write an info string about usage
# you can use the common library options string with $COMMON_OPTIONS_INFO
OPTIONS="<bold>--testusage</bold>\tget a sample USAGE manpage\n\
\t<bold>--default</bold>\t\tthe default script manpage (this is the default action)\n\
\t<bold>--library</bold>\t\tthe library manpage";

parsecomonoptions "$@"
quietecho "_ go"

if ! $VERBOSE; then 
    MANPAGE_NODEPEDENCY=true
fi

actiondone=false
OPTIND=1
while getopts "${COMMON_OPTIONS_ARGS}" OPTION; do
    OPTARG="${OPTARG#=}"
    case $OPTION in
        -) case $OPTARG in
            library)
                library_usage
                actiondone=true
                ;;
            testusage)
                USAGE="\n\
This is a simple test of in-script full 'USAGE' custom string (so automatic manpage construction is avoid).\n\n\
<bold>USAGE</bold>\n\
\t~\$ ${0} -option(s) --longoption(s)";
                usage
                actiondone=true
                ;;
            esac ;;
        ?) echo " - unknown option '$OPTION'";;
    esac
done

if ! $actiondone; then
    usage
fi

quietecho "_ ok"
#libdebug "$*"
exit 0

# Endfile
