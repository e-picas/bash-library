#!/bin/bash
#
# Bash Library - The open source bash library of Les Ateliers Pierrot
# Copyleft (c) 2013 Pierre Cassat and contributors
# <www.ateliers-pierrot.fr> - <contact@ateliers-pierrot.fr>
# License GPL-3.0 <http://www.opensource.org/licenses/gpl-3.0.html>
# Sources <http://github.com/atelierspierrot/bash-library>
# 
# bin/bash-library.sh
# 
##@!@##

#### SETTINGS #####################################################################

#set -e

# lib error codes
# Error codes in Bash must return an exit code between 0 and 255
#+ In the library, to be conform with C/C++ programs, we will try to use codes from 80 to 120
#+ (error codes in C/C++ begin at 64 but the recent evolutions of Bash reserved codes 64 to 78).
declare -x E_ERROR=90
declare -x E_OPTS=81
declare -x E_CMD=82
declare -x E_PATH=83

##@ SCRIPT_INFOS = ( NAME VERSION DATE PRESENTATION LICENSE HOMEPAGE )
# see http://en.wikipedia.org/wiki/Man_page
declare -rxa SCRIPT_INFOS=(NAME VERSION DATE PRESENTATION LICENSE HOMEPAGE)

##@ MANPAGE_INFOS = ( SYNOPSIS DESCRIPTION OPTIONS FILES ENVIRONMENT BUGS AUTHOR SEE_ALSO )
declare -rxa MANPAGE_INFOS=(SYNOPSIS DESCRIPTION OPTIONS FILES ENVIRONMENT BUGS AUTHOR SEE_ALSO)

##@ LIB_FLAGS = ( VERBOSE QUIET DEBUG INTERACTIVE FORCED )
declare -rxa LIB_FLAGS=(VERBOSE QUIET DEBUG INTERACTIVE FORCED)

##@ LIB_COLORS = ( COLOR_LIGHT COLOR_DARK COLOR_INFO COLOR_NOTICE COLOR_WARNING COLOR_ERROR COLOR_COMMENT )
# common colors
declare -rxa LIB_COLORS=(COLOR_LIGHT COLOR_DARK COLOR_INFO COLOR_NOTICE COLOR_WARNING COLOR_ERROR COLOR_COMMENT)
case $USEROS in
    Linux|FreeBSD|OpenBSD|SunOS) 
        declare -x COLOR_LIGHT=yellow
        declare -x COLOR_DARK=lightgrey
        declare -x COLOR_INFO=green
        declare -x COLOR_NOTICE=blue
        declare -x COLOR_WARNING=bgmagenta
        declare -x COLOR_ERROR=bgred
        declare -x COLOR_COMMENT=small
        ;;
    *) 
        declare -x COLOR_LIGHT=yellow
        declare -x COLOR_DARK=lightgrey
        declare -x COLOR_INFO=green
        declare -x COLOR_NOTICE=cyan
        declare -x COLOR_WARNING=bgcyan
        declare -x COLOR_ERROR=bgred
        declare -x COLOR_COMMENT=grey
        ;;
esac

##@ LIBCOLORS = ( default black red green yellow blue magenta cyan grey white lightred lightgreen lightyellow lightblue lightmagenta lightcyan lightgrey )
## terminal colors
declare -rxa LIBCOLORS=(default black red green yellow blue magenta cyan grey white lightred lightgreen lightyellow lightblue lightmagenta lightcyan lightgrey)
declare -rxa LIBCOLORS_CODES_FOREGROUND=(39 30 31 32 33 34 35 36 90 97 91 92 93 94 95 96 37)
declare -rxa LIBCOLORS_CODES_BACKGROUND=(49 40 41 42 43 44 45 46 100 107 101 102 103 104 105 106 47)

##@ LIBTEXTOPTIONS = ( normal bold small underline blink reverse hidden )
## terminal text options
declare -rxa LIBTEXTOPTIONS=(normal bold small underline blink reverse hidden)
declare -rxa LIBTEXTOPTIONS_CODES=(0 1 2 4 5 7 8)


#### COMMON OPTIONS #############################################################################

##@ INTERACTIVE = DEBUG = VERBOSE = QUIET = FORCED = false
##@ WORKINGDIR = pwd
##@ LOGFILE = bashlib.log
##@ TEMPDIR = tmp
declare -x INTERACTIVE=false
declare -x QUIET=false
declare -x VERBOSE=false
declare -x FORCED=false
declare -x DEBUG=false
declare -x LASTARG=""
declare -x WORKINGDIR=$(pwd)
declare -x LOGFILE=""
declare -x LOGFILEPATH=""
declare -x TEMPDIR=""

##@ COMMON_OPTIONS_ARGS = "d:fhil:qvVx-:" | COMMON_OPTIONS_ARGS_MASK = REGEX mask that matches all common options
declare -x COMMON_OPTIONS_ARGS="d:fhil:qvVx-:"
declare -x COMMON_OPTIONS_ARGS_MASK="h|f|i|q|v|x|V|d|l"

declare -rx USEROS="$(uname)"
declare -rxa LINUX_OS=(Linux FreeBSD OpenBSD SunOS)


#### LOREM IPSUM #############################################################################

##@ LOREMIPSUM , LOREMIPSUM_SHORT , LOREMIPSUM_MULTILINE
declare -rx LOREMIPSUM="At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae. Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat."
declare -rx LOREMIPSUM_SHORT="Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
declare -rx LOREMIPSUM_MULTILINE="At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi. \n\
Sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. \n\
Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. Temporibus \n\
autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae. Itaque earum rerum hic tenetur a sapiente delectus, \n\
ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat.";


# LIBRARY INFOS #####################################################################

declare -rx LIB_NAME="Bash shell library"
declare -rx LIB_VERSION="1.0.3"
declare -rx LIB_DATE="2013-10-20"
declare -rx LIB_PRESENTATION="The open source bash library of Les Ateliers Pierrot"
declare -rx LIB_AUTHOR="Les Ateliers Pierrot <http://www.ateliers-pierrot.fr/>"
declare -rx LIB_LICENSE="GPL-3.0"
declare -rx LIB_LICENSE_URL="http://www.gnu.org/licenses/gpl-3.0.html"
declare -rx LIB_PACKAGE="atelierspierrot/bash-library"
declare -rx LIB_HOME="https://github.com/atelierspierrot/bash-library"
declare -rx LIB_BUGS="http://github.com/atelierspierrot/bash-library/issues"

declare -rx LIB_NAME_DEFAULT="bashlib"
declare -rx LIB_LOGFILE="${LIB_NAME_DEFAULT}.log"
declare -rx LIB_TEMPDIR="tmp"

