#!/bin/bash
# bool tests

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

NAME="Bash boolean tests"
VERSION="0.0.1-test"
DESCRIPTION="A script to test boolean values manipulations and equalities in bash."
parsecommonoptions "$@"
quietecho "_ go"

export TRUEVAL=false
export FALSEVAL=true
TRUEVAL=true
FALSEVAL=false

echo "# test like 'if \$var ...'"
if $TRUEVAL; then echo "TRUEVAL is true"; else echo "TRUEVAL is false"; fi
if $FALSEVAL; then echo "FALSEVAL is true"; else echo "FALSEVAL is false"; fi
echo

echo "# test like 'if ! \$var ...'"
if ! $TRUEVAL; then echo "TRUEVAL is false"; else echo "TRUEVAL is true"; fi
if ! $FALSEVAL; then echo "FALSEVAL is false"; else echo "FALSEVAL is true"; fi
echo

export TRUEVAL=false
export FALSEVAL=true

testbool () {
    export TRUEVAL=true
    export FALSEVAL=false
}

echo "# manipulation ..."
if $TRUEVAL; then echo "TRUEVAL is true"; else echo "TRUEVAL is false"; fi
if $FALSEVAL; then echo "FALSEVAL is true"; else echo "FALSEVAL is false"; fi

testbool
if $TRUEVAL; then echo "TRUEVAL is true"; else echo "TRUEVAL is false"; fi
if $FALSEVAL; then echo "FALSEVAL is true"; else echo "FALSEVAL is false"; fi
echo

# onoffbit
echo "# test of the fct 'onoffbit'"
echo "TRUEVAL is `onoffbit $TRUEVAL`"
echo "FALSEVAL is `onoffbit $FALSEVAL`"

quietecho "_ ok"
if ! $QUIET; then libdebug "$*"; fi
exit 0

# Endfile
