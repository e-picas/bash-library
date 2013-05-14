#!/bin/bash
#
# Copyleft (c) 2013 Pierre Cassat and contributors
# <www.ateliers-pierrot.fr> - <contact@ateliers-pierrot.fr>
# License GPL-3.0 <http://www.opensource.org/licenses/gpl-3.0.html>
# Sources <https://github.com/atelierspierrot/bash-library>
# 
# bin/library.sh
# 

#### BASH SETTINGS #####################################################################

#set -e

#### SCRIPT SETTINGS #####################################################################

declare -rx LIB_VERSION="0.0.1"
declare -rx LIB_NAME="Bash shell library"
declare -rx LIB_AUTHOR="Les Ateliers Pierrot"
declare -rx LIB_LICENSE="GPL-3.0"
declare -rx LIB_PACKAGE="atelierspierrot/bash-library"
declare -rx LIB_HOME="https://github.com/atelierspierrot/bash-library"

#### GLOBAL INFOS #####################################################################

declare -rx COMMON_OPTS_INFO="\t<bold>-h, --help</bold>\tshow this information message
\t<bold>-v, --verbose</bold>\tincrease script verbosity
\t<bold>-q, --quiet</bold>\tdecrease script verbosity, nothing will be written unless errors
\t<bold>-f, --force</bold>\tforce some commands to not prompt confirmation
\t<bold>-i, --interactive</bold>\task for confirmation before any action
\t<bold>-x, --debug</bold>\tsee commands to run but not run them actually"

declare -rx OPTS_INFO="You can group short options like '<lightgrey>-xc</lightgrey>', set an option argument like '<lightgrey>-d(=)value</lightgrey>'
or '<lightgrey>--long=value</lightgrey>' and use '<lightgrey>--</lightgrey>' to explicitly specify the end of the script options."

declare -rx USAGE_INFO="~\$ <bold>${0}</bold> -[<underline>OPTION</underline> [=<underline>VALUE</underline>]] <underline>ARGUMENT</underline> --"


#### COMMON OPTIONS #############################################################################

declare -x LASTARG=""
declare -x INTERACTIVE=false
declare -x QUIET=false
declare -x VERBOSE=false
declare -x FORCED=false
declare -x DEBUG=false
declare -rx COMMONOPTS="hfiqvx-:"
declare -rx USEROS="$(uname)"


#### LOREM IPSUM #############################################################################

declare -rx LOREMIPSUM="At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae. Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat."
declare -rx LOREMIPSUMSHORT="Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."

#### COLORS #############################################################################

### gettextformattag ( code )
gettextformattag () {
    case $USEROS in
        Linux|FreeBSD|OpenBSD|SunOS) echo "\033[${1}m";;
        *) echo "\033[${1}m";;
    esac
    return 0
}

#### terminal colors
declare -ra libcolors=(default black red green yellow blue magenta cyan grey white lightred lightgreen lightyellow lightblue lightmagenta lightcyan lightgrey)
declare -rx libcolors_codes_foreground=(39 30 31 32 33 34 35 36 90 97 91 92 93 94 95 96 37)
declare -rx libcolors_codes_background=(49 40 41 42 43 44 45 46 100 107 101 102 103 104 105 106 47)

### getcolorcode ( name , background=false )
getcolorcode () {
    if `in_array $1 ${libcolors[@]}`; then
        if [ ! -z $2 ]
            then echo "${libcolors_codes_background[`array_search $1 ${libcolors[@]}`]}"
            else echo "${libcolors_codes_foreground[`array_search $1 ${libcolors[@]}`]}"
        fi
    else return 1
    fi
}

### getcolortag ( name , background=false )
getcolortag () {
    if `in_array $1 ${libcolors[@]}`; then
        if [ ! -z $2 ]
            then echo $(gettextformattag "${libcolors_codes_background[`array_search $1 ${libcolors[@]}`]}")
            else echo $(gettextformattag "${libcolors_codes_foreground[`array_search $1 ${libcolors[@]}`]}")
        fi
    else return 1
    fi
}

#### terminal text options
declare -ra libtextoptions=(normal bold small underline blink reverse hidden)
declare -rx libtextoptions_codes=(0 1 2 4 5 7 8)

### gettextoptioncode ( name )
gettextoptioncode () {
    if `in_array $1 ${libtextoptions[@]}`
        then echo "${libtextoptions_codes[`array_search $1 ${libtextoptions[@]}`]}"
        else return 1
    fi
}

### gettextoptiontag ( name )
gettextoptiontag () {
    if `in_array $1 ${libtextoptions[@]}`
        then echo $(gettextformattag "${libtextoptions_codes[`array_search $1 ${libtextoptions[@]}`]}")
        else return 1
    fi
}