declare -rx OPTIONS_USAGE_INFOS="\tYou can group short options like '<bold>-xc</bold>', \
set an option argument like '<bold>-d(=)value</bold>' \n\
\tor '<bold>--long=value</bold>' and use '<bold>--</bold>' \
to explicitly specify the end of the script options.";

declare -rx COMMON_OPTIONS_LIST="<bold>-h | --help</bold>\t\tshow this information message \n\
\t<bold>-v | --verbose</bold>\t\tincrease script verbosity \n\
\t<bold>-q | --quiet</bold>\t\tdecrease script verbosity, nothing will be written unless errors \n\
\t<bold>-f | --force</bold>\t\tforce some commands to not prompt confirmation \n\
\t<bold>-i | --interactive</bold>\task for confirmation before any action \n\
\t<bold>-x | --debug</bold>\t\tsee commands to run but not run them actually \n\
\t<bold>-V | --version</bold>\t\tsee the script version when available\n\
\t<bold>-d | --working-dir=PATH</bold>\tredefine the working directory (default is 'pwd' - 'PATH' must exist)\n\
\t<bold>-l | --log=FILENAME</bold>\tdefine the log filename to use (default is '${LIB_LOGFILE}')\n\
\t<bold>--libvers</bold>\t\tsee the library version \n\
\t<bold>--libhelp</bold>\t\tsee the library manpage";

declare -rx LIB_OPTIONS="${COMMON_OPTIONS_LIST}\n\n${OPTIONS_USAGE_INFOS}";

declare -rx COMMON_OPTIONS_INFO="\n\
<underline>Common options</underline> (to use first):\n\
\t${LIB_OPTIONS}";

declare -rx LIB_SYNOPSIS="~\$ <bold>${0}</bold>  -[<underline>COMMON OPTIONS</underline>]  -[<underline>SCRIPT OPTIONS</underline> [=<underline>VALUE</underline>]]  [<underline>ARGUMENTS</underline>]  --";
declare -rx LIB_SYNOPSIS_ACTION="~\$ <bold>${0}</bold>  -[<underline>COMMON OPTIONS</underline>]  -[<underline>SCRIPT OPTIONS</underline> [=<underline>VALUE</underline>]]  [<underline>ACTION</underline>]  --";
declare -rx LIB_SYNOPSIS_ERROR="${0}  [-${COMMON_OPTIONS_ARGS}]  [-SCRIPT OPTIONS [=VALUE]]  <action>  --";

declare -rx LIB_SEE_ALSO="<bold>bash</bold>";

declare -rx LIB_INFO="This script is based on the <bold>${LIB_NAME}</bold>, \"${LIB_PRESENTATION}\". \n\
\tPackage [<${COLOR_NOTICE}>${LIB_PACKAGE}</${COLOR_NOTICE}>] version [<${COLOR_NOTICE}>${LIB_VERSION}</${COLOR_NOTICE}>]. \n\
\tLicensed under ${LIB_LICENSE} - Copyleft (c) ${LIB_AUTHOR} - Some rights reserved. \n\
\tFor sources & updates, see <${LIB_HOME}>.\n\
\tFor bug reports, see <${LIB_BUGS}>. \n\
\tTo read ${LIB_LICENSE} license conditions, see <${LIB_LICENSE_URL}>.";

declare -rx LIB_DESCRIPTION="<bold>Bash</bold>, the \"<${COLOR_NOTICE}>Bourne-Again-SHell</${COLOR_NOTICE}>\", is a <underline>Unix shell</underline> written for the GNU Project as a free software replacement for the original Bourne shell (sh). \n\
\tThe present library is a tool for Bash scripts facilities.\n\
\tTo use the library, just include its source file using: \`<bold>source path/to/bash-library.sh</bold>\` and call its methods.\n\n\
\tThe library is licensed under ${LIB_LICENSE} - Copyleft (c) ${LIB_AUTHOR} - Some rights reserved. \n\
\tFor documentation, sources & updates, see <${LIB_HOME}>. \n\
\tTo read ${LIB_LICENSE} license conditions, see <${LIB_LICENSE_URL}>.";

declare -rx LIB_FILES="<underline>bash-library.sh</underline>\tthe standalone library source file \n\
\t<underline>${LIB_LOGFILE}</underline>\tthe default library log file";

declare -rx LIB_ENVIRONMENT="<${COLOR_NOTICE}>${LIB_COLORS[@]}</${COLOR_NOTICE}>\ta set of predefined colors\n\
\t<${COLOR_NOTICE}>${LIB_FLAGS[@]}</${COLOR_NOTICE}>\tthe library flags, activated by script common options\n\
\t<${COLOR_NOTICE}>USEROS</${COLOR_NOTICE}>\tthe current user operating system\n\
\t<${COLOR_NOTICE}>${MANPAGE_INFOS[@]}</${COLOR_NOTICE}>\tthese are used to build man-pages ; can be defined for each script";


#### SYSTEM #############################################################################

#### getsysteminfo ()
getsysteminfo () {
    if `in_array $USEROS ${LINUX_OS[@]}`
        then uname -osr
        else uname -vsr
    fi
    return 0
}

#### getmachinename ()
getmachinename () {
    if `in_array $USEROS ${LINUX_OS[@]}`
        then uname -n
        else uname -n
    fi
    return 0
}

#### addpath ( path )
## add a path to global environment PATH
add_path () {
    if [ -n "$1" ]; then export PATH=$PATH:$1; fi; return 0;
}

#### isgitclone ( path = pwd )
## check if a path, or `pwd`, is a git clone
isgitclone () {
    local curpath=$(pwd)
    local gitpath="${1:-${curpath}}/.git"
    if [ -d "$gitpath" ]; then return 0; else return 1; fi;
}

#### getscriptpath ( script = $0 )
## get the full real path of a script directory (passed as argument) or from current executed script
getscriptpath () {
    local arg="${1:-${0}}"
    local relpath=$(dirname "$arg")
    local abspath=$(cd "$relpath" && pwd)
    if [ -z "$abspath" ]; then return 1; fi
    echo "$abspath"
    return 0
}

#### realpath ( script = $0 )
## get the real path of a script (passed as argument) or from current executed script
realpath () {
    local arg="${1:-${0}}"
    local dirpath=$(getscriptpath "$arg")
    if [ -z "$dirpath" ]; then return 1; fi
    echo "${dirpath}/`basename $arg`"
    return 0
}

#### setworkingdir ( path )
## handles the '-d' option for instance
## throws an error if 'path' does not exist
setworkingdir () {
    if [ "$1" = "~" ]; then
        export WORKINGDIR=$HOME
    else
        if [ -d $1 ]
            then export WORKINGDIR=$1
            else patherror "$1"
        fi
    fi
    cd $WORKINGDIR
    return 0
}

