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

NAME="Bash-Lib script test for configuration files"
VERSION="0.0.1-test"
DESCRIPTION="A script to test library configuration files management ...";
SYNOPSIS="$LIB_SYNOPSIS"

# for custom options, write an info string about usage
# you can use the common library options string with $COMMON_OPTIONS_INFO
OPTIONS="<bold>--check</bold>\t\tread the test config table (default action)\n\
\t<bold>--read</bold>\t\tread the configuration file\n\
\t<bold>--write</bold>\t\twrite the configuration file\n\
\t<bold>--add</bold>\t\tadd a configuration entry\n\
\t<bold>--replace</bold>\treplace a configuration entry\n\
\t${COMMON_OPTIONS_INFO}";

parsecomonoptions "$@"
quietecho "_ go"

filename=testconfig
keys=(one two three)
values=('value one' 'value two' 'value three')
filepath=$(getuserconfigfile $filename)
actiondone=false
OPTIND=1
while getopts "${COMMON_OPTIONS_ARGS}" OPTION; do
	OPTARG="${OPTARG#=}"
	case $OPTION in
		-) case $OPTARG in
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
			esac ;;
	esac
done

if ! $actiondone; then
    verecho "Config table is:"
    _echo "$(buildconfigstring keys[@] values[@])"
fi

quietecho "_ ok"
libdebug "$*"
exit 0

# Endfile