### gettextoptiontagclose ( name )
gettextoptiontagclose () {
    if `in_array $1 ${libtextoptions[@]}`
        then echo $(gettextformattag "2${libtextoptions_codes[`array_search $1 ${libtextoptions[@]}`]}")
        else return 1
    fi
}

#### colorize ( string , text option , foreground , background )
# echo a colorized string
colorize () {
    local textopt
    if [ ! -z $2 ]; then textopt=`gettextoptioncode "$2"`; fi
    local fgopt
    if [ ! -z $3 ]; then fgopt=`getcolorcode "$3"`; fi
    local bgopt
    if [ ! -z $4 ]; then bgopt=`getcolorcode "$4" true`; fi
    local add=""
    if [ ! -z $textopt ]; then add="${textopt}"; fi
    if [ ! -z $fgopt ]; then
        if [ `strlen "$add"` != 0 ]; then add="${add};${fgopt}"; else add="${fgopt}"; fi
    fi
    if [ ! -z $bgopt ]; then
        if [ `strlen "$add"` != 0 ]; then add="${add};${bgopt}"; else add="${bgopt}"; fi
    fi
    opentag=$(gettextformattag "${add}")
    closetag=$(gettextformattag "$(gettextoptioncode normal)")
    if [ `strlen $add` == 0 ]
        then echo "${1}"
        else echo "${opentag}${1}${closetag}"
    fi
}

#### parsecolortags ( string with <bold>tags</bold> )
# parse in-text tags like:
#     ... <bold>my text</bold> ...
#     ... <red>my text</red> ...
#     ... <bgred>my text</bgred> ...
parsecolortags () {
    transformed=""
    while read -r line; do
        doneopts=()
        transformedline="$line"
        for opt in $(echo "$line" | grep -Po '<.[^/>]*>' | sed "s|^.*<\(.[^>]*\)>.*\$|\1|g"); do
            opt="${opt/\//}"
            if `in_array "$opt" ${doneopts[@]}`; then continue; fi
            doneopts+=($opt)
            if `in_array $opt ${libtextoptions[@]}`; then
                code=$(gettextoptioncode $opt)
                tag=$(printf '\%s' "$(gettextoptiontag $opt)")
                normaltag=$(printf '\%s' "$(gettextoptiontagclose $opt)")
            elif `in_array $opt ${libcolors[@]}`; then
                code=$(getcolorcode $opt)
                tag=$(printf '\%s' "$(getcolortag $opt)")
                normaltag=$(printf '\%s' "$(getcolortag default)")
            else
                code=$(getcolorcode ${opt/bg/} true)
                tag=$(printf '\%s' "$(getcolortag ${opt/bg/} true)")
                normaltag=$(printf '\%s' "$(getcolortag default true)")
            fi
            if [ ! -z $tag ]; then
                strsubstituted=$(echo "$transformedline" | sed -r "s|<${opt}>|${tag}|g;s|</${opt}>|${normaltag}|g");
                if [ ! -z "$strsubstituted" ]; then transformedline="${strsubstituted}"; fi
            fi
        done
        if [ `strlen "$transformed"` != 0 ]; then transformed="${transformed}\n"; fi
        transformed="${transformed}${transformedline}"
    done <<< "$1"
    echo "$transformed"
    return 0
}

#### ARRAY #############################################################################

#### array_search ( item , $array[@] )
# returns the index of an array item
array_search () {
    local i=0 search=$1; shift
    while [ $search != $1 ]
    do ((i++)); shift
        [ -z "$1" ] && { i=0; break; }
    done
    [ ! $i = 0 ] && echo $i && return 0
    return 1
}

#### in_array ( item , $array[@] )
# returns 0 if item is found in array
in_array () {
  needle=$1; shift
  for item; do
    [[ "$needle" = $item ]] && return 0
  done
  return 1
}

#### STRING #############################################################################

#### strlen ( string )
# returns the number of characters in string
strlen () {
    echo ${#1}; return 0;
}

#### getextension ( filename )
# retrieve a file extension
getextension () {
	if test "x$1" != 'x'; then echo "${1##*.}"; fi
	return 0
}

#### strtoupper ( text )
strtoupper () {
	echo "$1" | tr '[:lower:]' '[:upper:]'
	return 0
}

#### strtolower ( text )
strtolower () {
	echo "$1" | tr '[:upper:]' '[:lower:]'
	return 0
}

#### ucfirst ( text )
ucfirst () {
	echo "`strtoupper ${1:0:1}`${1:1:${#1}}"
	return 0
}

#### UTILS #############################################################################

#### _echo ( string )
# echo the string with the true 'echo' command
# use this for colorization
_echo () {
    tput sgr0
    case $USEROS in
        Linux|FreeBSD|OpenBSD|SunOS) $(which echo) -e "$*" >&2;;
        *) echo "$*" >&2;;
    esac
    return 0
}

