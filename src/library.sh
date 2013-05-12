#!/bin/bash
#
# Copyleft (c) 2013 Pierre Cassat and contributors
# <www.ateliers-pierrot.fr> - <contact@ateliers-pierrot.fr>
# License GPL-3.0 <http://www.opensource.org/licenses/gpl-3.0.html>
# Sources <https://github.com/atelierspierrot/atelierspierrot>
# 
# bin/library.sh
# 

#### SCRIPT SETTINGS #####################################################################

declare -rx LIB_VERSION="0.0.1"
declare -rx LIB_NAME="Shell library of Les Ateliers"
declare -rx LIB_AUTHOR="Les Ateliers Pierrot"
declare -rx COMMON_OPTS_INFO="
    -h|--help             show this information message
    -v|--verbose          increase script verbosity
    -q|--quiet            decrease script verbosity, nothing will be written unless errors
    -f|--force            force some commands to not prompt confirmation
    -i|--interactive      ask for confirmation before any action
    -x|--debug            see commands to run but not run them actually
"
declare -rx OPTS_INFO="
You can group short options like '-xc', set an option argument like '-d(=)value'
or '--long=value' and use '--' to explicitly specify the end of the script options.
"

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
        Linux|FreeBSD|OpenBSD|SunOS) echo "\E[${1}m";;
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
    if `inarray $1 ${libcolors[@]}`; then
        if [ ! -z $2 ]
            then echo "${libcolors_codes_background[`getindex $1 ${libcolors[@]}`]}"
            else echo "${libcolors_codes_foreground[`getindex $1 ${libcolors[@]}`]}"
        fi
    else return 1
    fi
}

### getcolortag ( name , background=false )
getcolortag () {
    if `inarray $1 ${libcolors[@]}`; then
        if [ ! -z $2 ]
            then echo $(gettextformattag "${libcolors_codes_background[`getindex $1 ${libcolors[@]}`]}")
            else echo $(gettextformattag "${libcolors_codes_foreground[`getindex $1 ${libcolors[@]}`]}")
        fi
    else return 1
    fi
}

#### terminal text options
declare -ra libtextoptions=(normal bold small underline blink reverse hidden)
declare -rx libtextoptions_codes=(0 1 2 4 5 7 8)

### gettextoptioncode ( name )
gettextoptioncode () {
    if `inarray $1 ${libtextoptions[@]}`
        then echo "${libtextoptions_codes[`getindex $1 ${libtextoptions[@]}`]}"
        else return 1
    fi
}

### gettextoptiontag ( name )
gettextoptiontag () {
    if `inarray $1 ${libtextoptions[@]}`
        then echo $(gettextformattag "${libtextoptions_codes[`getindex $1 ${libtextoptions[@]}`]}")
        else return 1
    fi
}

