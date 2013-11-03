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

NAME="Bash-Lib-Test"
VERSION="0.0.1-dev"
DESCRIPTION="A global test file for the Bash-Library"
USAGE="\n\
This file is the global test script of the library. You can play with options below to modify its behavior.\n\
Each file of the package like 'bin/***-test.sh' is a demo or test for a specific feature.\n\n\
<bold>USAGE</bold>\n\
\t~\$ ${0} -option(s) --longoption(s)\n\n\
<bold>COMMON OPTIONS</bold>\n\
\t${COMMON_OPTIONS_FULLINFO}\n\n\
<bold>LIBRARY</bold>\n\
\t${LIB_DEPEDENCY_INFO}";

rearrangescriptoptions "$@"
[ "${#SCRIPT_OPTS[@]}" -gt 0 ] && set -- "${SCRIPT_OPTS[@]}";
[ "${#SCRIPT_ARGS[@]}" -gt 0 ] && set -- "${SCRIPT_ARGS[@]}";
[ "${#SCRIPT_OPTS[@]}" -gt 0 -a "${#SCRIPT_ARGS[@]}" -gt 0 ] && set -- "${SCRIPT_OPTS[@]}" -- "${SCRIPT_ARGS[@]}";
parsecommonoptions_strict
quietecho "_ go"

# getsysteminfo
echo "## getsysteminfo is: '`getsysteminfo`'"
echo

# getmachinename
echo "## getmachinename is: '`getmachinename`'"
echo

# getscriptpath
echo "## pwd is: '`pwd`'"
echo

# files
echo "## getscriptpath: '`getscriptpath`'"
echo "## dirname: '`getdirname`'"
echo "## basename: '`getbasename`'"
echo "## filename: '`getfilename`'"
echo "## extension: '`getextension`'"
echo

## arrays
declare -a arrayname=(element1 element2 element3)
echo "## tests of fct 'array_search' (indexes are 0 based):"
echo "index of 'element2' in array '${arrayname[@]}' : `array_search element2 \"${arrayname[@]}\"`"
echo 
echo "## tests of fct 'in_array':"
echo "## array is '${LIBCOLORS[@]}'"
echo "- test for 'black' (true):"
if $(in_array "black" "${LIBCOLORS[@]}"); then echo "=> IS in array"; else echo "=> is NOT in array"; fi
echo "- test for 'mlk' (false):"
if $(in_array "mlk" "${LIBCOLORS[@]}"); then echo "=> IS in array"; else echo "=> is NOT in array"; fi
echo 

# strings
teststr="my test string"
echo "## tests of fct 'strlen':"
echo "strlen of test string '$teststr' (14) : `strlen \"$teststr\"`"
echo "strlen of test string '' (0) : `strlen`"
echo 
echo "## strtoupper: `strtoupper \"$teststr\"`"
echo "## strtolower: `strtolower \"$teststr\"`"
echo "## ucfirst: `ucfirst \"$teststr\"`"
echo

# isgitclone
echo "## test of fct 'isgitclone' on current dir:"
if isgitclone; then echo "=> IS git clone"; else echo "=> is NOT git clone"; fi
echo "## test of fct 'isgitclone' on current dir for remote '${LIB_HOME}':"
if $(isgitclone `pwd` "${LIB_HOME}"); then echo "=> IS git clone"; else echo "=> is NOT git clone"; fi
echo "## test of fct 'isgitclone' on current dir for remote 'https://github.com/atelierspierrot/dev-tools':"
if $(isgitclone `pwd` "https://github.com/atelierspierrot/dev-tools"); then echo "=> IS git clone"; else echo "=> is NOT git clone"; fi
echo

# colorize
echo "## tests of fct 'colorize':"
_echo $(colorize " My string in bold black grey" bold green blue)
echo

TESTSTR1="my <green>test text</green> with <bold>tags</bold> and <bgred>sample text</bgred> to test <bgred>some <bold>imbricated</bold> tags</bgred>"
echo "## tests of fct 'parsecolortags':"
echo $TESTSTR1
parsecolortags "$TESTSTR1"
echo

# verecho() usage
verecho "test of verecho() : this must be seen only with option '-v'"

# quietecho() usage
quietecho "test of quietecho() : this must not be written with option '-q'"

# iexec() usage
verecho "test of iexec() : command will be prompted with option '-i'"
iexec "ls -AlGF ."

# info() usage
verecho "test of info() : this will be shown with any option"
info "My test info string"

# warning() usage
verecho "test of warning() : run option '-i' or '-x' to not throw the error"
iexec "warning 'My test warning info'"

# error() usage
verecho "test of error() : run option '-i' or '-x' to not throw the error"
iexec "error 'My test error' 3"
echo "this will not be seen if the error has been thrown as the 'error()' function exits the script"

quietecho "_ ok"
if ! $QUIET; then libdebug "$*"; fi
exit 0

# Endfile