#### verbose_echo ( string )
# echo the string if "verbose" is "on"
verbose_echo () {
    if $VERBOSE; then _echo "$*"; fi; return 0;
}
#### verecho ( string )
verecho () { verbose_echo "$*"; }

#### quiet_echo ( string )
# echo the string if "quiet" is "off"
quiet_echo () {
    if $QUIET; then _echo "$*"; fi; return 0;
}
#### quietecho ( string )
quietecho () { quiet_echo "$*"; }

#### interactive_exec ( command , debug_exec = true )
# execute the command after user confirmation if "interactive" is "on"
interactive_exec () {
    local DEBEXECUTION=${2:-true}
    if $INTERACTIVE; then
        prompt "Run command: \"$1\"" "y" "Y/n"
        while true; do
            case $USERRESPONSE in
                [yY]* ) break;;
                * ) _echo "_ no"; return 0; break;;
            esac
        done
    fi
    if $DEBEXECUTION; then debug_exec "$1"; else eval $1; fi
    return 0
}
#### iexec ( command , debug_exec = true )
iexec () { interactive_exec "$*"; }

#### debug_exec ( command )
# execute the command if "debug" is "off", just write it on screen otherwise
debug_exec () {
    if $DEBUG; then
        _echo "$(colorize 'debug >>' bold) $1"
    else
        eval $1
    fi
    return 0
}
#### debexec ( command )
debexec () { debug_exec "$*"; }

#### prompt ( string , default = y , options = Y/n )
# prompt user a string proposing different response options and selecting a default one
# final user fill is loaded in $USERRESPONSE
prompt () {
    local add=""
    if test "x${3}" != 'x'; then add="[${3}] "; fi
    read -p "?  >> ${1} ? ${add}" answer
    export USERRESPONSE=${answer:-$2}
    return 0
}

#### info ( string, bold = true )
# writes the string on screen and return
info () {
    local USEBOLD=${2:-true}
    if $USEBOLD; then
        _echo $(colorize "   >> $1" bold blue)
    else
        _echo "$(colorize '   >>' bold) $1"
    fi
    return 0
}

#### warning ( string , funcname , line )
# writes the error string on screen and return
warning () {
	local TMPSTR="
<bold><magenta>!! >> ${1:-unknown warning} </magenta></bold>
\tat <green>${3:-${FUNCNAME[1]}}</green> line <green>${4:-${BASH_LINENO[0]}}</green>
"
    _echo $(parsecolortags "$TMPSTR")
    return 0
}

#### error ( string , status = 1 , funcname , line )
# writes the error string on screen and then exit with an error status, default is 1
error () {
	local TMPSTR="
<bold><red>!! >> ${1:-unknown error} </red></bold>
\tat <green>${3:-${FUNCNAME[1]}}</green> line <green>${4:-${BASH_LINENO[0]}}</green>
\tto get help, try option '<lightgrey>-h</lightgrey>'
"
    _echo $(parsecolortags "$TMPSTR")
    exit ${2:-1}
}

#### VARIOUS #####################################################################

#### isgitclone ( path )
# check if a path, or `pwd`, is a git clone
isgitclone () {
    local curpath=$(pwd)
    local gitpath="${1:-${curpath}}/.git"
    if [ -d "$gitpath" ]; then return 0; else return 1; fi;
}

#### OPTIONS #############################################################################

#### parsecomomnoptions ( "$@" )
# parse common script options as described in $COMMON_OPTS_INFO
# this will stop options treatment at '--'
parsecomomnoptions () {
    local oldoptind=$OPTIND
    local options=()
    local eoo=false
    while [[ $1 ]]; do
        if ! $eoo; then
            case "$1" in
                --) eoo=true; shift;;
                *) options+=("$1"); shift;;
            esac
        else shift;
        fi
    done
    while getopts "t:${COMMONOPTS}" OPTION "${options[@]}"; do
        OPTARG="${OPTARG#=}"
        case $OPTION in
            h) usage; exit 0;;
            i) export INTERACTIVE=true; export QUIET=false;;
            v) export VERBOSE=true; export QUIET=false;;
            f) export FORCED=true;;
            x) export DEBUG=true; quietecho "  -  debug option enabled: commands shown as 'debug >> cmd' are not executed";;
            q) export VERBOSE=false; export INTERACTIVE=false; export QUIET=true;;
            t) _echo " - option 't': receiveing argument \"${OPTARG}\"";;
            -)
                LONGOPTARG="${OPTARG#*=}"
                case $OPTARG in
                    help) usage; exit 0;;
                    interactive) export INTERACTIVE=true; export QUIET=false;;
                    verbose) export VERBOSE=true; export QUIET=false;;
                    force) export FORCED=true;;
                    debug) export DEBUG=true; quietecho "  -  debug option enabled: commands shown as 'debug >> cmd' are not executed";;
                    quiet) export VERBOSE=false; export INTERACTIVE=false; export QUIET=true;;
                    test*) _echo " - option 'test': receiveing argument \"${LONGOPTARG}\"";;
                    ?) rien=rien;;
                esac ;;
            ?) rien=rien;;
        esac
        shift
    done
    export OPTIND=$oldoptind
    export LASTARG="${options[@]: -1}"
    return 0
}

