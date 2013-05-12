#!/bin/bash
# bool tests

NAME="Bash boolean tests"

. src/library.sh
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
