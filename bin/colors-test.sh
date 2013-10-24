#!/bin/bash
# colors test

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

NAME="Bash-Lib colors test"
VERSION="0.0.1-dev"
DESCRIPTION="A script to test colorized functions of the Bash-Library"

parsecommonoptions "$@"
quietecho "_ go"

# color codes
echo 
echo "## tests of fct 'getcolorcode':"
echo "color code for 'black': `getcolorcode black`"
echo "color code for 'black' background: `getcolorcode black true`"
echo "color code for 'abcd': `getcolorcode abcd`"
echo 
echo "# tests of fct 'gettextoptioncode':"
echo "text option code for 'bold': `gettextoptioncode bold`"
echo "text option code for 'normal': `gettextoptioncode normal`"
echo "text options code for 'abcd': `gettextoptioncode abcd`"
echo 

# colorize
echo "## tests of fct 'colorize':"
_echo $(colorize "my string to colorize" bold green red)
_echo $(colorize " My string in normal red " normal red)
_echo $(colorize " My string in bold grey black" bold grey black)
_echo $(colorize " My string in bold black grey" bold black grey)
_echo $(colorize " My string in underline red green" underline red green)
_echo $(colorize " My string in blink yellow cyan" blink yellow cyan)
_echo $(colorize " My string in reverse magenta blue" reverse magenta blue)
_echo $(colorize " My string in bold" bold)
_echo

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

echo
echo "## tests of 'COLOR_*' variables:"
TESTSTR_VAR="<%s>my test text for constant %s</%s>"
for col in "${LIB_COLORS[@]}"; do
    eval "colcode=\$$col"
    parsecolortags "`printf \"$TESTSTR_VAR\" \"${colcode}\" \"${col}\" \"${colcode}\"`"
done

TESTSTR8="<bold>some bold text</bold>"
TESTSTR9="<bold>some bold text</bold>\n\
and <green>multiline</green>";
echo
echo "## test of the 'stripcolors' method"
echo 
PARSEDTESTSTR8=$(parsecolortags "$TESTSTR8")
_echo "colorized: ${PARSEDTESTSTR8}"
stripcolors "stripped: ${PARSEDTESTSTR8}"
echo 
PARSEDTESTSTR9=$(parsecolortags "$TESTSTR9")
_echo "colorized: ${PARSEDTESTSTR9}"
stripcolors "stripped: ${PARSEDTESTSTR9}"

quietecho "_ ok"
libdebug "$*"
exit 0

# Endfile
