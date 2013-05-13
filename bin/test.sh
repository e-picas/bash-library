#!/bin/bash
#
# Copyleft (c) 2013 Pierre Cassat and contributors
# <www.ateliers-pierrot.fr> - <contact@ateliers-pierrot.fr>
# License GPL-3.0 <http://www.opensource.org/licenses/gpl-3.0.html>
# Sources <https://github.com/atelierspierrot/atelierspierrot>
# 
#     ~$ sh bin/test.sh -h
# 

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

NAME="Test file for the Shell-Library"
SDUSAGE="
Usage:
    ~\$ sh ${0} -[options [=value]] action

Common options:
    -h|--help             Help: show this information message
    -v|--verbose          Verbose: increase script verbosity
    -q|--quiet            Quiet: decrease script verbosity, nothing will be written unless errors
    -f|--force            Force: force some commands to not prompt confirmation
    -i|--interactive      Interactive: ask for confirmation before any action
    -x|--debug            Debug: see commands to run but not run them actually

You can group options like '-xc', set an option argument like '-d(=)argument'
and use '--' to explicitly specify the end of the script options.

"

parsecomomnoptions "$@"
quietecho "_ go"

# array_search
declare -a arrayname=(element1 element2 element3)
echo "## tests of fct 'array_search':"
echo "index of 'element2' in array '${arrayname[@]}' : `array_search element2 \"${arrayname[@]}\"`"
echo 

# in_array
echo "## tests of fct 'in_array':"
if `in_array black ${libcolors[@]}`; then echo "- black is in array"; else echo "- black is NOT in array"; fi
if `in_array mlk ${libcolors[@]}`; then echo "- mlk is in array"; else echo "- mlk is NOT in array"; fi
echo 

# strlen
teststr="my test string"
echo "## tests of fct 'strlen':"
echo "strlen of test string '$teststr' : `strlen \"$teststr\"`"
echo 

# isgitclone
echo "## test of fct 'isgitclone' on current dir:"
if isgitclone; then echo "=> is git clone"; else echo "=> is NOT git clone"; fi
echo

# color codes
echo "## tests of fct 'getcolorcode':"
echo "color code for 'black': `getcolorcode black`"
echo "color code for 'black' background: `getcolorcode black true`"
echo "color code for 'abcd': `getcolorcode abcd`"
echo "tests of fct 'gettextoptioncode':"
echo "text option code for 'bold': `gettextoptioncode bold`"
echo "text option code for 'normal': `gettextoptioncode normal`"
echo "text options code for 'abcd': `gettextoptioncode abcd`"
echo 

# colorize
echo "## tests of fct 'colorize':"
colorize "my string to colorize" bold green red
echo $(colorize " My string in normal red " normal red)
echo $(colorize " My string in bold grey black" bold grey black)
echo $(colorize " My string in bold black grey" bold black grey)
echo $(colorize " My string in underline red green" underline red green)
echo $(colorize " My string in blink yellow cyan" blink yellow cyan)
echo $(colorize " My string in reverse magenta blue" reverse magenta blue)
echo $(colorize " My string in bold" bold)
echo

TESTSTR1="my <green>test text</green> with <bold>tags</bold> and <bgred>sample text</bgred> to test <bgred>some <bold>imbricated</bold> tags</bgred>"
TESTSTR2="my <green>test text</green> to test"
TESTSTR3="my <bold>tags</bold> to test"
TESTSTR4="my <bgred>sample text</bgred> to test"
TESTSTR5="my test with <bgred>some <bold>imbricated</bold> tags</bgred> to test"
TESTSTR6="my test text with tags and sample text to test some imbricated tags"
TESTSTR7="
my <green>test text</green> with <bold>tags</bold> and <bgred>sample text</bgred>
with multi-line to test <bgred>some</bgred> <bold>tags</bold>
"
echo "## tests of fct 'parsecolortags':"
echo $TESTSTR1
parsecolortags "$TESTSTR1"
echo
echo $TESTSTR2
parsecolortags "$TESTSTR2"
echo
echo $TESTSTR3
parsecolortags "$TESTSTR3"
echo
echo $TESTSTR4
parsecolortags "$TESTSTR4"
echo
echo $TESTSTR5
parsecolortags "$TESTSTR5"
echo
echo $TESTSTR6
parsecolortags "$TESTSTR6"
echo
echo "$TESTSTR7"
parsecolortags "$TESTSTR7"

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
verecho "test of warning() : run option '-i' to not throw the error"
iexec "warning 'My test warning info'"

# error() usage
verecho "test of error() : run option '-i' to not throw the error"
iexec "error 'My test error' 3"
echo "this will not be seen if the error has been thrown as the 'error()' function exits the script"

quietecho "_ ok"
scriptdebug
exit 0

# Endfile
