#!/bin/bash
# global test

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

NAME="Lorem-Ipsum-Test"
VERSION="0.0.1-dev"
DESCRIPTION="A test for 'program' long option usage."

parsecommonoptions "$@"
quietecho "_ go"

_MAX=100
_TESTSTR=""
_TMPFILE=$(gettempfilepath loremipsum-test)

for ((i=0; i<$_MAX; i++)); do
    _TESTSTR="${_TESTSTR}\n${LOREMIPSUM_MULTILINE}\n"
done

if [ "${#SCRIPT_PROGRAMS[@]}" -gt 0 ]; then
    echo "- program(s) requested: '${SCRIPT_PROGRAMS[@]}'"
fi

if $(in_array "less" "${SCRIPT_PROGRAMS[@]}"); then
    verecho "- loading test str in '$_TMPFILE'"
    echo "$_TESTSTR" > "$_TMPFILE"
    verecho "- opening it with 'less -cfre~'"
    cat "$_TMPFILE" | less -cfre~
elif $(in_array "more" "${SCRIPT_PROGRAMS[@]}"); then
    verecho "- loading test str in '$_TMPFILE'"
    echo "$_TESTSTR" > "$_TMPFILE"
    verecho "- opening it with 'more -cf'"
    cat "$_TMPFILE" | more -cf
else
    echo "$_TESTSTR"
fi

quietecho "_ ok"
if ! $QUIET; then libdebug "$*"; fi
exit 0

# Endfile