#### setlogfilename ( path )
## handles the '-l' option for instance
setlogfilename () {
    if [ ! -z $1 ]; then export LOGFILE=$1; fi
    return 0
}


#### COLORIZED CONTENTS #############################################################################

#### gettextformattag ( code )
##@param code must be one of the library colors or text-options codes
## echoes the terminal tag code for color: "\ 033[CODEm"
gettextformattag () {
    if `in_array $USEROS ${LINUX_OS[@]}`
        then echo "\033[${1}m"
        else echo "\033[${1}m"
    fi
    return 0
}

#### getcolorcode ( name , background = false )
##@param name must be in LIBCOLORS
getcolorcode () {
    if `in_array $1 ${LIBCOLORS[@]}`; then
        if [ ! -z $2 ]
            then echo "${LIBCOLORS_CODES_BACKGROUND[`array_search $1 ${LIBCOLORS[@]}`]}"
            else echo "${LIBCOLORS_CODES_FOREGROUND[`array_search $1 ${LIBCOLORS[@]}`]}"
        fi
    else return 1
    fi
}

#### getcolortag ( name , background = false )
##@param name must be in LIBCOLORS
getcolortag () {
    if `in_array $1 ${LIBCOLORS[@]}`; then
        if [ ! -z $2 ]
            then echo $(gettextformattag "${LIBCOLORS_CODES_BACKGROUND[`array_search $1 ${LIBCOLORS[@]}`]}")
            else echo $(gettextformattag "${LIBCOLORS_CODES_FOREGROUND[`array_search $1 ${LIBCOLORS[@]}`]}")
        fi
    else return 1
    fi
}

#### gettextoptioncode ( name )
##@param name must be in LIBTEXTOPTIONS
gettextoptioncode () {
    if `in_array $1 ${LIBTEXTOPTIONS[@]}`
        then echo "${LIBTEXTOPTIONS_CODES[`array_search $1 ${LIBTEXTOPTIONS[@]}`]}"
        else return 1
    fi
}

#### gettextoptiontag ( name )
##@param name must be in LIBTEXTOPTIONS
gettextoptiontag () {
    if `in_array $1 ${LIBTEXTOPTIONS[@]}`
        then echo $(gettextformattag "${LIBTEXTOPTIONS_CODES[`array_search $1 ${LIBTEXTOPTIONS[@]}`]}")
        else return 1
    fi
}

#### gettextoptiontagclose ( name )
##@param name must be in LIBTEXTOPTIONS
gettextoptiontagclose () {
    if `in_array $1 ${LIBTEXTOPTIONS[@]}`
        then echo $(gettextformattag "2${LIBTEXTOPTIONS_CODES[`array_search $1 ${LIBTEXTOPTIONS[@]}`]}")
        else return 1
    fi
}

#### colorize ( string , text_option , foreground , background )
##@param text_option must be in LIBTEXTOPTIONS
##@param foreground must be in LIBCOLORS
##@param background must be in LIBCOLORS
## echoes a colorized string ; all arguments are optional except `string`
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
        if [ -n "$add" ]; then add="${add};${fgopt}"; else add="${fgopt}"; fi
    fi
    if [ ! -z $bgopt ]; then
        if [ -n "$add" ]; then add="${add};${bgopt}"; else add="${bgopt}"; fi
    fi
    opentag=$(gettextformattag "${add}")
    closetag=$(gettextformattag "$(gettextoptioncode normal)")
    if [ ! -n "$add" ]
        then echo "${1}"
        else echo "${opentag}${1}${closetag}"
    fi
}

#### parsecolortags ( "string with <bold>tags</bold>" )
## parse in-text tags like:
##     ... <bold>my text</bold> ...     // "tag" in LIBTEXTOPTIONS
##     ... <red>my text</red> ...       // "tag" in LIBCOLORS
##     ... <bgred>my text</bgred> ...   // "tag" in LIBCOLORS, constructed as "bgTAG"
parsecolortags () {
    transformed=""
    while read -r line; do
        doneopts=()
        transformedline="$line"
        for opt in $(echo "$line" | grep -Po '<.[^/>]*>' | sed "s|^.*<\(.[^>]*\)>.*\$|\1|g"); do
            opt="${opt/\//}"
            if `in_array "$opt" ${doneopts[@]}`; then continue; fi
            doneopts+=($opt)
            if `in_array $opt ${LIBTEXTOPTIONS[@]}`; then
                code=$(gettextoptioncode $opt)
                tag=$(gettextoptiontag $opt)
                if `in_array $USEROS ${LINUX_OS[@]}`
                    then normaltag=$(gettextoptiontagclose $opt)
                    else normaltag=$(gettextoptiontag normal)
                fi
            elif `in_array $opt ${LIBCOLORS[@]}`; then
                code=$(getcolorcode $opt)
                tag=$(getcolortag $opt)
                normaltag=$(getcolortag default)
            else
                code=$(getcolorcode ${opt/bg/} true)
                 tag=$(getcolortag ${opt/bg/} true)
                normaltag=$(getcolortag default true)
           fi
            if `in_array $USEROS ${LINUX_OS[@]}`; then
                 tag=$(printf '\%s' "$tag")
                 normaltag=$(printf '\%s' "$normaltag")
            fi
            if [ ! -z $tag ]; then
                strsubstituted=$(echo "$transformedline" | sed "s|<${opt}>|${tag}|g;s|</${opt}>|${normaltag}|g");
                if [ ! -z "$strsubstituted" ]; then transformedline="${strsubstituted}"; fi
            fi
        done
        if [ -n "$transformed" ]; then transformed="${transformed}\n"; fi
        transformed="${transformed}${transformedline}"
    done <<< "$1"
    _echo "$transformed"
    return 0
}

#### stripcolors ( string )
stripcolors () {
    transformed=""
    while read -r line; do
        case $USEROS in
            Linux|FreeBSD|OpenBSD|SunOS)
                stripped_line=$(echo "$line" | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g");;
            *)
                stripped_line=$(echo "$line" | sed 's|\x1B\[[0-9;]*[a-zA-Z]||g');;
        esac
        if [ -n "$transformed" ]; then transformed="${transformed}\n"; fi
        transformed="${transformed}${stripped_line}"
    done <<< "$1"
    _echo "$transformed"
    return 0
}

#### ARRAY #############################################################################

#### array_search ( item , $array[@] )
##@return the index of an array item
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
##@return 0 if item is found in array
in_array () {
  needle=$1; shift
  for item; do
    [[ "$needle" = $item ]] && return 0
  done
  return 1
}


#### STRING #############################################################################

