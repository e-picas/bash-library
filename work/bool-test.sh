#!/bin/bash
# bool tests

######## Inclusion of the lib
libfile="`dirname $0`/../src/library.sh"
if [ -f "$libfile" ]; then source "$libfile"; else
    padder=$(printf '%0.1s' "#"{1..1000})
    printf "\n### %*.*s\n    %s\n    %s\n%*.*s\n\n" 0 $(($(tput cols)-4)) "ERROR! $padder" \
        "Unable to find required library file '$libfile'!" "Sent in '$0' by '`whoami`' - pwd is '`pwd`'" \
        0 $(tput cols) "$padder";
    exit 1
fi
######## !Inclusion of the lib

NAME="Bash boolean tests"
parsecomomnoptions "$@"
quietecho "_ go"

export YOTRUE=false
export YOFALSE=true
YOTRUE=true
YOFALSE=false

if $YOTRUE; then echo "YOTRUE is true"; else echo "YOTRUE is false"; fi
if $YOFALSE; then echo "YOFALSE is true"; else echo "YOFALSE is false"; fi

if ! $YOTRUE; then echo "YOTRUE is false"; else echo "YOTRUE is true"; fi
if ! $YOFALSE; then echo "YOFALSE is false"; else echo "YOFALSE is true"; fi

export YOTRUE=false
export YOFALSE=true

testbool () {
    export YOTRUE=true
    export YOFALSE=false
}

if $YOTRUE; then echo "YOTRUE is true"; else echo "YOTRUE is false"; fi
if $YOFALSE; then echo "YOFALSE is true"; else echo "YOFALSE is false"; fi

testbool
if $YOTRUE; then echo "YOTRUE is true"; else echo "YOTRUE is false"; fi
if $YOFALSE; then echo "YOFALSE is true"; else echo "YOFALSE is false"; fi

quietecho "_ ok"
scriptdebug
exit 0

# Endfile
