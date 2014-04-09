#!/bin/bash
# dev - use this script as a model for yours

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

NAME="Bash-Lib-dev"
VERSION="x.y.z-dev"
DATE="1970-01-01"
DESCRIPTION="A dev file for tests"
LICENSE="GPL-v3 license"
HOMEPAGE="http://github.com/atelierspierrot/piwi-bash-library/blob/master/bin/dev.sh"
DESCRIPTION_MANPAGE="A dev file for tests ; you can use this script as a model to build your own ..."
DESCRIPTION_USAGE="A simple development file for tests"
OPTIONS_MANPAGE="${COMMON_OPTIONS_FULLINFO_MANPAGE}"
OPTIONS_USAGE="${COMMON_OPTIONS_USAGE}"
SYNOPSIS="${COMMON_SYNOPSIS}"
SYNOPSIS_ERROR="${COMMON_SYNOPSIS}"
SCRIPT_VCS='git'

rearrange_script_options "$@"
[ "${#SCRIPT_OPTS[@]}" -gt 0 ] && set -- "${SCRIPT_OPTS[@]}";
[ "${#SCRIPT_ARGS[@]}" -gt 0 ] && set -- "${SCRIPT_ARGS[@]}";
[ "${#SCRIPT_OPTS[@]}" -gt 0 -a "${#SCRIPT_ARGS[@]}" -gt 0 ] && set -- "${SCRIPT_OPTS[@]}" -- "${SCRIPT_ARGS[@]}";
parse_common_options "$@"

#simple_error "this is the classic usage error"



if ${DEBUG}; then libdebug "$*"; fi
exit 0

# Endfile