#### strlen ( string )
##@return the number of characters in string
strlen () {
    echo ${#1}; return 0;
}

#### getextension ( filename )
## retrieve a file extension
getextension () {
    if [ -n "$1" ]; then echo "${1##*.}"; fi; return 0;
}

#### strtoupper ( string )
strtoupper () {
    echo "$1" | tr '[:lower:]' '[:upper:]'; return 0;
}

#### strtolower ( string )
strtolower () {
    echo "$1" | tr '[:upper:]' '[:lower:]'; return 0;
}

#### ucfirst ( string )
ucfirst () {
    echo "`strtoupper ${1:0:1}`${1:1:${#1}}"; return 0;
}

#### explode ( str , delim = ' ' )
# explode a string in an array using a delimiter
# result is loaded in '$EXPLODED_ARRAY'
explode () {
    local IFS="${2:- }"
    read -a EXPLODED_ARRAY <<< "$1"
    export EXPLODED_ARRAY
    return 0
}


#### BOOLEAN #############################################################################

#### onoffbit ( bool )
## echoes 'on' if bool=true, 'off' if it is false
onoffbit () {
    if $1; then echo 'on'; else echo 'off'; fi; return 0;
}


#### UTILS #############################################################################

#### _echo ( string )
## echoes the string with the true 'echo -e' command
## use this for colorization
_echo () {
#    tput sgr0
    case $USEROS in
#        Linux|FreeBSD|OpenBSD|SunOS) $(which echo) -e "$*" >&2;;
        Linux|FreeBSD|OpenBSD|SunOS) $(which echo) -e "$*";;
        Darwin) echo "$*";;
        *) if [ -f /bin/echo ]
            then /bin/echo "$*"
            else echo "$*"
        fi;;
    esac
    return 0
}

#### _necho ( string )
## echoes the string with the true 'echo -en' command
## use this for colorization and no new line
_necho () {
#    tput sgr0
    case $USEROS in
#        Linux|FreeBSD|OpenBSD|SunOS) $(which echo) -en "$*" >&2;;
        Linux|FreeBSD|OpenBSD|SunOS) $(which echo) -en "$*";;
#        *) echo -n "$*" >&2;;
        *) if [ -f /bin/echo ]
            then /bin/echo -n "$*"
            else echo "$*"
        fi;;
    esac
    return 0
}

#### verbose_echo ( string )
## echoes the string if "verbose" is "on"
verbose_echo () {
    if $VERBOSE; then _echo "$*"; fi; return 0;
}

#### verecho ( string )
## alias of 'verbose_echo'
verecho () { verbose_echo "$*"; }

#### quiet_echo ( string )
## echoes the string if "quiet" is "off"
quiet_echo () {
    if ! $QUIET; then _echo "$*"; fi; return 0;
}

#### quietecho ( string )
## alias of 'quiet_echo'
quietecho () { quiet_echo "$*"; }

#### interactive_exec ( command , debug_exec = true )
## executes the command after user confirmation if "interactive" is "on"
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
    if $DEBEXECUTION; then debug_exec "$1"; else
        cmd_fct=${FUNCNAME[1]}
        cmd_line=${BASH_LINENO[1]}
        cmd_out=$( eval $1 2>&1 )
        cmd_status=$?
        if [[ $command_rc -ne 0 ]]; then
            echo "$cmd_out"
        else
            error "error on execution: $cmd_out" $cmd_status $cmd_fct $cmd_line
        fi
    fi
    return 0
}

#### iexec ( command , debug_exec = true )
## alias of 'interactive_exec'
iexec () { interactive_exec "$*"; }

#### debug_exec ( command )
## execute the command if "debug" is "off", just write it on screen otherwise
debug_exec () {
    if $DEBUG
        then _echo "$(colorize 'debug >>' bold) \"$1\""
        else eval $1
    fi
    return 0
}

#### debexec ( command )
## alias of 'debug_exec'
debexec () { debug_exec "$*"; }

#### prompt ( string , default = y , options = Y/n )
## prompt user a string proposing different response options and selecting a default one
## final user fill is loaded in USERRESPONSE
prompt () {
    local add=""
    if [ -n "${3}" ]; then add="[${3}] "; fi
    colored=$(colorize "?  >> ${1} ?" bold)
    _necho "${colored} ${add}" >&2 
    read answer
    export USERRESPONSE=${answer:-$2}
    return 0
}

#### selector_prompt ( list[@] , string , list_string , default = 1 )
## prompt user a string proposing an indexed list of answers for selection
##+ and returns a valid result (user is re-prompted while the answer seems not correct)
## NOTE - the 'list' MUST be passed like `list[@]` (no quotes and dollar sign)
## final user choice is loaded in USERRESPONSE
selector_prompt () {
    local list=( "${!1}" )
    local list_count="${#list[@]}"
    local string="$2"
    local list_string="$3"
    local selected=0
    local first_time=1
    while [ $selected -lt 1 -o $selected -gt $list_count ]; do
        if [ $first_time -eq 0 ]
        then
            echo "! - Unknown index '${selected}'"
            prompt "Please select a value in the list (use indexes between brackets)" "${3:-1}"
        else
            first_time=0
            if [ ! -z "$string" ]; then echo "> ${list_string}:"; fi
            for i in "${!list[@]}"; do echo "    - [`expr ${i} + 1`] ${list[$i]}"; done
            prompt "$string" "${3:-1}"
        fi
        selected=$USERRESPONSE
    done
    export USERRESPONSE="${list[`expr ${selected} - 1`]}"
    return 0
}

#### info ( string, bold = true )
## writes the string on screen and return
info () {
    local USEBOLD=${2:-true}
    if $USEBOLD
        then _echo $(colorize "   >> $1" bold "$COLOR_INFO")
        else _echo "$(colorize '   >>' bold) $1"
    fi
    return 0
}

#### warning ( string , funcname = FUNCNAME[1] , line = BASH_LINENO[1] , tab='    ' )
## writes the error string on screen and return
warning () {
    local TAG="${4:-    }"
    local PADDER=$(printf '%0.1s' " "{1..1000})
    local LINELENGTH=$(tput cols)
    local FIRSTLINE="${TAG}[at ${3:-${FUNCNAME[1]}} line ${4:-${BASH_LINENO[1]}}]"
    local SECONDLINE=$(colorize "${TAG}!! >> ${1:-unknown warning}" bold)
    printf -v TMPSTR \
        "%*.*s\\\n%-*s\\\n%-*s\\\n%*.*s" \
        0 $LINELENGTH "$PADDER" \
        $(($LINELENGTH-`strlen $FIRSTLINE`)) "$FIRSTLINE" \
        $(($LINELENGTH-`strlen $SECONDLINE`)) "$SECONDLINE<${COLOR_WARNING}>";
    parsecolortags "\n<${COLOR_WARNING}>$TMPSTR</${COLOR_WARNING}>\n"
    return 0
}

