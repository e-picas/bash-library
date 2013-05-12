#!/bin/bash
#
# Copyleft (c) 2013 Pierre Cassat and contributors
# <www.ateliers-pierrot.fr> - <contact@ateliers-pierrot.fr>
# License GPL-3.0 <http://www.opensource.org/licenses/gpl-3.0.html>
# Sources <https://github.com/atelierspierrot/atelierspierrot>
# 
#     ~$ sh bin/test.sh -h
# 

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

. src/library.sh
parsecomomnoptions "$@"
quietecho "_ go"

# getindex
declare -a arrayname=(element1 element2 element3)
echo "index of 'element2' in array '${arrayname[@]}' : `getindex element2 \"${arrayname[@]}\"`"
echo 

# inarray
echo "tests of fct 'inarray':"
if `inarray black ${libcolors[@]}`; then echo "- black is in array"; else echo "- black is NOT in array"; fi
if `inarray mlk ${libcolors[@]}`; then echo "- mlk is in array"; else echo "- mlk is NOT in array"; fi
echo 

# strlen
teststr="my test string"
echo "strlen of test string '$teststr' : `strlen \"$teststr\"`"
echo 

# color codes
echo "color code for 'black': `getcolorcode black`"
echo "color code for 'black' background: `getcolorcode black true`"
echo "text option code for 'bold': `gettextoptioncode bold`"
echo "text option code for 'normal': `gettextoptioncode normal`"
echo "color code for 'abcd': `getcolorcode abcd`"
echo 

# colorize
colorize "my string to colorize" bold green red
echo $(colorize " My string in normal red " normal red)
echo $(colorize " My string in bold grey black" bold grey black)
echo $(colorize " My string in bold black grey" bold black grey)
echo $(colorize " My string in underline red green" underline red green)
echo $(colorize " My string in blink yellow cyan" blink yellow cyan)
echo $(colorize " My string in reverse magenta blue" reverse magenta blue)
echo $(colorize " My string in bold" bold)
echo

# isgitclone
echo "test of fct 'isgitclone' on current dir:"
if isgitclone; then echo "=> is git clone"; else echo "=> is NOT git clone"; fi
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
echo $TESTSTR1
parsecolor "$TESTSTR1"
echo
echo $TESTSTR2
parsecolor "$TESTSTR2"
echo
echo $TESTSTR3
parsecolor "$TESTSTR3"
echo
echo $TESTSTR4
parsecolor "$TESTSTR4"
echo
echo $TESTSTR5
parsecolor "$TESTSTR5"
echo
echo $TESTSTR6
parsecolor "$TESTSTR6"
echo
echo "$TESTSTR7"
parsecolor "$TESTSTR7"

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
