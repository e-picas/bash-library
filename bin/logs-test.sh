#!/bin/bash
# config files

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

#LOGFILE="bashlibtest.log"

NAME="Bash-Lib script test for log messages"
VERSION="0.0.1-test"
DESCRIPTION="A script to test library log infos management ...";
SYNOPSIS="$LIB_SYNOPSIS_ACTION"

# for custom options, write an info string about usage
# you can use the common library options string with $COMMON_OPTIONS_INFO
OPTIONS="\n\
<underline>Available actions:</underline>
\t<bold>read</bold>\t\tread the current log file\n\
\t<bold>write</bold>\t\twrite 10 tests log messages file\n\
\t<bold>throw</bold>\t\tthrows an error to test log error message\n\
\t${COMMON_OPTIONS_INFO}";

parsecomonoptions "$@"
quietecho "_ go"

OPTIND=1
options=$(getscriptoptions "$@")
ACTION=$(getlastargument $options)
if [ ! -z "$ACTION" ]
then
    case $ACTION in
        write)
            if [ ! -n "$LOGFILEPATH" ]; then getlogfilepath; fi
            verecho "Writing 10 test messages in log file '$LOGFILEPATH':"
            for i in {1..10}; do
                log "my test message (item $i)"
                log "my DEBUG test message (item $i)" "debug"
                log "my WARNING test message (item $i)" "warning"
            done
            verecho "_ ok"
            echo
            verecho "New log file content is:"
            readlog
            ;;
        read)
            if [ ! -n "$LOGFILEPATH" ]; then getlogfilepath; fi
            verecho "Reading log file '$LOGFILEPATH':"
            readlog
            ;;
        throw)
            if [ ! -n "$LOGFILEPATH" ]; then getlogfilepath; fi
            error "test throwing error"
            ;;
    esac
else
    usage
fi

quietecho "_ ok"
libdebug "$*"
exit 0

# Endfile