#### error ( string , status = 90 , funcname = FUNCNAME[1] , line = BASH_LINENO[1] , tab='   ' )
## writes the error string on screen and then exit with an error status
##@error default status is E_ERROR (90)
error () {
    local TAG="${5:-    }"
    local PADDER=$(printf '%0.1s' " "{1..1000})
    local LINELENGTH=$(tput cols)
    local ERRSTRING="${1:-unknown error}"
    local ERRSTATUS="${2:-${E_ERROR}}"
    if [ -n "$LOGFILEPATH" ]; then log "${ERRSTRING}" "error:${ERRSTATUS}"; fi
    local FIRSTLINE="${TAG}[at ${3:-${FUNCNAME[1]}} line ${4:-${BASH_LINENO[1]}}] (to get help, try option '-h')"
    local SECONDLINE=$(colorize "${TAG}!! >> ${ERRSTRING}" bold)
    printf -v TMPSTR \
        "%*.*s\\\n%-*s\\\n%-*s\\\n%*.*s" \
        0 $LINELENGTH "$PADDER" \
        $(($LINELENGTH-`strlen $FIRSTLINE`)) "$FIRSTLINE" \
        $(($LINELENGTH-`strlen $SECONDLINE`)) "$SECONDLINE<${COLOR_ERROR}>";
    parsecolortags "\n<${COLOR_ERROR}>$TMPSTR</${COLOR_ERROR}>\n"
    exit ${ERRSTATUS}
}

#### nooptionerror ()
## no script option error
##@error exits with status E_OPTS (81)
nooptionerror () {
    error "No option or argument not understood ! Nothing to do ..." "${E_OPTS}" \
        ${FUNCNAME[1]} ${BASH_LINENO[0]};
}

#### commanderror ( cmd )
## command not found error
##@error exits with status E_CMD (82)
commanderror () {
    error "'$1' command seems not installed on your machine ... The process can't be done !" \
        "${E_CMD}" ${FUNCNAME[1]} ${BASH_LINENO[0]};
}

#### patherror ( path )
## path not found error
##@error exits with status E_PATH (83)
patherror () {
    error "Path '$1' (file or dir) can't be found ..." "${E_PATH}" \
        ${FUNCNAME[1]} ${BASH_LINENO[0]};
}

#### simple_error ( string , status = 90 , synopsis = SYNOPSIS_ERROR , funcname = FUNCNAME[1] , line = BASH_LINENO[1] )
## writes an error string as a simple message with a synopsis usage info
##@error default status is E_ERROR (90)
simple_error () {
    local ERRSYNOPSIS=""
    local ERRSTRING="${1:-unknown error}"
    local ERRSTATUS="${2:-${E_ERROR}}"
    if [ ! -z "$3" ]; then
        if [ "$3" == 'lib' ]; then
            ERRSYNOPSIS=$(echo "$LIB_SYNOPSIS")
        elif [ "$3" == 'action' ]; then
            ERRSYNOPSIS=$(echo "$LIB_SYNOPSIS_ACTION")
        else
            ERRSYNOPSIS=$(echo "$3")
        fi
    elif [ -n "$SYNOPSIS_ERROR" ]; then
        ERRSYNOPSIS=$(echo "$SYNOPSIS_ERROR")
    else
        ERRSYNOPSIS=$(echo "$LIB_SYNOPSIS_ERROR")
    fi
    if [ -n "$LOGFILEPATH" ]; then log "${ERRSTRING}" "error:${ERRSTATUS}"; fi
    if $DEBUG; then
        ERRSTR="${ERRSTR}\n\tat ${3:-${FUNCNAME[1]}} line ${4:-${BASH_LINENO[1]}}"
    fi
    printf "`parsecolortags \"<bold>error:</bold> %s \n<bold>usage:</bold> %s \nRun option '-h' for help.\"`" \
        "$ERRSTRING" "$ERRSYNOPSIS";
    echo
    exit ${ERRSTATUS}
}


#### TEMPORARY FILES #####################################################################

#### gettempdirpath ( dirname = "LIB_TEMPDIR" )
##@param dirname The name of the directory to create (default is `tmp/`)
## creates a default temporary dir with fallback: first in current dir then in system '/tmp/'
## the real temporary directory path is loaded in the global `TEMPDIR`
gettempdirpath () {
    if [ -n "$TEMPDIR" ]; then return 0; fi
    local tmpdir="${1:-${LIB_TEMPDIR}}"
    local tmpsyspath="/tmp/${LIB_NAME_DEFAULT}"
    local tmppwdpath="${WORKINGDIR}/${tmpdir}"
    if [ ! -d "$tmppwdpath" ]; then
        mkdir "$tmppwdpath" && chmod 777 "$tmppwdpath"
        if [ ! -d "$tmppwdpath" -o ! -w "$tmppwdpath" ]; then
            if [ ! -d "$tmpsyspath" ]; then
                mkdir "$tmpsyspath" && chmod 777 "$tmpsyspath"
                if [ ! -d "$tmpsyspath" -o ! -w "$tmpsyspath" ]
                    then error "Can not create temporary directory (tries to create '${tmppwdpath}' then '${tmpsyspath}')"
                    else export TEMPDIR="${tmpsyspath}";
                fi
            else export TEMPDIR="${tmpsyspath}";
            fi
        else export TEMPDIR="${tmppwdpath}";
        fi
    else export TEMPDIR="${tmppwdpath}";
    fi
    return 0
}

#### gettempfilepath ( filename , dirname = "LIB_TEMPDIR" )
##@param filename The temporary filename to use
##@param dirname The name of the directory to create (default is `tmp/`)
## this will echoes a unique new temporary file path
gettempfilepath () {
    if [ -z "$1" ]; then return 0; fi
    local tmpfile="$1"
    if [ ! -z "$2" ]
        then
            export TEMPDIR=""
            gettempdirpath "$2"
        else gettempdirpath
    fi
    local filepath="${TEMPDIR}/${tmpfile}"
    while [ -f "$filepath" ]; do
        n=$(( ${n:=0} + 1 ))
        filepath="${TEMPDIR}/${tmpfile}-${n}"
    done
    echo "$filepath"
    return 0
}

#### createtempdir ( dirname = "LIB_TEMPDIR" )
##@param dirname The name of the directory to create (default is `tmp/`)
## this will create a temporary directory in the working directory with full rights
## use this method to over-write an existing temporary directory
createtempdir () {
    if [ ! -z "$1" ]
        then
            export TEMPDIR=""
            gettempdirpath "$1"
        else gettempdirpath
    fi
    return 0
}

