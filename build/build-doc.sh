#!/bin/bash
# global test

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

NAME="Bash-Lib-Test"
VERSION="0.0.1-dev"
DESCRIPTION="A global test file for the Bash-Library"
USAGE="\n\
This file is the global test script of the library. You can play with options below to modify its behavior.\n\
Each file of the package like 'bin/***-test.sh' is a demo or test for a specific feature.\n\n\
<bold>USAGE</bold>\n\
\t~\$ ${0} -option(s) --longoption(s)\n\n\
<bold>COMMON OPTIONS</bold>\n\
\t${LIB_OPTIONS}\n\n\
<bold>LIBRARY</bold>\n\
\t${LIB_INFO}";

parsecomonoptions "$@"
quietecho "_ go"


i=0
old_IFS=$IFS
IFS=$'\n'
for line in $(cat $LIBFILE); do
    line_str=""
    fct_line=$(echo "$line" | grep -Po "^####.[^#]*$" | sed "s|#### \(.* (.*)\)|\\\t\1|g")
    if [ `strlen $fct_line` != 0 ]; then
        line_str="$fct_line"
    else
        title_line=$(echo "$line" | grep -Po "^####.[^#]*#*$" | sed "s|#### \(.*\) #*|\\\n## \1 (line ${i})|g")
        if [ `strlen $title_line` != 0 ]; then
            line_str="$title_line"
        else
            if $VERBOSE; then
                arg_line=$(echo "$line" | grep -Po "^#@.*$" | sed "s|#@ \(.*\)|\\\t\\\t\1|g")
                if [ `strlen $arg_line` != 0 ]; then
                    line_str="$arg_line"
                fi
            fi
        fi
    fi
    if [ `strlen $line_str` != 0 ]; then _echo "${line_str}"; fi
    i=$(($i+1))
done
IFS=$old_IFS

quietecho "_ ok"
exit 0

while read line; do
    if [ $i -gt $DOCBLOCK ]; then
        sed -n -e "s|$FCT_MASK|\1|p" $line
    fi
    i=$(($i+1))
done < $LIBFILE

quietecho "_ ok"
exit 0

# Endfile