### gettextoptiontagclose ( name )
gettextoptiontagclose () {
    if `inarray $1 ${libtextoptions[@]}`
        then echo $(gettextformattag "2${libtextoptions_codes[`getindex $1 ${libtextoptions[@]}`]}")
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

#### parsecolor ( string with <bold>tags</bold> )
# parse in-text tags like:
#     ... <bold>my text</bold> ...
#     ... <red>my text</red> ...
#     ... <bgred>my text</bgred> ...
parsecolor () {
    transformed=""
    while read -r line; do
        doneopts=()
        transformedline="$line"
        for opt in $(echo "$line" | grep -Po '<.[^/>]*>' | sed "s|^.*<\(.[^>]*\)>.*\$|\1|g"); do
            opt="${opt/\//}"
            if `inarray "$opt" ${doneopts[@]}`; then continue; fi
            doneopts+=($opt)
            if `inarray $opt ${libtextoptions[@]}`; then
                code=$(gettextoptioncode $opt)
                tag=$(gettextoptiontag $opt)
                normaltag=$(gettextoptiontag normal)
            elif `inarray $opt ${libcolors[@]}`; then
                code=$(getcolorcode $opt)
                tag=$(getcolortag $opt)
                normaltag=$(getcolortag default)
            else
                code=$(getcolorcode ${opt/bg/} true)
                tag=$(getcolortag ${opt/bg/} true)
                normaltag=$(getcolortag default true)
            fi
            if [ ! -z $tag ]; then
                strsubstituted=$(echo "$transformedline" | sed "s/<${opt}>/${tag}/g;s/.*\n//g;s/<\/${opt}>/${normaltag}/g;s/\n.*//g");
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

#### getindex ( item , $array[@] )
# returns the index of an array item
getindex () {
    local i=0 search=$1; shift
    while [ $search != $1 ]
    do ((i++)); shift
        [ -z "$1" ] && { i=0; break; }
    done
    [ ! $i = 0 ] && echo $i && return 0
    return 1
}

#### inarray ( item , $array[@] )
# returns 0 if item is found in array
inarray () {
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

#### verecho ( string )
# echo the string if "verbose" is "on"
verecho () {
    if $VERBOSE; then _echo "$*"; fi; return 0;
}

#### quietecho ( string )
# echo the string if "quiet" is "off"
quietecho () {
    if $QUIET; then _echo "$*"; fi; return 0;
}

#### iexec ( command , debexec = true )
# execute the command after user confirmation if "interactive" is "on"
iexec () {
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
    if $DEBEXECUTION; then debexec "$1"; else eval $1; fi
    return 0
}

#### debexec ( command )
# execute the command if "debug" is "off", just write it on screen otherwise
debexec () {
    if $DEBUG; then
        _echo "$(colorize 'debug >>' bold) $1"
    else
        eval $1
    fi
    return 0
}

#### info ( string, bold = true )
# writes the string on screen and return
info () {
    local USEBOLD=${2:-true}
    if $USEBOLD; then
        _echo $(colorize "   >> $1" bold)
    else
        _echo "$(colorize '   >>' bold) $1"
    fi
    return 0
}

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

#### warning ( string , funcname , line )
# writes the error string on screen and return
warning () {
    _echo
    _echo $(colorize "!  >> ${1:-unknown warning}" bold)
    _echo "      at `colorize ${2:-${FUNCNAME[1]}} green` line `colorize ${3:-${BASH_LINENO[0]}} green`"
    _echo
    return 0
}

#### error ( string , status = 1 , funcname , line )
# writes the error string on screen and then exit with an error status, default is 1
error () {
    _echo
    _echo $(colorize "!! >> ${1:-unknown error}" bold)
    _echo "      at `colorize ${3:-${FUNCNAME[1]}} green` line `colorize ${4:-${BASH_LINENO[0]}} green`"
    _echo "      to get help, run: '~$ sh $0 -h'"
    _echo
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
            h) title true; usage; exit 0;;
            i) export INTERACTIVE=true; export QUIET=false;;
            v) export VERBOSE=true; export QUIET=false;;
            f) export FORCED=true;;
            x) export DEBUG=true; quietecho "  -  debug option enabled: commands shown as 'debug >> cmd' are not executed";;
            q) export VERBOSE=false; export INTERACTIVE=false; export QUIET=true;;
            t) _echo " - option 't': receiveing argument \"${OPTARG}\"";;
            -)
                LONGOPTARG="${OPTARG#*=}"
                case $OPTARG in
                    help) title true; usage; exit 0;;
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
    done
    export OPTIND=$oldoptind
    export LASTARG="${options[@]: -1}"
    return 0
}

#### INFOS #####################################################################

#### usage ()
# this function must echo the usage information USAGE (with option "-h")
usage () {
    if [ ! "x${USAGE}" = 'x' ]; then
        echo "$USAGE" >&2
    else
        local TMP_USAGE="
Usage:
    ~\$ sh ${0} -[options [=value]] argument --

Common options:$COMMON_OPTS_INFO
$OPTS_INFO"
        echo "$TMP_USAGE" >&2
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
    _echo "------------------------------------------------------------------------"
    title
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
    return 0
}

# Endfile