#### cleartempdir ( dirname = "LIB_TEMPDIR" )
##@param dirname The name of the directory (default is `tmp/`)
## this will deletes the temporary directory
cleartempdir () {
    if [ ! -z "$1" ]
        then gettempdirpath "$1"
        else gettempdirpath
    fi
    if [ -d "$TEMPDIR" ]; then
        rm -rf $TEMPDIR
    fi
    return 0
}

#### cleartempfiles ( dirname = "LIB_TEMPDIR" )
##@param dirname The name of the directory (default is `tmp/`)
## this will deletes the temporary directory contents (not the directory itself)
cleartempfiles () {
    if [ ! -z "$1" ]
        then gettempdirpath "$1"
        else gettempdirpath
    fi
    if [ -d "$TEMPDIR" ]; then
        rm -rf ${TEMPDIR}/*
    fi
    return 0
}


#### LOG FILES #####################################################################

#### getlogfilepath ()
## creates a default placed log file with fallback: first in '/var/log' then in current dir
## the real log file path is loaded in the global `LOGFILEPATH
getlogfilepath () {
    if [ ! -n "$LOGFILE" ]; then export LOGFILE=$LIB_LOGFILE; fi
    local logsys="/var/log/${LOGFILE}"
    if [ -w "$logsys" ]
        then export LOGFILEPATH="$logsys"
        else export LOGFILEPATH="$LOGFILE"
    fi
    return 0
}

#### log ( message , type='' )
## this will add an entry in LOGFILEPATH
log () {
    local add=""
    if [ ! -z $2 ]; then add=" <${2}>"; fi
    if [ ! -n "$LOGFILEPATH" ]; then getlogfilepath; fi
    echo "`date '+%B %d %T'` `getmachinename` [${USER}] [$$]${add} - ${1}" >> ${LOGFILEPATH}
    return 0
}

#### readlog ()
## this will read the LOGFILEPATH content
readlog () {
    if [ ! -n "$LOGFILEPATH" ]; then getlogfilepath; fi
    if [ -r "$LOGFILEPATH" -a -f "$LOGFILEPATH" ]; then cat "$LOGFILEPATH"; fi
    return 0
}


#### CONFIGURATION FILES #####################################################################

#### getglobalconfigfile ( file_name )
getglobalconfigfile () {
    if [ -z $1 ]; then
        warning "'readconfigfile()' requires a file name as argument"
        return 0
    fi
    local filename="$1"
    echo "/etc/${filename}.conf"
    return 0
}

#### getuserconfigfile ( file_name )
getuserconfigfile () {
    if [ -z $1 ]; then
        warning "'readconfigfile()' requires a file name as argument"
        return 0
    fi
    local filename="$1"
    echo ~/.${filename}.conf
    return 0
}

#### readconfig ( file_name )
## read a default placed config file with fallback: first in 'etc/' then in '~/'
readconfig () {
    if [ -z $1 ]; then
        warning "'readconfig()' requires a file name as argument"
        return 0
    fi
    local filename="$1"
    local global_filepath="/etc/${filename}"
    local user_filepath="~/.${filename}"
    if [ -r "$global_filepath" ]; then
        source "$global_filepath"
    fi
    if [ -r "$user_filepath" ]; then
        source "$user_filepath"
    fi
    return 0
}

#### readconfigfile ( file_path )
## read a config file
readconfigfile () {
    if [ -z $1 ]; then
        warning "'readconfigfile()' requires a file path as argument"
        return 0
    fi
    local filepath="$1"
    if [ ! -f $filepath ]; then
        warning "Config file '$1' not found!"
        return 0
    fi
    while read line; do
        if [[ "$line" =~ ^[^#]*= ]]; then
            name=${line%%=*}
            value=${line##*=}
            export "$name"="$value"
        fi
    done < $filepath
    return 0
}

#### writeconfigfile ( file_path , array_keys , array_values )
## array params must be passed as "array[@]" (no dollar sign)
writeconfigfile () {
    if [ -z $1 ]; then
        warning "'writeconfigfile()' requires a file name as 1st argument"
        return 0
    fi
    if [ -z $2 ]; then
        warning "'writeconfigfile()' requires a configuration keys array as 2nd argument"
        return 0
    fi
    if [ -z $3 ]; then
        warning "'writeconfigfile()' requires a configuration values array as 3rd argument"
        return 0
    fi
    local filepath="$1"
    declare -a array_keys=("${!2}")
    declare -a array_values=("${!3}")
    touch $filepath
    cat > $filepath <<EOL
$(buildconfigstring array_keys[@] array_values[@])
EOL
    if [ -f "$filepath" ]
        then return 0
        else return 1
    fi
}

#### setconfigval ( file_path , key , value )
setconfigval () {
    if [ -z "$1" ]; then
        warning "'setconfigval()' requires a file name as 1st argument"
        return 0
    fi
    if [ -z "$2" ]; then
        warning "'setconfigval()' requires a configuration key as 2nd argument"
        return 0
    fi
    if [ -z "$3" ]; then
        warning "'setconfigval()' requires a configuration value as 3rd argument"
        return 0
    fi
    local filepath="$1"
    local key="$2"
    local value="$3"
    touch $filepath
    if grep -q "$key=*" $filepath; then   
       sed -i '' -e "s|\($key=\).*|\1$value|" "$filepath"
    else
       echo "$key=$value" >> $filepath
    fi
    return 0
}

#### getconfigval ( file_path , key )
getconfigval () {
    if [ -z "$1" ]; then
        warning "'getconfigval()' requires a file name as 1st argument"
        return 0
    fi
    if [ -z "$2" ]; then
        warning "'getconfigval()' requires a configuration key as 2nd argument"
        return 0
    fi
    local filepath="$1"
    local key="$2"
    if [ -f $filepath ]; then
        if grep -q "$key=*" $filepath; then   
           local line=$(grep "^$key=" $filepath)
           echo ${line##*=}
        fi
    fi
    return 0
}

#### buildconfigstring ( array_keys , array_values )
## params must be passed as "array[@]" (no dollar sign)
buildconfigstring () {
    declare -a array_keys=("${!1}")
    declare -a array_values=("${!2}")
    local i=0
    local CONFIG_STR=""
    for key in "${array_keys[@]}"; do
        value="${array_values[${i}]}"
        sep=""
        if [ -n "$CONFIG_STR" ]; then sep="\n"; fi
        CONFIG_STR="${CONFIG_STR}${sep}${key}=${value}"
       ((i++))
    done
    _echo "$CONFIG_STR"
    return 0
}

#### SCRIPT OPTIONS / ARGUMENTS #############################################################################

#### getscriptoptions ( "$@" )
## this will stop options treatment at '--'
getscriptoptions () {
    local options=()
    local eoo=false
    while [[ $1 ]]; do
        if ! $eoo; then
            case "$1" in
                --) eoo=true; shift;;
                *) if [ -n "$1" ]; then options+=($1); fi; shift;;
            esac
        else shift;
        fi
    done
    echo "${options[*]}"
    return 0
}

#### getlongoptionarg ( "$x" )
## echoes the argument of a long option
getlongoptionarg () {
    echo "${1#*=}"; return 0;
}

#### getlastargument ( "$x" )
## echoes the last argument that is not an option
## for instance 'script.sh --options action' will echo "action"
getlastargument () {
    local lastarg="${@: -1}"
    local first_char="${lastarg:0:1}"
    if [ ".$first_char" != '.-' ]; then
        echo "$lastarg"; return 0;
    fi
    return 1
}

#### parsecomonoptions ( "$@" )
## parse common script options as described in $LIB_OPTIONS
## this will stop options treatment at '--'
parsecomonoptions () {
    local oldoptind=$OPTIND
    local options=$(getscriptoptions "$@")
#    export LASTARG=$(getscriptoptions "${options[@]}")
#    export LASTARG=$(getlastargument "${options[@]}")
    export LASTARG=$(getlastargument $options)
    while getopts ":${COMMON_OPTIONS_ARGS}" OPTION $options; do
#    while getopts ":${COMMON_OPTIONS_ARGS}" OPTION "${options[@]}"; do
#    while getopts ":${COMMON_OPTIONS_ARGS}" OPTION "$@"; do
        OPTARG="${OPTARG#=}"
        case $OPTION in
        # common options
            h) clear; usage; exit 0;;
            i) export INTERACTIVE=true; export QUIET=false;;
            v) export VERBOSE=true; export QUIET=false;;
            f) export FORCED=true;;
            x) export DEBUG=true; verecho "- debug option enabled: commands shown as 'debug >> \"cmd\"' are not executed";;
            q) export VERBOSE=false; export INTERACTIVE=false; export QUIET=true;;
            d) setworkingdir $OPTARG;;
            l) setlogfilename $OPTARG;;
            V) script_version; exit 0;;
            -) case $OPTARG in
        # common options
                    help|man|usage) clear; usage; exit 0;;
                    vers*) script_version; exit 0;;
                    interactive) export INTERACTIVE=true; export QUIET=false;;
                    verbose) export VERBOSE=true; export QUIET=false;;
                    force) export FORCED=true;;
                    debug) export DEBUG=true; verecho "- debug option enabled: commands shown as 'debug >> \"cmd\"' are not executed";;
                    quiet) export VERBOSE=false; export INTERACTIVE=false; export QUIET=true;;
                    working-dir*) LONGOPTARG="`getlongoptionarg \"${OPTARG}\"`"; setworkingdir $LONGOPTARG;;
                    log*) LONGOPTARG="`getlongoptionarg \"${OPTARG}\"`"; setlogfilename $LONGOPTARG;;
        # library options
                    libhelp) clear; library_usage; exit 0;;
                    libvers*) library_version; exit 0;;
                    libdoc*) libdoc; exit 0;;
        # no error for others
                    *) rien=rien;;
                esac ;;
            \?) rien=rien;;
        esac
    done
    export OPTIND=$oldoptind
    return 0
}


#### SCRIPT INFOS #####################################################################

#### version ()
version () {
    if isgitclone; then
        local gitcmd=$(which git)
        if [ -n "$gitcmd" ]; then
            echo "`git rev-parse --abbrev-ref HEAD` `git rev-parse HEAD`"
        fi
    else
        if [ "x$VERSION" != 'x' ]; then echo "${VERSION}"; fi
    fi
    return 0
}

#### title ( lib = false )
## this function must echo an information about script NAME and VERSION
## setting `$lib` on true will add the library infos
title () {
    local TITLE="${NAME}"
    if [ "x$VERSION" != 'x' ]; then TITLE="${TITLE} - v. [${VERSION}]"; fi    
    _echo $(colorize "##  ${TITLE}  ##" bold)
    if isgitclone; then
        local gitcmd=$(which git)
        if [ -n "$gitcmd" ]; then
            _echo "[git: `git rev-parse --abbrev-ref HEAD` `git rev-parse HEAD`]"
        fi
    fi
    if [ ! -z "$1" ]; then
        _echo "[using `library_version` - ${LIB_HOME}]"
    fi
    return 0
}

#### usage ( lib_info = true )
## this function must echo the usage information USAGE (with option "-h")
usage () {
    local lib_info="${1:-true}"
    local TMP_VERS="`library_info`"
    if [ ! "x${USAGE}" = 'x' -a "$lib_info" == 'true' ]; then
        title
        parsecolortags "$USAGE"
        parsecolortags "\n<${COLOR_COMMENT}>${TMP_VERS}</${COLOR_COMMENT}>"
    else
        local TMP_TITLE="${NAME:-?}"
        if [ -n "$VERSION" ]; then TMP_TITLE="${TMP_TITLE} - v. [${VERSION}]"; fi
        local TMP_USAGE="\n<bold>NAME</bold>\n\t<bold>${TMP_TITLE}</bold>";
        if [ -n "$PRESENTATION" ]; then
            TMP_USAGE="${TMP_USAGE}\n\t${PRESENTATION}";
        fi
        TMP_USAGE="${TMP_USAGE}\n";
        for section in "${MANPAGE_INFOS[@]}"; do
            eval "section_ctt=\"\$$section\""
            if [ "$section" != 'NAME' -a -n "$section_ctt" ]; then
                TMP_USAGE="${TMP_USAGE}\n<bold>${section}</bold>\n\t${section_ctt}\n";
            fi
        done
        if ! ${MANPAGE_NODEPEDENCY:-false}; then
            if [ "$lib_info" == 'true' ]; then
                TMP_USAGE="${TMP_USAGE}\n<bold>DEPENDENCIES</bold>\n\t${LIB_INFO}\n";
            fi
        fi
        TMP_USAGE="${TMP_USAGE}\n<${COLOR_COMMENT}>${TMP_VERS}</${COLOR_COMMENT}>";
        parsecolortags "$TMP_USAGE"
    fi
    return 0;
}

#### script_version ()
script_version () {
    local TMP_VERS="${VERSION}"
    if [ -n "$VERSION" ]; then
        local TMP_STR="${0} ${TMP_VERS}"
        if [ -n "$DATE" ]; then TMP_STR="${TMP_STR} - ${DATE}"; fi
        echo "${TMP_STR}"
    fi
    return 0;
}

#### LIBRARY INFOS #####################################################################

#### library_info ()
library_info () {
    echo "`library_version` - ${LIB_DATE}"
    return 0;
}

#### library_usage ()
## this function must echo the usage information of the library itself (with option "--libhelp")
library_usage () {
    for section in "${MANPAGE_INFOS[@]}"; do
        eval "old_$section=\$$section"
        eval "$section=\$LIB_$section"
    done
    for section in "${SCRIPT_INFOS[@]}"; do
        eval "old_$section=\$$section"
        eval "$section=\$LIB_$section"
    done
    usage false
    for section in "${MANPAGE_INFOS[@]}"; do
        eval "$section=\$old_$section"
    done
    for section in "${SCRIPT_INFOS[@]}"; do
        eval "$section=\$old_$section"
    done
}

#### library_version ()
## this function must echo an information about library name & version (with option "--libvers")
library_version () {
    local VERSFILE="${BASH_SOURCE/.sh/-gitversion}"
    local TMP_VERS="${LIB_NAME} ${LIB_VERSION}"
    local LIB_MODULE="`dirname $LIBRARY_REALPATH`/.."
    local _done=false
    if isgitclone $LIB_MODULE; then
        local gitcmd=$(which git)
        local oldpwd=$(pwd)
        if [ -n "$gitcmd" ]; then
            cd $LIB_MODULE
            local gitremote=$(git config --get remote.origin.url)
            if [ "${gitremote}" == "${LIB_HOME}.git" -o "${gitremote}" == "${LIB_HOME}" ]; then
                _done=true
                add="`git rev-parse --abbrev-ref HEAD` `git rev-parse HEAD`"
                if [ -n "$add" ]; then
                    TMP_VERS="${TMP_VERS} [@${add}]"
                fi
            fi
            cd $oldpwd
        fi
    fi
    if ! $_done && [ -f "$VERSFILE" ]; then
        TMP_VERS="${TMP_VERS} [@`cat $VERSFILE`]"
    fi
    echo "${TMP_VERS}"
    return 0
}

#### libdebug ( "$*" )
## see all common options flags values & some debug infos
libdebug () {
    OPTIND=1
    local TMP_DEBUG_MASK=" \n\
---- DEBUG -------------------------------------------------------------\n\
 \$ $0 $*\n\
------------------------------------------------------------------------\n\
- %s is set on %s\n\
- %s is set on %s\n\
- %s mode is %s (option '%s')\n\
- %s mode is %s (option '%s')\n\
- %s mode is %s (option '%s')\n\
- %s mode is %s (option '%s')\n\
- %s mode is %s (option '%s')\n\
- %s is set on %s\n\
------------------------------------------------------------------------\n\
 status: %s - pid: %s - user: %s\n\
 %s\n\
------------------------------------------------------------------------";
    printf -v TMP_DEBUG "$TMP_DEBUG_MASK" \
        $(colorize 'USEROS' bold) $(colorize "${USEROS}" bold $COLOR_INFO) \
        $(colorize 'WORKINGDIR' bold) $(colorize "${WORKINGDIR}" bold $COLOR_INFO) \
        $(colorize 'VERBOSE' bold) $(colorize "$(onoffbit $VERBOSE)" bold $COLOR_INFO) "-v" \
        $(colorize 'INTERACTIVE' bold) $(colorize "$(onoffbit $INTERACTIVE)" bold $COLOR_INFO) "-i" \
        $(colorize 'FORCED' bold) $(colorize "$(onoffbit $FORCED)" bold $COLOR_INFO) "-f" \
        $(colorize 'DEBUG' bold) $(colorize "$(onoffbit $DEBUG)" bold $COLOR_INFO) "-x" \
        $(colorize 'QUIET' bold) $(colorize "$(onoffbit $QUIET)" bold $COLOR_INFO) "-q" \
        $(colorize 'LASTARG' bold) $(colorize "${LASTARG:--}" bold $COLOR_INFO) \
        "$?" "$$" "`whoami`" "`getsysteminfo`";
    _echo "$TMP_DEBUG"
    parsecolortags "<${COLOR_COMMENT}>`library_info`</${COLOR_COMMENT}>";
    return 0
}

#### libdoc ()
## get the library functions list (with option "--libdoc")
## expend the doc with option '-v'
libdoc () {
    if $VERBOSE; then
        parsecolortags "<bold>Library documentation</bold> (developed mode)";
    else
        parsecolortags "<bold>Library documentation</bold> (use option '-v' to develop)";
    fi
    local libraryfile=${LIBFILE:-${BASH_SOURCE[0]}}
    if [ ! -f $libraryfile ]; then patherror $libraryfile; fi
    i=0
    old_IFS=$IFS
    IFS=$'\n'
    local indoc=false
    local intag=false
    for line in $(cat $libraryfile); do
        if [ "$line" == '##@!@##' ]; then
            if $indoc; then indoc=false; else indoc=true; fi
            continue;
        fi
        line_str=""
        fct_line=$(echo "$line" | grep -Po "^####.[^#]*$" | sed "s|^#### \(.* (.*)\)$|\\\t\1|g")
        if [ $indoc -a -n "$fct_line" ]; then
            line_str="$fct_line"
            intag=true
        elif $indoc; then
            title_line=$(echo "$line" | grep -Po "^####.[^#]*#*$" | sed "s|^#### \(.*\) #*$|\\\n# \1 (line ${i}) #|g")
            if [ -n "$title_line" ]; then
                line_str="$title_line"
            elif $intag; then
                arg_line=$(echo "$line" | grep -Po "^##@[^ ]* .*$" | sed "s|^##\(@.*\) \(.*\)$|\\\t\\\t\1 \2|g")
                comm_line=$(echo "$line" | grep -Po "^##([^!]*)$" | sed "s|^##* \(.*\)$|\\\t\\\t\1|g")
                if $VERBOSE; then
                    if [ -n "$arg_line" ]; then
                        line_str="$arg_line"
                    else
                        if [ -n "$comm_line" ]; then
                            line_str="$comm_line"
                        else
                            intag=false;
                        fi
                    fi
                else
                    if [ -n "$arg_line" -a -n "$comm_line" ]; then
                        intag=false
                    fi
                fi
            else
                intag=false;
                arg_line=$(echo "$line" | grep -Po "^##@[^ ]* .*$" | sed "s|^##\(@.*\) \(.*\)$|\\\t\1 \2|g")
                if [ -n "$arg_line" ]; then
                    line_str="$arg_line"
                fi
            fi
        fi
        if [ -n "$line_str" ]; then _echo "${line_str}"; fi
        i=$(($i+1))
    done
    IFS=$old_IFS
    parsecolortags "\n<${COLOR_COMMENT}>`library_info`</${COLOR_COMMENT}>";
    return 0
}

##@ LIBRARY_REALPATH
declare -rx LIBRARY_REALPATH=$(realpath ${BASH_SOURCE[0]})

##@!@##
# Endfile
# vim: autoindent tabstop=2 shiftwidth=2 expandtab softtabstop=2 filetype=sh