#### INFOS #####################################################################

#### getscriptpath ( script=$0 )
# get the full real path of a script (passed as argument) or from current executed script
getscriptpath () {
	local arg="${1:-${0}}"
	local relpath=$(dirname "$arg")
	local abspath=$(cd "$relpath" && pwd)
	if [ -z "$abspath" ]; then return 1; fi
	echo "$abspath"
	return 0
}

#### version ()
version () {
    if isgitclone; then
        local gitcmd=$(which git)
        if [ "x$gitcmd" != 'x' ]; then
            echo "`git rev-parse --abbrev-ref HEAD` `git rev-parse HEAD`"
        fi
    else
		if [ "x$VERSION" != 'x' ]; then echo "${VERSION}"; fi
    fi
	return 0
}

#### usage ()
# this function must echo the usage information USAGE (with option "-h")
usage () {
    if [ ! "x${USAGE}" = 'x' ]; then
        echo "$USAGE" >&2
    else
        local TMP_USAGE="
<bold>NAME</bold>
\t<bold>${NAME:-?} - v. [${VERSION:-?}]</bold>

<bold>USAGE</bold>
\t${USAGE_INFO}

<bold>DESCRIPTION</bold>
${COMMON_OPTS_INFO}

${OPTS_INFO}

<bold>DEPENDENCIES</bold>
\tThis script is based on the <bold>${LIB_NAME}</bold>.
\tPackage [<lightgrey>${LIB_PACKAGE}</lightgrey>] version [<lightgrey>${LIB_VERSION}</lightgrey>].
\tLicensed under ${LIB_LICENSE} - Copyleft (c) ${LIB_AUTHOR} - Some rights reserved.
\tFor sources & bugs, see <${LIB_HOME}>.
"
        _echo $(parsecolortags "$TMP_USAGE")
    fi
    return 0;
}

#### title ( lib=false )
# this function must echo an information about script NAME and VERSION
# setting `$lib` on true will add the library infos
title () {
    local TITLE="${NAME}"
    if [ "x$VERSION" != 'x' ]; then TITLE="${TITLE} - v. [${VERSION}]"; fi    
    _echo $(colorize "##  ${TITLE}  ##" bold)
    if isgitclone; then
        local gitcmd=$(which git)
        if [ "x$gitcmd" != 'x' ]; then
            _echo "[`git rev-parse --abbrev-ref HEAD` `git rev-parse HEAD`]"
        fi
    fi
    if [ ! -z "$1" ]; then
        _echo "[using `libtitle`]"        
    fi
    return 0
}

#### libtitle ()
# this function must echo an information about script LIB_NAME and LIB_VERSION
libtitle () {
    echo "${LIB_NAME} - v. ${LIB_VERSION}"
    return 0
}

#### scriptdebug ()
# see all common options flags values
scriptdebug () {
    _echo "---- DEBUG -------------------------------------------------------------"
    _echo " $0 $*"
    _echo "------------------------------------------------------------------------"
    _echo "- `colorize USEROS bold` is `colorize ${USEROS} bold green`"
    if $VERBOSE
        then _echo "- `colorize VERBOSE bold` mode is `colorize on bold green`"
        else _echo "- `colorize VERBOSE bold` mode is `colorize off bold green`"
    fi
    if $INTERACTIVE
        then _echo "- `colorize INTERACTIVE bold` mode is `colorize on bold green`"
        else _echo "- `colorize INTERACTIVE bold` mode is `colorize off bold green`"
    fi
    if $FORCED
        then _echo "- `colorize FORCED bold` mode is `colorize on bold green`"
        else _echo "- `colorize FORCED bold` mode is `colorize off bold green`"
    fi
    if $DEBUG
        then _echo "- `colorize DEBUG bold` mode is `colorize on bold green`"
        else _echo "- `colorize DEBUG bold` mode is `colorize off bold green`"
    fi
    if $QUIET
        then _echo "- `colorize QUIET bold` mode is `colorize on bold green`"
        else _echo "- `colorize QUIET bold` mode is `colorize off bold green`"
    fi
    _echo "- `colorize LASTARG bold` is set on `colorize \"${LASTARG:--}\" bold green`"
    _echo "------------------------------------------------------------------------"
    _echo " status: $? - pid: $$ - user: `whoami`"
#    _echo " pwd: `pwd`"
    _echo " `uname -osr`"
    _echo "------------------------------------------------------------------------"
    return 0
}

# Endfile
