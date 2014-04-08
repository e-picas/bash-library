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
OPTIONS="$COMMON_OPTIONS_FULLINFO_MANPAGE"
SYNOPSIS="$COMMON_SYNOPSIS"
SCRIPT_VCS='git'

parse_common_options "$@"
verecho "_ go"


script_long_usage

#simple_error "this is the classic usage error"

verecho "_ ok"
if ! $QUIET; then libdebug "$*"; fi
exit 0

# Endfile
