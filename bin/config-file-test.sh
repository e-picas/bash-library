#!/bin/bash
# config files

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

NAME="Bash-Lib script test for configuration files"
VERSION="0.0.1-test"
DESCRIPTION="A script to test library configuration files management ...";
SYNOPSIS="$LIB_SYNOPSIS_ACTION"

# for custom options, write an info string about usage
# you can use the common library options string with $COMMON_OPTIONS_INFO
OPTIONS="\n\
<underline>Available actions:</underline>\n\
\t<bold>read</bold>\t\tread the configuration file (default action)\n\
\t<bold>write</bold>\t\twrite the configuration file\n\
\t<bold>add</bold>\t\tadd a configuration entry\n\
\t<bold>replace</bold>\t\treplace a configuration entry\n\
\t<bold>get</bold>\t\tget values from the test config table\n\
\t${COMMON_OPTIONS_INFO}";

parsecommonoptions "$@"
quietecho "_ go"

filename=testconfig
keys=(one two three)
values=('value one' 'value two' 'value three')
filepath=$(getuserconfigfile $filename)
actiondone=false

OPTIND=1
options=$(getscriptoptions "$@")
getlastargument
ACTION=$ACTION_ARG
if [ -z "$ACTION" ]; then ACTION="read"; fi
if [ ! -z "$ACTION" ]
then
    case $ACTION in
        read)
            verecho "Reading config file '$filepath':"
            iexec "readconfigfile $filepath"
            verecho "_ ok"
            echo
            verecho "Testing value of config var 'one':"
            echo $one
            echo
            actiondone=true
            verecho "New config file content is:"
            cat $filepath
            ;;
        write)
            verecho "Writing config file '$filepath':"
            iexec "writeconfigfile $filepath keys[@] values[@]"
            verecho "_ ok"
            echo
            actiondone=true
            verecho "New config file content is:"
            cat $filepath
            ;;
        add)
            verecho "Adding new value 'four=value four' in config file '$filepath':"
            iexec "setconfigval $filepath \"four\" \"value four\""
            verecho "_ ok"
            echo
            actiondone=true
            verecho "New config file content is:"
            cat $filepath
            ;;
        replace)
            verecho "Replacing value 'four=new value four' in config file '$filepath':"
            iexec "setconfigval $filepath \"four\" \"new value four\""
            verecho "_ ok"
            echo
            actiondone=true
            verecho "New config file content is:"
            cat $filepath
            ;;
        get)
            verecho "Getting config value 'three' and 'four' from config file '$filepath':"
            iexec "getconfigval $filepath \"three\""
            iexec "getconfigval $filepath \"four\""
            verecho "_ ok"
            echo
            actiondone=true
            verecho "Config file content is:"
            cat $filepath
            ;;
    esac
fi

quietecho "_ ok"
libdebug "$*"
exit 0

# Endfile
