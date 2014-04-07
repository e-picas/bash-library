#!/bin/bash
# dev

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

NAME="Bash-Lib-dev"
VERSION="x.y.z-dev"
DESCRIPTION="A dev file for tests"
OPTIONS="$COMMON_OPTIONS_FULLINFO"
SYNOPSIS="$LIB_SYNOPSIS"
SCRIPT_VCS='git'

parse_common_options "$@"
verecho "_ go"



#### long_usage ( synopsis = SYNOPSIS_ERROR )
## writes a synopsis usage info
long_usage () {
    local ERRSYNOPSIS=""
    if [ ! -z "$1" ]; then
        if [ "$1" == 'lib' ]; then
            ERRSYNOPSIS=$(_echo "$LIB_SYNOPSIS")
        elif [ "$1" == 'action' ]; then
            ERRSYNOPSIS=$(_echo "$LIB_SYNOPSIS_ACTION")
        else
            ERRSYNOPSIS=$(_echo "$1")
        fi
    elif [ -n "$SYNOPSIS_ERROR" ]; then
        ERRSYNOPSIS=$(_echo "$SYNOPSIS_ERROR")
    else
        ERRSYNOPSIS=$(_echo "$LIB_SYNOPSIS_ERROR")
    fi
    printf "`parse_color_tags \"<bold>usage:</bold> %s\"`" "$ERRSYNOPSIS";
    echo
    return 0
}

declare -rx LIB_COPYRIGHT_BIS="This script is based on the ${LIB_NAME} <${LIB_HOME}>\n${LIB_COPYRIGHT_TYPE} - Some rights reserved.";

##@ COMMON_OPTIONS_LIST : information string about common script options
declare -rx COMMON_OPTIONS_LIST_BIS="\n\
\t-h, --help\t\tshow this information message \n\
\t-v, --verbose\t\tincrease script verbosity \n\
\t-q, --quiet\t\tdecrease script verbosity, nothing will be written unless errors \n\
\t-f, --force\t\tforce some commands to not prompt confirmation \n\
\t-i, --interactive\task for confirmation before any action \n\
\t-x, --debug\t\tenable debug mode \n\
\t-V, --version\t\tsee the script version when available\n\
\t\t\t\tuse option '-q' to get the version number only\n\
\t-d, --working-dir=PATH\tredefine the working directory (default is 'pwd' - 'PATH' must exist)\n\
\t-l, --log=FILENAME\tdefine the log filename to use (default is '${LIB_LOGFILE}')\n\
\t--usage\t\t\tshow quick usage information \n\
\t--man\t\t\tsee the current script manpage if available \n\
\t--dry-run\t\tsee commands to run but not run them actually \n\
\t--libvers\t\tsee the library version";



    printf "`parse_color_tags \"%s \n\n<bold>usage:</bold> %s \n%s \n\n%s \"`" \
		"$(script_title)" "$(_echo ${LIB_SYNOPSIS_ERROR})" "$(_echo ${COMMON_OPTIONS_LIST_BIS})" "$(_echo ${LIB_COPYRIGHT_BIS})";
    echo



#simple_error "this is the classic usage error"

verecho "_ ok"
if ! $QUIET; then libdebug "$*"; fi
exit 0

# Endfile
