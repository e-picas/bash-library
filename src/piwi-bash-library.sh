#!/bin/bash
#
# Piwi Bash Library - The open source bash library of Les Ateliers Pierrot
# Copyleft (c) 2013 Pierre Cassat and contributors
# <www.ateliers-pierrot.fr> - <contact@ateliers-pierrot.fr>
# License GPL-3.0 <http://www.opensource.org/licenses/gpl-3.0.html>
# Sources <http://github.com/atelierspierrot/piwi-bash-library>
# 
# bin/piwi-bash-library.sh
# 
##@!@##

#### REFERENCES #####################################################################

##@ Bash Reference Manual: http://www.gnu.org/software/bash/manual/bashref.html
##@ Bash Guide for Beginners: http://www.tldp.org/LDP/Bash-Beginners-Guide/html/Bash-Beginners-Guide.html
##@ Advanced Bash-Scripting Guide: http://www.tldp.org/LDP/abs/html/abs-guide.html
##@ GNU coding standards: http://www.gnu.org/prep/standards/standards.html


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

##@ MANPAGE_INFOS = ( SYNOPSIS DESCRIPTION OPTIONS EXAMPLES EXIT_STATUS FILES ENVIRONMENT COPYRIGHT BUGS AUTHOR SEE_ALSO )
# see http://en.wikipedia.org/wiki/Man_page
declare -rxa MANPAGE_INFOS=(SYNOPSIS DESCRIPTION OPTIONS EXAMPLES EXIT_STATUS FILES ENVIRONMENT COPYRIGHT BUGS AUTHOR SEE_ALSO)

##@ VERSION_INFOS = ( NAME VERSION DATE PRESENTATION COPYRIGHT_TYPE LICENSE_TYPE SOURCES_TYPE ADDITIONAL_INFO )
# see http://www.gnu.org/prep/standards/standards.html#g_t_002d_002dversion
declare -rxa VERSION_INFOS=(NAME VERSION DATE PRESENTATION COPYRIGHT_TYPE LICENSE_TYPE SOURCES_TYPE ADDITIONAL_INFO)

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

##@ LIB_FILENAME_DEFAULT = "piwi-bash-library"
declare -rx LIB_FILENAME_DEFAULT="piwi-bash-library"
##@ LIB_NAME_DEFAULT = "piwibashlib"
declare -rx LIB_NAME_DEFAULT="piwibashlib"
##@ LIB_LOGFILE = "piwibashlib.log"
declare -rx LIB_LOGFILE="${LIB_NAME_DEFAULT}.log"
##@ LIB_TEMPDIR = "tmp"
declare -rx LIB_TEMPDIR="tmp"

declare -rx GITVERSION_MASK="@gitversion@"
declare -x TEST_VAR="test"

#### ENVIRONMENT #############################################################################

##@ INTERACTIVE = DEBUG = VERBOSE = QUIET = FORCED = DRYRUN = false
##@ WORKINGDIR = pwd
declare -x INTERACTIVE=false
declare -x QUIET=false
declare -x VERBOSE=false
declare -x FORCED=false
declare -x DEBUG=false
declare -x DRYRUN=false
declare -x WORKINGDIR=$(pwd)
declare -x LOGFILE=""
declare -x LOGFILEPATH=""
declare -x TEMPDIR=""

##@ USEROS="$(uname)"
declare -rx USEROS="$(uname)"
declare -rxa LINUX_OS=(Linux FreeBSD OpenBSD SunOS)


#### COMMON OPTIONS #############################################################################

##@ COMMON_OPTIONS_ALLOWED = "d:fhil:qvVx-:"
##@ COMMON_OPTIONS_ALLOWED_MASK : REGEX mask that matches all common short options
##@ COMMON_LONG_OPTIONS_ALLOWED="working-dir:,working-directory:,force,help,interactive,log:,logfile:,quiet,verbose,vers,version,debug,dry-run,libvers,libversion,lib-vers,lib-version"
##@ COMMON_LONG_OPTIONS_ALLOWED_MASK : REGEX mask that matches all common long options
declare -x COMMON_OPTIONS_ALLOWED="d:fhil:qvVx-:"
declare -x COMMON_LONG_OPTIONS_ALLOWED="working-dir:,force,help,interactive,log:,quiet,verbose,vers,version,debug,dry-run,libvers,libversion,lib-vers,lib-version,man,usage"
declare -x COMMON_OPTIONS_ALLOWED_MASK="h|f|i|q|v|x|V|d|l"
declare -x COMMON_LONG_OPTIONS_ALLOWED_MASK="working-dir|force|help|interactive|log|quiet|verbose|vers|version|debug|dry-run|libvers|libversion|lib-vers|lib-version|man|usage"

##@ ORIGINAL_SCRIPT_OPTS="$@"
##@ SCRIPT_OPTS=() | SCRIPT_ARGS=() | SCRIPT_PROGRAMS=()
##@ OPTIONS_ALLOWED | LONG_OPTIONS_ALLOWED : to be defined by the script
declare -xa SCRIPT_OPTS=()
declare -xa SCRIPT_ARGS=()
declare -xa SCRIPT_PROGRAMS=()
declare -x OPTIONS_ALLOWED="${COMMON_OPTIONS_ALLOWED}"
declare -x LONG_OPTIONS_ALLOWED="${COMMON_LONG_OPTIONS_ALLOWED}"
declare -rx ORIGINAL_SCRIPT_OPTS="$@"
declare -xi ARGIND=0
declare -x ARGUMENT=""

##@ OPTIONS_USAGE_INFOS : information string about command line options how-to
declare -rx OPTIONS_USAGE_INFOS="\tYou can group short options like '<bold>-xc</bold>', \
set an option argument like '<bold>-d(=)value</bold>' \n\
\tor '<bold>--long=value</bold>' and use '<bold>--</bold>' \
to explicitly specify the end of the script options.";

##@ COMMON_OPTIONS_LIST : information string about common script options
declare -rx COMMON_OPTIONS_LIST="<bold>-h | --help</bold>\t\t\tshow this information message \n\
\t<bold>-v | --verbose</bold>\t\t\tincrease script verbosity \n\
\t<bold>-q | --quiet</bold>\t\t\tdecrease script verbosity, nothing will be written unless errors \n\
\t<bold>-f | --force</bold>\t\t\tforce some commands to not prompt confirmation \n\
\t<bold>-i | --interactive</bold>\t\task for confirmation before any action \n\
\t<bold>-x | --debug</bold>\t\t\tenable debug mode \n\
\t<bold>-V | --version</bold>\t\t\tsee the script version when available ; use option '-q' to get the version number only\n\
\t<bold>-d | --working-dir=PATH</bold>\t\tredefine the working directory (default is 'pwd' - 'PATH' must exist)\n\
\t<bold>-l | --log=FILENAME</bold>\t\tdefine the log filename to use (default is '${LIB_LOGFILE}')\n\
\t<bold>--usage</bold>\t\t\t\tshow quick usage information \n\
\t<bold>--man</bold>\t\t\t\tsee the current script manpage if available \n\
\t<bold>--dry-run</bold>\t\t\tsee commands to run but not run them actually \n\
\t<bold>--libvers</bold>\t\t\tsee the library version";

##@ COMMON_OPTIONS_FULLINFO : concatenation of COMMON_OPTIONS_LIST & OPTIONS_USAGE_INFOS
declare -rx COMMON_OPTIONS_FULLINFO="${COMMON_OPTIONS_LIST}\n\n${OPTIONS_USAGE_INFOS}";


#### LOREM IPSUM #############################################################################

##@ LOREMIPSUM , LOREMIPSUM_SHORT , LOREMIPSUM_MULTILINE
declare -rx LOREMIPSUM="At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae. Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat."
declare -rx LOREMIPSUM_SHORT="Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
declare -rx LOREMIPSUM_MULTILINE="At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi. \n\
Sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. \n\
Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. Temporibus \n\
autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae. Itaque earum rerum hic tenetur a sapiente delectus, \n\
ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat.";


#### LIBRARY INFOS #####################################################################

##@ LIB_NAME LIB_VERSION LIB_DATE LIB_GITVERSION
declare -rx LIB_NAME="Piwi Bash library"
declare -rx LIB_VERSION="1.0.0"
declare -rx LIB_DATE="2013-11-03"
declare -rx LIB_GITVERSION="master@f06c50d7cf51379451edb014883903aaad9ee42a"
declare -rx LIB_PRESENTATION="The open source bash library of Les Ateliers Pierrot"
declare -rx LIB_LICENSE="GPL-3.0"
declare -rx LIB_LICENSE_URL="http://www.gnu.org/licenses/gpl-3.0.html"
declare -rx LIB_PACKAGE="atelierspierrot/piwi-bash-library"
declare -rx LIB_HOME="https://github.com/atelierspierrot/piwi-bash-library"
declare -rx LIB_COPYRIGHT_TYPE="Copyleft (c) 2013 Les Ateliers Pierrot <http://www.ateliers-pierrot.fr/>"
declare -rx LIB_LICENSE_TYPE="License ${LIB_LICENSE}: <${LIB_LICENSE_URL}>"
declare -rx LIB_SOURCES_TYPE="Sources & updates: <${LIB_HOME}>"
declare -rx LIB_ADDITIONAL_INFO="This is free software: you are free to change and redistribute it ; there is NO WARRANTY, to the extent permitted by law.";
declare -rx LIB_SYNOPSIS="~\$ <bold>${0}</bold>  -[<underline>common options</underline>]  -[<underline>script options</underline> [=<underline>value</underline>]]  [--]  [<underline>arguments</underline>]";
declare -rx LIB_SYNOPSIS_ACTION="~\$ <bold>${0}</bold>  -[<underline>common options</underline>]  -[<underline>script options</underline> [=<underline>value</underline>]]  [--]  [<underline>action</underline>]";
declare -rx LIB_SYNOPSIS_ERROR="${0}  [-${COMMON_OPTIONS_ALLOWED_MASK}]\n\t[--${COMMON_LONG_OPTIONS_ALLOWED_MASK}]\n\t[--script-options [=value]]  [--]  <arguments>";

declare -rx LIB_COPYRIGHT="${LIB_COPYRIGHT_TYPE} - Some rights reserved. \n\
\tPackage [<${COLOR_NOTICE}>${LIB_PACKAGE}</${COLOR_NOTICE}>] version [<${COLOR_NOTICE}>${LIB_VERSION}</${COLOR_NOTICE}>].\n\
\t${LIB_LICENSE_TYPE}.\n\
\t${LIB_SOURCES_TYPE}.\n\
\tBug reports: <http://github.com/atelierspierrot/piwi-bash-library/issues>.\n\
\t${LIB_ADDITIONAL_INFO}";

declare -rx LIB_DEPEDENCY_INFO="This script is based on the <bold>${LIB_NAME}</bold>, \"${LIB_PRESENTATION}\". \n\
\t${LIB_COPYRIGHT}";

## Documentation builder rules, tags and masks
declare -xa DOCBUILDER_MASKS=()
declare -x DOCBUILDER_MARKER='##@!@##'
declare -xa DOCBUILDER_RULES=(
    '^####.[^#]*$'                          # fct name line     : #### name ( what ever )
    '^####.[^#]*#*$'                        # title line        : #### title # (this will be followed by the line number and a new line)
    '^##@[^ ]* .*$'                         # tag line          : ##@tagname string
    '^##([^!]*)$'                           # comment line      : ## comment (will NOT match "##! comment")
    '^##@[^ ]* .*$'                         # alone tag line
);
declare -xa DOCBUILDER_TERMINAL_MASKS=(
    "s|^#### \(.* (.*)\)$|\\\t\1|g"         # fct name line
    "s|^#### \(.*\) #*$|\\\n# \1 #|g"       # title line
    "s|^##\(@.*\) \(.*\)$|\\\t\\\t\1 \2|g"  # tag line
    "s|^##* \(.*\)$|\\\t\\\t\1|g"           # comment line
    "s|^##\(@.*\) \(.*\)$|\\\t\1 \2|g"      # simple tag line
);
declare -xa DOCBUILDER_MARKDOWN_MASKS=(
    "s|^#### \(.* (.*)\)$|-   \*\*\1\*\*|g"     # fct name line
    "s|^#### \(.*\) #*$|\\\n## \1|g"            # title line
    "s|^##\(@.*\) \(.*\)$|    \1 \2|g"          # tag line
    "s|^##* \(.*\)$|\\\n    \1|g"               # comment line
    "s|^##\(@.*\) \(.*\)$|-   \1 \2|g"          # simple tag line
);

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

#### FILES #############################################################################

#### getextension ( path = $0 )
## retrieve a file extension
getextension () {
    local arg="${1:-${0}}"
    echo "${arg##*.}" && return 0 || return 1
}

#### getfilename ( path = $0 )
## isolate a file name without dir & extension
getfilename () {
    local arg="${1:-${0}}"
    filename=$(getbasename "$arg")
    echo "${filename%.*}" && return 0 || return 1
}

#### getbasename ( path = $0 )
## isolate a file name
getbasename () {
    local arg="${1:-${0}}"
    echo "`basename ${arg}`" && return 0 || return 1
}

#### getdirname ( path = $0 )
## isolate a file directory name
getdirname () {
    local arg="${1:-${0}}"
    echo "`dirname ${arg}`" && return 0 || return 1
}

#### realpath ( script = $0 )
## get the real path of a script (passed as argument) or from current executed script
realpath () {
    local arg="${1:-${0}}"
    local dirpath=$(getscriptpath "$arg")
    if [ -z "$dirpath" ]; then return 1; fi
    echo "${dirpath}/`basename $arg`" && return 0 || return 1
}


#### ARRAY #############################################################################

#### array_search ( item , $array[@] )
##@return the index of an array item, 0 based
array_search () {
    local i=0; local search="$1"; shift
    while [ "$search" != "$1" ]
    do ((i++)); shift
        [ -z "$1" ] && { i=0; break; }
    done
    [ ! $i = 0 ] && echo $i && return 0
    return 1
}

#### in_array ( item , $array[@] )
##@return 0 if item is found in array
in_array () {
    needle="$1"; shift
    for item; do
        [ "$needle" = "$item" ] && return 0
    done
    return 1
}

#### array_filter ( $array[@] )
##@return array with cleaned values
array_filter () {
    local -a cleaned=()
    for item; do
        if test "$item"; then cleaned+=("$item"); fi
    done
    echo "${cleaned[@]}"
}


#### STRING #############################################################################

#### strlen ( string )
##@return the number of characters in string
strlen () {
    echo ${#1}; return 0;
}

#### strtoupper ( string )
strtoupper () {
    if [ -n "$1" ]; then
        echo "$1" | tr '[:lower:]' '[:upper:]'; return 0;
    fi
    return 1
}

#### strtolower ( string )
strtolower () {
    if [ -n "$1" ]; then
        echo "$1" | tr '[:upper:]' '[:lower:]'; return 0;
    fi
    return 1
}

#### ucfirst ( string )
ucfirst () {
    if [ -n "$1" ]; then
        echo "`strtoupper ${1:0:1}`${1:1:${#1}}"; return 0;
    fi
    return 1
}

#### explode ( str , delim = ' ' )
# explode a string in an array using a delimiter
# result is loaded in '$EXPLODED_ARRAY'
explode () {
    if [ -n "$1" ]; then
        local IFS="${2:- }"
        read -a EXPLODED_ARRAY <<< "$1"
        export EXPLODED_ARRAY
        return 0
    fi
    return 1
}

#### implode ( array[@] , delim = ' ' )
# imple an array in a string using a delimiter
implode () {
    if [ -n "$1" ]; then
        declare -a _array=("${!1}")
        declare _delim="${2:- }"
        local oldIFS=$IFS
        IFS="${_delim}"
        local _arraystr="${_array[*]}"
        IFS=$SoldIFS
        export IFS
        echo $_arraystr
        return 0
    fi
    return 1
}

#### explodeletters ( str )
# explode a string in an array of single letters
# result is loaded in '$EXPLODED_ARRAY'
explodeletters () {
    if [ -n "$1" ]; then
        local _input="${1}"
        local i=0
        local -a letters=()
        while [ $i -lt ${#_input} ]; do letters[$i]=${_input:$i:1}; i=$((i+1)); done
        EXPLODED_ARRAY="${letters[@]}"
        export EXPLODED_ARRAY
        return 0
    fi
    return 1
}

#### BOOLEAN #############################################################################

#### onoffbit ( bool )
## echoes 'on' if bool=true, 'off' if it is false
onoffbit () {
    if $1; then echo 'on'; else echo 'off'; fi; return 0;
}


#### VCS #############################################################################

#### isgitclone ( path = pwd , remote_url = null )
## check if a path, or `pwd`, is a git clone of a remote if 2nd argument is set
isgitclone () {
    local curpath=$(pwd)
    local targetpath="${1:-${curpath}}"
    local gitcmd=$(which git)
    if [ -n "$2" ]; then
        if [ -n "$gitcmd" ]
        then
            cd $targetpath
            local gitremote=$(git config --get remote.origin.url)
            if [ "${gitremote}" == "${2}.git" -o "${gitremote}" == "${2}" ]
                then return 0; else return 1;
            fi
            cd $curpath
        else
            commanderror 'git'
        fi
    fi
    local gitpath="${1:-${curpath}}/.git"
    if [ -d "$gitpath" ]; then return 0; else return 1; fi;
}

#### gitversion ( quiet = false )
gitversion () {
    if isgitclone; then
        local gitcmd=$(which git)
        if [ -n "$gitcmd" ]; then
            echo "`git rev-parse --abbrev-ref HEAD`@`git rev-parse HEAD`"
            return 0
        fi
    fi
    return 1
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

#### / verecho ( string )
## alias of 'verbose_echo'
verecho () { verbose_echo "$*"; }

#### quiet_echo ( string )
## echoes the string if "quiet" is "off"
quiet_echo () {
    if ! $QUIET; then _echo "$*"; fi; return 0;
}

#### / quietecho ( string )
## alias of 'quiet_echo'
quietecho () { quiet_echo "$*"; }

#### interactive_exec ( command , debug_exec = true )
## executes the command after user confirmation if "interactive" is "on"
interactive_exec () {
    if [ $# -eq 0 ]; then return 0; fi
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
    if $DEBEXECUTION
    then debug_exec "$1"
    else
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

#### / iexec ( command , debug_exec = true )
## alias of 'interactive_exec'
iexec () { interactive_exec "$*"; }

#### debug_exec ( command )
## execute the command if "dryrun" is "off", just write it on screen otherwise
debug_exec () {
    if [ $# -eq 0 ]; then return 0; fi
    if $DRYRUN
        then _echo "$(colorize 'dry-run >>' bold) \"$1\""
        else eval $1
    fi
    return 0
}

#### / debexec ( command )
## alias of 'debug_exec'
debexec () { debug_exec "$*"; }

#### prompt ( string , default = y , options = Y/n )
## prompt user a string proposing different response options and selecting a default one
## final user fill is loaded in USERRESPONSE
prompt () {
    if [ $# -eq 0 ]; then return 0; fi
    local add=""
    if [ -n "${3}" ]; then add+="[${3}] "; fi
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
    if [ $# -eq 0 ]; then return 0; fi
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
    if [ $# -eq 0 ]; then return 0; fi
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
    if [ $# -eq 0 ]; then return 0; fi
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
    parsecolortags "\n<${COLOR_ERROR}>$TMPSTR</${COLOR_ERROR}>\n" >&2
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

#### simple_usage ( synopsis = SYNOPSIS_ERROR )
## writes a synopsis usage info
simple_usage () {
    local ERRSYNOPSIS=""
    if [ ! -z "$1" ]; then
        if [ "$1" == 'lib' ]; then
            ERRSYNOPSIS=$(_echo "$LIB_SYNOPSIS")
        elif [ "$1" == 'action' ]; then
            ERRSYNOPSIS=$(_echo "$LIB_SYNOPSIS_ACTION")
        else
            ERRSYNOPSIS=$(_echo "$1")
        fi
    elif [ -n "$SYNOPSIS_ERROR" ]; then
        ERRSYNOPSIS=$(_echo "$SYNOPSIS_ERROR")
    else
        ERRSYNOPSIS=$(_echo "$LIB_SYNOPSIS_ERROR")
    fi
    printf "`parsecolortags \"<bold>usage:</bold> %s \nRun option '-h' for help.\"`" "$ERRSYNOPSIS";
    echo
    return 0
}

#### simple_error ( string , status = 90 , synopsis = SYNOPSIS_ERROR , funcname = FUNCNAME[1] , line = BASH_LINENO[1] )
## writes an error string as a simple message with a synopsis usage info
##@error default status is E_ERROR (90)
simple_error () {
    local ERRSTRING="${1:-unknown error}"
    local ERRSTATUS="${2:-${E_ERROR}}"
    if $DEBUG; then
        ERRSTRING=$(gnuerrorstr "$ERRSTRING" '' "${3}" "${4}")
    fi
    if [ -n "$LOGFILEPATH" ]; then log "${ERRSTRING}" "error:${ERRSTATUS}"; fi
    printf "`parsecolortags \"<bold>error:</bold> %s\"`" "$ERRSTRING" >&2;
    echo
    simple_usage "$3"
    exit ${ERRSTATUS}
}

#### gnuerrorstr ( string , filename = BASH_SOURCE[2] , funcname = FUNCNAME[2] , line = BASH_LINENO[2] )
## must echoes something like 'sourcefile:lineno: message'
gnuerrorstr () {
    local errorstr=""
    local _source=$(echo "${2:-${BASH_SOURCE[2]}}")
    if [ -n "$_source" ]; then errorstr+="${_source}:"; fi
    local _func=$(echo "${3:-${FUNCNAME[2]}}")
    if [ -n "$_func" ]; then errorstr+="${_func}:"; fi
    local _line=$(echo "${4:-${BASH_LINENO[2]}}")
    if [ -n "$_line" ]; then errorstr+="${_line}:"; fi
    echo "${errorstr} ${1}"
    return 0
}


#### COLORIZED CONTENTS #############################################################################

#### gettextformattag ( code )
##@param code must be one of the library colors or text-options codes
## echoes the terminal tag code for color: "\ 033[CODEm"
gettextformattag () {
    if [ -n "$1" ]; then
        if `in_array $USEROS ${LINUX_OS[@]}`
            then echo "\033[${1}m"
            else echo "\033[${1}m"
        fi
        return 0
    fi
    return 1
}

#### getcolorcode ( name , background = false )
##@param name must be in LIBCOLORS
getcolorcode () {
    if [ -n "$1" ]; then
        if `in_array $1 ${LIBCOLORS[@]}`; then
            if [ ! -z $2 ]
                then echo "${LIBCOLORS_CODES_BACKGROUND[`array_search $1 ${LIBCOLORS[@]}`]}"
                else echo "${LIBCOLORS_CODES_FOREGROUND[`array_search $1 ${LIBCOLORS[@]}`]}"
            fi
        else return 1
        fi
    fi
    return 1
}

#### getcolortag ( name , background = false )
##@param name must be in LIBCOLORS
getcolortag () {
    if [ -n "$1" ]; then
        if `in_array $1 ${LIBCOLORS[@]}`; then
            if [ ! -z $2 ]
                then echo $(gettextformattag "${LIBCOLORS_CODES_BACKGROUND[`array_search $1 ${LIBCOLORS[@]}`]}")
                else echo $(gettextformattag "${LIBCOLORS_CODES_FOREGROUND[`array_search $1 ${LIBCOLORS[@]}`]}")
            fi
        else return 1
        fi
    fi
    return 1
}

#### gettextoptioncode ( name )
##@param name must be in LIBTEXTOPTIONS
gettextoptioncode () {
    if [ -n "$1" ]; then
        if `in_array $1 ${LIBTEXTOPTIONS[@]}`
            then echo "${LIBTEXTOPTIONS_CODES[`array_search $1 ${LIBTEXTOPTIONS[@]}`]}"
            else return 1
        fi
    fi
    return 1
}

#### gettextoptiontag ( name )
##@param name must be in LIBTEXTOPTIONS
gettextoptiontag () {
    if [ -n "$1" ]; then
        if `in_array $1 ${LIBTEXTOPTIONS[@]}`
            then echo $(gettextformattag "${LIBTEXTOPTIONS_CODES[`array_search $1 ${LIBTEXTOPTIONS[@]}`]}")
            else return 1
        fi
    fi
    return 1
}

#### gettextoptiontagclose ( name )
##@param name must be in LIBTEXTOPTIONS
gettextoptiontagclose () {
    if [ -n "$1" ]; then
        if `in_array $1 ${LIBTEXTOPTIONS[@]}`
            then echo $(gettextformattag "2${LIBTEXTOPTIONS_CODES[`array_search $1 ${LIBTEXTOPTIONS[@]}`]}")
            else return 1
        fi
    fi
    return 1
}

#### colorize ( string , text_option , foreground , background )
##@param text_option must be in LIBTEXTOPTIONS
##@param foreground must be in LIBCOLORS
##@param background must be in LIBCOLORS
## echoes a colorized string ; all arguments are optional except `string`
colorize () {
    if [ $# -eq 0 ]; then return 0; fi
    local textopt
    if [ ! -z $2 ]; then textopt=`gettextoptioncode "$2"`; fi
    local fgopt
    if [ ! -z $3 ]; then fgopt=`getcolorcode "$3"`; fi
    local bgopt
    if [ ! -z $4 ]; then bgopt=`getcolorcode "$4" true`; fi
    local add=""
    if [ ! -z $textopt ]; then add+="${textopt}"; fi
    if [ ! -z $fgopt ]; then
        if [ -n "$add" ]; then add+=";${fgopt}"; else add+="${fgopt}"; fi
    fi
    if [ ! -z $bgopt ]; then
        if [ -n "$add" ]; then add+=";${bgopt}"; else add+="${bgopt}"; fi
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
    if [ $# -eq 0 ]; then return 0; fi
    transformed=""
    while read -r line; do
        doneopts=()
        transformedline="$line"
        for opt in $(echo "$line" | grep -o '<.[^/>]*>' | sed "s|^.*<\(.[^>]*\)>.*\$|\1|g"); do
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
        if [ -n "$transformed" ]; then transformed+="\n"; fi
        transformed+="${transformedline}"
    done <<< "$1"
    _echo "$transformed"
    return 0
}

#### stripcolors ( string )
stripcolors () {
    if [ $# -eq 0 ]; then return 0; fi
    transformed=""
    while read -r line; do
        case $USEROS in
            Linux|FreeBSD|OpenBSD|SunOS)
                stripped_line=$(echo "$line" | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g");;
            *)
                stripped_line=$(echo "$line" | sed 's|\x1B\[[0-9;]*[a-zA-Z]||g');;
        esac
        if [ -n "$transformed" ]; then transformed+="\n"; fi
        transformed+="${stripped_line}"
    done <<< "$1"
    _echo "$transformed"
    return 0
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
    if [ $# -eq 0 ]; then return 0; fi
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
    if [ $# -eq 0 ]; then return 0; fi
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

#### getshortoptionsarray ()
getshortoptionsarray () {
    local -a short_options=()
    explodeletters "$OPTIONS_ALLOWED"
    for i in ${EXPLODED_ARRAY[@]}; do
        if [ "$i" != ":" -a "$i" != "-" ]; then
            short_options+=( "$i" )
        fi
    done
    echo "${short_options[@]}"
}

#### getshortoptionsstring ( delimiter = '|' )
getshortoptionsstring () {
    local delimiter="${1:-|}"
    local -a short_options=( $(getshortoptionsarray) )
    echo $(implode short_options[@] "${delimiter}")
}

#### getlongoptionsarray ()
getlongoptionsarray () {
    local -a long_options=()
    explode "$LONG_OPTIONS_ALLOWED" ","
    for i in ${EXPLODED_ARRAY[@]}; do
        long_options+=( "${i%:*}" )
    done
    echo "${long_options[@]}"
}

#### getlongoptionsstring ( delimiter = '|' )
getlongoptionsstring () {
    local delimiter="${1:-|}"
    local -a long_options=( $(getlongoptionsarray) )
    echo $(implode long_options[@] "${delimiter}")
}

#### getoptionarg ( "$x" )
## echoes the argument of an option
getoptionarg () {
    if [ -n "$1" ]; then echo "${1#=}"; fi; return 0;
}

#### getlongoption ( "$x" )
## echoes the name of a long option
getlongoption () {
    local arg="$1"
    if [ -n "$arg" ]; then
        if [[ "$arg" =~ .*=.* ]]; then arg="${arg%=*}"; fi
        echo "$arg" | cut -d " " -f1
        return 0
    fi
    return 1
}

#### getlongoptionarg ( "$x" )
## echoes the argument of a long option
getlongoptionarg () {
    local arg="$1"
    if [ -n "$arg" ]; then
        if [[ "$arg" =~ .*=.* ]]
            then arg="${arg#*=}"
            else arg=$(echo "$arg" | cut -d " " -f2-)
        fi
        echo "$arg"
        return 0
    fi
    return 1
}

#### getnextargument ()
## get next script argument according to current `ARGIND`
## load it in `ARGUMENT` and let `ARGIND` incremented
getnextargument () {
    if [ $ARGIND -lt ${#SCRIPT_ARGS[@]} ]
    then
        ARGUMENT="${SCRIPT_ARGS[${ARGIND}]}"
        ((ARGIND++))
        export ARGIND ARGUMENT
        return 0
    else return 1
    fi
}

#### getlastargument ()
## echoes the last script argument
getlastargument () {
    if [ ${#SCRIPT_ARGS[@]} -gt 0 ]; then
        echo "${SCRIPT_ARGS[${#SCRIPT_ARGS[@]}-1]}"; return 0;
    else return 1
    fi
}

#### rearrangescriptoptions ( "$@" )
## this will separate script options from script arguments (emulation of GNU "getopt")
## options are loaded in $SCRIPT_OPTS with their arguments
## arguments are loaded in $SCRIPT_ARGS
rearrangescriptoptions () {
    SCRIPT_OPTS=()
    SCRIPT_ARGS=()
    local oldoptind=$OPTIND
    local -a params=( "$@" )
    local numargs="${#params[@]}"
    local firstoptdone=false
    local firstchar
    local arg
    for i in "${!params[@]}"; do
        arg="${params[${i}]}"
        firstchar="${arg:0:1}"
        if [ "${firstchar}" != "-" ]
            then SCRIPT_ARGS+=( "$arg" )
            elif ! $firstoptdone; then firstoptdone=true;
        fi
        if ! $firstoptdone; then unset params["$i"]; fi
    done
    OPTIND=1
    local eoo=false
    while getopts ":${OPTIONS_ALLOWED}" OPTION "${params[@]}"; do
        OPTARG="${OPTARG#=}"
        local argindex=false
        case $OPTION in
            -) LONGOPT="`getlongoption \"${OPTARG}\"`"
               LONGOPTARG="`getlongoptionarg \"${OPTARG}\"`"
                case $OPTARG in
                    -) eoo=true; break;;
                    *) if ! $eoo; then
                        if [ ! -z "$LONGOPTARG" -a "${LONGOPT}" != "${LONGOPTARG}" ]; then
                            SCRIPT_OPTS+=( "--${LONGOPT} ${LONGOPTARG}" )
                            SCRIPT_ARGS=( "${SCRIPT_ARGS[@]//${LONGOPTARG}}" )
                        else
                            SCRIPT_OPTS+=( "--${LONGOPT}" )
                        fi
                    fi;;
                esac ;;
            *) if ! $eoo && [ "$OPTION" != '?' ]; then
                    if [ ! -z "$OPTARG" ]; then
                        SCRIPT_OPTS+=( "-${OPTION}${OPTARG}" )
                        SCRIPT_ARGS=( "${SCRIPT_ARGS[@]//${OPTARG}}" )
                    else
                        SCRIPT_OPTS+=( "-${OPTION}" )
                    fi
                fi;;
        esac
    done
    OPTIND=$oldoptind
    SCRIPT_ARGS=( $(array_filter "${SCRIPT_ARGS[@]}") )
    export SCRIPT_OPTS SCRIPT_ARGS
    return 0
}

#### parsecommonoptions_strict ( "$@" = SCRIPT_OPTS )
## parse common script options as described in $COMMON_OPTIONS_INFO throwing an error for unknown options
## this will stop options treatment at '--'
parsecommonoptions_strict () {
    if [ $# -gt 0 ]
        then parsecommonoptions "$@"
        else parsecommonoptions
    fi
    local oldoptind=$OPTIND
    OPTIND=1
    local -a short_options=( $(getshortoptionsarray) )
    local -a long_options=( $(getlongoptionsarray) )
    while getopts ":${OPTIONS_ALLOWED}" OPTION; do
        if [ "$OPTION" = '-' ]
        then LONGOPT="`getlongoption \"${OPTARG}\"`"
            if ! $(in_array "$LONGOPT" "${long_options[@]}"); then
                simple_error "unknown option '$LONGOPT'"
            fi
        else
            if ! $(in_array "$OPTION" "${short_options[@]}"); then
                simple_error "unknown option '$OPTION'"
            fi
        fi
    done
    OPTIND=$oldoptind
    export OPTIND
    return 0
}

#### parsecommonoptions ( "$@" = SCRIPT_OPTS )
## parse common script options as described in $COMMON_OPTIONS_INFO
## this will stop options treatment at '--'
parsecommonoptions () {
    local oldoptind=$OPTIND
    local actiontodo
    if [ $# -gt 0 ]
        then local options=("$@")
        else local options=("${SCRIPT_OPTS[@]}")
    fi
    while getopts ":${OPTIONS_ALLOWED}" OPTION "${options[@]}"; do
        OPTARG="`getoptionarg \"${OPTARG}\"`"
        case $OPTION in
        # common options
            h) if [ -z $actiontodo ]; then actiontodo='help'; fi;;
            i) export INTERACTIVE=true; export QUIET=false;;
            v) export VERBOSE=true; export QUIET=false;;
            f) export FORCED=true;;
            x) export DEBUG=true;;
            q) export VERBOSE=false; export INTERACTIVE=false; export QUIET=true;;
            d) setworkingdir $OPTARG;;
            l) setlogfilename $OPTARG;;
            V) if [ -z $actiontodo ]; then actiontodo='version'; fi;;
            -) LONGOPTARG="`getlongoptionarg \"${OPTARG}\"`"
                case $OPTARG in
        # common options
                    help) if [ -z $actiontodo ]; then actiontodo='help'; fi;;
                    usage) if [ -z $actiontodo ]; then actiontodo='usage'; fi;;
                    man) if [ -z $actiontodo ]; then actiontodo='man'; fi;;
                    vers|version) if [ -z $actiontodo ]; then actiontodo='version'; fi;;
                    interactive) export INTERACTIVE=true; export QUIET=false;;
                    verbose) export VERBOSE=true; export QUIET=false;;
                    force) export FORCED=true;;
                    debug) export DEBUG=true;;
                    dry-run) export DRYRUN=true; verecho "- debug option enabled: commands shown as 'debug >> \"cmd\"' are not executed";;
                    quiet) export VERBOSE=false; export INTERACTIVE=false; export QUIET=true;;
                    working-dir*) setworkingdir $LONGOPTARG;;
                    log*) setlogfilename $LONGOPTARG;;
        # library options
                    libvers|lib-vers|libversion|lib-version) if [ -z $actiontodo ]; then actiontodo='libversion'; fi;;
        # no error for others
                    *) 
                        if [ -n "$LONGOPTARG" -a "`which $OPTARG`" ]; then
                            SCRIPT_PROGRAMS+=( "${OPTARG}" )
                            export SCRIPT_PROGRAMS
                        fi
                    rien=rien;;
                esac ;;
            *) rien=rien;;
        esac
    done
    OPTIND=$oldoptind
    export OPTIND
    if [ ! -z $actiontodo ]; then
        case $actiontodo in
            help) clear; usage; exit 0;;
            usage) simple_usage; exit 0;;
            man) manpage; exit 0;;
            version) script_version $QUIET; exit 0;;
            libversion) library_version $QUIET; exit 0;;
        esac
    fi
    return 0
}


#### SCRIPT INFOS #####################################################################

#### version ( quiet = false )
version () {
    local gitvers=$(gitversion)
    if [ -n "$gitvers" ]
        then echo "$gitvers"
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
    local gitvers=$(gitversion)
    if [ -n "$gitvers" ]; then
        _echo "[$gitvers]"
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
    local USAGESTR=""
    if [ ! "x${USAGE}" = 'x' -a "$lib_info" == 'true' ]; then
        USAGESTR+=$(title)
        USAGESTR+=$(parsecolortags "\n$USAGE\n")
        USAGESTR+=$(parsecolortags "\n<${COLOR_COMMENT}>${TMP_VERS}</${COLOR_COMMENT}>")
    else
        local TMP_TITLE="${NAME:-?}"
        if [ -n "$VERSION" ]; then TMP_TITLE="${TMP_TITLE} - v. [${VERSION}]"; fi
        local TMP_USAGE="\n<bold>NAME</bold>\n\t<bold>${TMP_TITLE}</bold>";
        if [ -n "$PRESENTATION" ]; then
            TMP_USAGE+="\n\t${PRESENTATION}";
        fi
        TMP_USAGE+="\n";
        for section in "${MANPAGE_INFOS[@]}"; do
            eval "section_ctt=\"\$$section\""
            if [ "$section" != 'NAME' -a -n "$section_ctt" ]; then
                TMP_USAGE+="\n<bold>${section}</bold>\n\t${section_ctt}\n";
            fi
        done
        if ! ${MANPAGE_NODEPEDENCY:-false}; then
            if [ "$lib_info" == 'true' ]; then
                TMP_USAGE+="\n<bold>DEPENDENCIES</bold>\n\t${LIB_DEPEDENCY_INFO}\n";
            fi
        fi
        TMP_USAGE+="\n<${COLOR_COMMENT}>${TMP_VERS}</${COLOR_COMMENT}>";
        USAGESTR+=$(parsecolortags "$TMP_USAGE")
    fi
    local _done=false
    if [ "${#SCRIPT_PROGRAMS[@]}" -gt 0 ]; then
        local _tmpfile=$(gettempfilepath "`getfilename $0`.usage")
        if $(in_array "less" "${SCRIPT_PROGRAMS[@]}"); then
            echo "$USAGESTR" > "$_tmpfile"
            cat "$_tmpfile" | less -cfre~
            _done=true
        elif $(in_array "more" "${SCRIPT_PROGRAMS[@]}"); then
            echo "$USAGESTR" > "$_tmpfile"
            cat "$_tmpfile" | more -cf
            _done=true
        fi
    fi
    if ! $_done; then echo "${USAGESTR}"; fi
    return 0;
}

#### manpage ( cmd = $0 , section = 3 )
## will open the manpage of $0 if found in system manpages or if `$0.man` exists
## else will trigger 'usage' method
manpage () {
    local cmd="${1:-${0}}"
    local cmd_filename=$(getfilename "$cmd")
    local cmd_localman="${cmd%.*}.man"
    local section="${2:-3}"
    if $(man -w -s "$section" "$cmd_filename" 2> /dev/null); then
        man -s "$section" "$cmd_filename"
    elif [ -f $cmd_localman ]; then
        man "./${cmd_localman}"
    else
        quietecho "- no manpage for '$cmd' ; running 'help'"
        clear; usage
    fi
    return 0
}

#### script_shortversion ( quiet = false )
script_shortversion () {
    local bequiet="${1:-false}"
    if $bequiet; then
        echo "${VERSION:-?}"
        return 0
    fi
    local TMP_STR="${VERSION}"
    if [ -n "$VERSION" ]; then
        if [ -n "$NAME" ]
            then TMP_STR="${NAME} ${TMP_STR}"
            else TMP_STR="${0} ${TMP_STR}"
        fi
        if [ -n "$DATE" ]; then TMP_STR+=" - ${DATE}"; fi
        local gitvers=$(gitversion)
        if [ -n "$gitvers" ]; then TMP_STR+=" - ${gitvers}"; fi
        echo "${TMP_STR}"
    fi
    return 0;
}

#### script_version ( quiet = false )
script_version () {
    local bequiet="${1:-false}"
    if $bequiet; then
        echo "${VERSION:-?}"
        return 0
    fi
    script_shortversion
    for section in "${VERSION_INFOS[@]}"; do
        case $section in
            NAME|VERSION|DATE);;
            *) if [ -n "${!section}" ]; then echo "${!section}"; fi;;
        esac
    done
    return 0;
}

#### build_documentation ( type = TERMINAL , output = null , source = BASH_SOURCE[0] )
build_documentation () {
    local type="${1:-TERMINAL}"
    local output="${2}"
    local source="${3:-${BASH_SOURCE[0]}}"
    local type_var="DOCBUILDER_`strtoupper ${type}`_MASKS"
    if [ -z "${!type_var}" ]; then
        error "unknown doc-builder type '${type}'"
    fi
    eval "export DOCBUILDER_MASKS=( \"\${${type_var}[@]}\" )"
    verecho "- generating documentation in format '$type' from file '${source}'"
    generate_documentation "${source}" "${output}"
    return 0
}

#### generate_documentation ( filepath = BASH_SOURCE[0] , output = null )
generate_documentation () {
    local sourcefile="${1:-${BASH_SOURCE[0]}}"
    if [ ! -f $sourcefile ]; then patherror "$sourcefile"; fi
    local output="${2}"
    local docstr=""
    if [ -n "$DOCUMENTATION_TITLE" ]
        then docstr="# ${DOCUMENTATION_TITLE}"
        else docstr="# Documentation of '$sourcefile'"
    fi
    if [ -n "$DOCUMENTATION_INTRO" ]; then
        docstr+="\n\n${DOCUMENTATION_INTRO}\n\n----\n";
    fi
    i=0
    old_IFS=$IFS
    IFS=$'\n'
    local indoc=false
    local intag=false
    for line in $(cat $sourcefile); do
        if [ "$line" == "${DOCBUILDER_MARKER}" ]; then
            if $indoc; then indoc=false; break; else indoc=true; fi
            continue;
        fi
        line_str=""
        fct_line=$(echo "$line" | grep -o "${DOCBUILDER_RULES[0]}" | sed "${DOCBUILDER_MASKS[0]}")
        if [ $indoc -a -n "$fct_line" ]; then
            line_str="$fct_line"
            intag=true
        elif $indoc; then
            title_line=$(echo "$line" | grep -o "${DOCBUILDER_RULES[1]}" | sed "${DOCBUILDER_MASKS[1]}")
            if [ -n "$title_line" ]; then
                line_str="$title_line (line ${i})\n"
            elif $intag; then
                arg_line=$(echo "$line" | grep -o "${DOCBUILDER_RULES[2]}" | sed "${DOCBUILDER_MASKS[2]}")
                comm_line=$(echo "$line" | grep -o "${DOCBUILDER_RULES[3]}" | sed "${DOCBUILDER_MASKS[3]}")
                if $VERBOSE; then
                    if [ -n "$arg_line" ]; then
                        line_str="$arg_line"
                    else
                        if [ -n "$comm_line" ]
                        then line_str="$comm_line"
                        else intag=false;
                        fi
                    fi
                else
                    if [ -n "$arg_line" -a -n "$comm_line" ]; then intag=false; fi
                fi
            else
                intag=false;
                arg_line=$(echo "$line" | grep -o "${DOCBUILDER_RULES[4]}" | sed "${DOCBUILDER_MASKS[4]}")
                if [ -n "$arg_line" ]; then line_str="$arg_line"; fi
            fi
        fi
        if [ -n "$line_str" ]; then docstr+="\n${line_str}"; fi
        i=$(($i+1))
    done
    IFS=$old_IFS
    now=`date '+%d-%-m-%Y %X'`
    docstr+="\n\n----\n\n[*Doc generated at ${now} from path '${sourcefile}'*]"
    if [ -n "$output" ]
        then _echo "${docstr}" > "${output}"
        else _echo "${docstr}"
    fi
    return 0
}


#### LIBRARY INFOS #####################################################################

#### get_gitversion ( path = $0 )
## extract the GIT version string from a file matching line 'LIB_GITVERSION=...'
get_gitversion () {
    local fpath="${1:-$0}"
    if [ ! -f "${fpath}" ]; then error "file '${fpath}' not found!"; fi
    echo $(head -n200 "${fpath}" | grep -o -e "LIB_GITVERSION=\".*\"" | sed "s|^LIB_GITVERSION=\"\(.*\)\"$|\1|g") && return 0 || return 1
}

#### gitversion_extract_sha ( gitversion_string )
## get last commit sha from a GIT version string
gitversion_extract_sha () {
    if [ $# -gt 0 ]; then
        echo "$1" | cut -d'@' -f 2
        return 0
    fi
    return 1
}

#### gitversion_extract_branch ( gitversion_string )
## get the branch name from a GIT version string
gitversion_extract_branch () {
    if [ $# -gt 0 ]; then
        echo "$1" | cut -d'@' -f 1
        return 0
    fi
    return 1
}

#### library_info ()
library_info () {
    echo "`library_shortversion`"
    return 0;
}

#### library_shortversion ( quiet = false )
## this function must echo an information about library name & version
library_shortversion () {
    local bequiet="${1:-false}"
    if $bequiet; then
        echo "${LIB_VERSION}"
        return 0
    fi
    local TMP_VERS="${LIB_NAME} ${LIB_VERSION} - ${LIB_DATE}"
    local LIB_MODULE="`dirname $LIBRARY_REALPATH`/.."
    local _done=false
    if $(isgitclone "$LIB_MODULE" "$LIB_HOME"); then
        add=$(gitversion)
        if [ -n "$add" ]; then
            _done=true
            TMP_VERS+=" - ${add}"
        fi
    fi
    if ! $_done; then
        TMP_VERS+=" - `get_gitversion \"${BASH_SOURCE}\"`"
    fi
    echo "${TMP_VERS}"
    return 0
}

#### library_version ( quiet = false )
## this function must echo an FULL information about library name & version (GNU like)
library_version () {
    local bequiet="${1:-false}"
    if $bequiet; then
        echo "${LIB_VERSION}"
        return 0
    fi
    library_shortversion
    for section in "${VERSION_INFOS[@]}"; do
        case $section in
            NAME|VERSION|DATE);;
            *)
                local libsection="LIB_${section}"
                if [ -n "${!libsection}" ]; then echo "${!libsection}"; fi;;
        esac
    done
    return 0
}

#### library_debug ( "$*" )
## see all common options flags values & some debug infos
library_debug () {
    OPTIND=1
    local TOP_STR=" \$ $0 ${ORIGINAL_SCRIPT_OPTS}"
    if [ "$*" != "${ORIGINAL_SCRIPT_OPTS}" ]; then
        TOP_STR="${TOP_STR}\n re-arranged in:\n \$ $0 $*"
    fi
    local TMP_DEBUG_MASK=" \n\
---- DEBUG -------------------------------------------------------------\n\
${TOP_STR}\n\
------------------------------------------------------------------------\n\
- %s is set on %s\n\
- %s is set on %s\n\
- %s mode is %s (option '%s')\n\
- %s mode is %s (option '%s')\n\
- %s mode is %s (option '%s')\n\
- %s mode is %s (option '%s')\n\
- %s mode is %s (option '%s')\n\
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
        "$?" "$$" "`whoami`" "`getsysteminfo`";
    _echo "$TMP_DEBUG"
    parsecolortags "<${COLOR_COMMENT}>`library_info`</${COLOR_COMMENT}>";
    return 0
}

#### / libdebug ( "$*" )
## alias of library_debug
libdebug () {
    library_debug "$*"
}


##@ LIBRARY_REALPATH
declare -rx LIBRARY_REALPATH=$(realpath ${BASH_SOURCE[0]})

#### COMPATIBILITY #####################################################################
# to be deleted in next major version !!


##@!@##
##########################################################################################
# Internal API
##########################################################################################

# this MUST only be parsed when calling the lib directly
# any method of the internal api is prefixed by `intlib_`
if [ "`basename $0`" != "`basename ${BASH_SOURCE[0]}`" ]; then return 0; fi
#echo "BASH LIBRARY !!!"

declare -x INTLIB_REALPATH="`realpath $BASH_SOURCE`"
declare -x INTLIB_REALPATH_DIR="`dirname $INTLIB_REALPATH`"
declare -x INTLIB_BASEDIR="`dirname $INTLIB_REALPATH_DIR`"
declare -x INTLIB_SOURCE="`basename $INTLIB_REALPATH`"
declare -x INTLIB_DEVDOC_FILENAME="${LIB_FILENAME_DEFAULT}-DOC.md"
declare -x INTLIB_README_FILENAME="${LIB_FILENAME_DEFAULT}-README.md"
declare -x INTLIB_MAN_FILENAME="${LIB_FILENAME_DEFAULT}.man"
declare -x INTLIB_PRESET='default'
declare -x INTLIB_BRANCH='master'
# days to make automatic version check
declare -x INTLIB_OUTDATED_CHECK=30
# days to force user update (message is always shown)
declare -x INTLIB_OUTDATED_FORCE=90
declare -x INTLIB_HOMEDIR="${HOME}/.${LIB_FILENAME_DEFAULT}"
declare -x INTLIB_CLONEDIR="${INTLIB_HOMEDIR}/cache"
declare -rxa INTLIB_PRESET_ALLOWED=( default dev user full )
declare -rxa INTLIB_ACTION_ALLOWED=( install uninstall check update vers version help usage \
selfupdate self-update doc documentation mddoc mddocumentation selfvers selfversion self-vers self-version )
declare -x INTLIB_TARGET
declare -x INTLIB_TARGET_BRANCH
declare -x INTLIB_TARGET_GITVERSION

# script man infos
MANPAGE_NODEPEDENCY=true
for section in "${MANPAGE_INFOS[@]}"; do eval "$section=\$LIB_$section"; done
for section in "${SCRIPT_INFOS[@]}"; do eval "$section=\$LIB_$section"; done
for section in "${VERSION_INFOS[@]}"; do eval "$section=\$LIB_$section"; done
OPTIONS_ALLOWED="b:t:p:${COMMON_OPTIONS_ALLOWED}"
LONG_OPTIONS_ALLOWED="branch:,target:,preset:,${COMMON_LONG_OPTIONS_ALLOWED}"
INTLIB_PRESET_INFO=""
for pres in "${INTLIB_PRESET_ALLOWED[@]}"; do
    INTLIB_PRESET_INFO="${INTLIB_PRESET_INFO} '<bold>${pres}</bold>'"
done
DESCRIPTION="<bold>Bash</bold>, the \"<${COLOR_NOTICE}>Bourne-Again-SHell</${COLOR_NOTICE}>\", is a <underline>Unix shell</underline> written for the GNU Project as a free software replacement for the original Bourne shell (sh). \n\
\tThe present library is a tool for Bash scripts facilities.\n\
\tTo use the library, just include its source file using: \`<bold>source path/to/piwi-bash-library.sh</bold>\` and call its methods.\n\n\
\tA direct call of the library is an interface to manage a copy of this script using one of the following actions:\n\
\t<bold>install</bold>\t\t\t\tinstall a copy locally or in your system\n\
\t<bold>version</bold>\t\t\t\tget a copy version infos ; use option '-q' to get only the version number\n\
\t<bold>check</bold>\t\t\t\tcheck if a copy is up-to-date\n\
\t<bold>update</bold>\t\t\t\tupdate a copy with newer version if so\n\
\t<bold>uninstall</bold>\t\t\tuninstall a copy from a system path\n\
\t<bold>selfupdate</bold> | <bold>self-update</bold>\tupdate this library script (\$0) with newer version if so\n\
\t<bold>selfvers</bold> | <bold>self-version</bold>\t\tget this library script (\$0) version infos ; use option '-q' to get only the version number\n\
\t<bold>doc</bold> | <bold>documentation</bold>\t\tsee the library documentation ; use option '-v' to increase verbosity\n\n\
\tTry 'man piwi-bash-library(.sh)' or '$0 --man' for the library full manpage.";
OPTIONS="<bold>-t | --target=PATH</bold>\t\tdefine the target directory ('PATH' must exist - will be prompted if absent)\n\
\t<bold>-p | --preset=TYPE</bold>\t\tdefine a preset for an installation ; can be ${INTLIB_PRESET_INFO}\n\
\t<bold>-b | --branch=NAME</bold>\t\tdefine the GIT branch to use from the library remote repository (default is '${INTLIB_BRANCH}')\n\n\
\t<underline>Common options</underline> available for any script using the library:\n\
\t${COMMON_OPTIONS_FULLINFO}";
SYNOPSIS_ERROR=" ${0}  [-${COMMON_OPTIONS_ALLOWED_MASK}] ... \n\
\t[-t | --target=path]  ...\n\
\t[-b | --branch=branch]  ...\n\
\t[-p | --preset= (${INTLIB_PRESET_ALLOWED[@]}) ]  ...\n\
\thelp | usage\n\
\tcheck\n\
\tvers | version\n\
\tinstall\n\
\tupdate\n\
\tuninstall\n\
\tselfupdate | self-update\n\
\tselfversion | self-version\n\
\tdoc | documentation\n\
";
FILES="The following files are installed by default:\n\
\t<underline>${INTLIB_SOURCE}</underline>\t\tthe standalone library source file \n\
\t<underline>${INTLIB_MAN_FILENAME}</underline>\t\tthe manpage of the library, installed in section 3 of system manpages for a global installation\n\n\
\tThe following files can be installed using the 'preset' option:\n\
\t<underline>${INTLIB_README_FILENAME}</underline>\tthe README of the library (Markdown syntax - installed in 'user' and 'full' presets)\n\
\t<underline>${INTLIB_DEVDOC_FILENAME}</underline>\ta full documentation of the library (Markdown syntax - installed in 'dev' and 'full' presets)";
declare -x DOCUMENTATION_TITLE="Piwi Bash Library documentation\n\n[*`library_info`*]"
declare -x DOCUMENTATION_INTRO="\
Package [${LIB_PACKAGE}] version [${LIB_VERSION}].\n\
${LIB_COPYRIGHT_TYPE} - Some rights reserved. \n\
${LIB_LICENSE_TYPE}.\n\
${LIB_SOURCES_TYPE}.\n\
Bug reports: <http://github.com/atelierspierrot/piwi-bash-library/issues>.\n\
${LIB_ADDITIONAL_INFO}";

# internal API methods

# -> unknown option 
intlib_optionerror () {
    simple_error "unknown option '$1'"
}

# -> check preset validity
preset_valid () {
    in_array "$INTLIB_PRESET" "${INTLIB_PRESET_ALLOWED[@]}" || simple_error "unknown preset '$INTLIB_PRESET'!";
    return 0
}

# -> which target
target_required () {
    if [ -z "$INTLIB_TARGET" ]; then
        simple_error "unknown target path '$INTLIB_TARGET'! (use option '-t')"
    fi
    if [ ! -d "$INTLIB_TARGET" ]; then
        mkdir $INTLIB_TARGET || simple_error "target path '$INTLIB_TARGET' not found and can't be created!"
    fi
    return 0
}

# -> get the gitversion string from INTLIB_TARGET
get_target_gitversion () {
    get_gitversion "${INTLIB_TARGET}/piwi-bash-library.sh"
    return 0
}

# -> get the gitversion from current temp clone
get_clone_gitversion () {
    get_gitversion "${INTLIB_CLONEDIR}/src/piwi-bash-library.sh"
    return 0
}

# -> get the real GIT gitversion from a repo
## get_real_gitversion ( path = INTLIB_CLONEDIR )
get_real_gitversion () {
    local oldpwd=$(pwd)
    local clonedir="${1:-${INTLIB_CLONEDIR}}"
    cd "${clonedir}" && gitversion && cd "${oldpwd}"
}

# -> get the last GIT commit SHA from the remote in branch
## get_remoteversion ( branch = HEAD )
get_remoteversion () {
    local branch="${1:-HEAD}"
    git ls-remote "${LIB_HOME}" | awk "/${branch}/ {print \$1}"
}

# -> make dir '$HOME/.piwi-bash-library' if it doesn't exist
make_homedir () {
    if [ ! -d "${INTLIB_CLONEDIR}" ]; then mkdir "${INTLIB_HOMEDIR}"; fi
    return 0
}

# -> make lib clone
make_clone () {
    local tocreate=true
    if [ -d "${INTLIB_CLONEDIR}" ]; then
        if `isgitclone "${INTLIB_CLONEDIR}" "${LIB_HOME}"`; then tocreate=false; fi
    fi
    if $tocreate; then
        rm -rf "${INTLIB_CLONEDIR}" && mkdir "${INTLIB_CLONEDIR}"
        local gitcmd=$(which git)
        if [ -z $gitcmd ]; then commanderror 'git'; fi
        verecho "- cloning library into '${INTLIB_CLONEDIR}' ..."
        git clone -q "${LIB_HOME}" "${INTLIB_CLONEDIR}"
    fi
    return 0
}

# -> update lib clone
update_clone () {
    local gitcmd=$(which git)
    if [ -z $gitcmd ]; then commanderror 'git'; fi
    verecho "- updating library clone in '${INTLIB_CLONEDIR}' ..."
    iexec "git pull -q \"${INTLIB_CLONEDIR}\""
    return 0
}

# -> change lib clone branch
change_branch () {
    local gitcmd=$(which git)
    local oldpwd=$(pwd)
    if [ -z $gitcmd ]; then commanderror 'git'; fi
    verecho "- switching library clone branch '${INTLIB_BRANCH}' in '${INTLIB_CLONEDIR}' ..."
    iexec "cd ${INTLIB_CLONEDIR} && git checkout -q \"${INTLIB_BRANCH}\" && git pull"
    cd $oldpwd
    return 0
}

# -> do update or install target files
do_update () {
    local installcmd=""
    installcmd+="cp -f '${INTLIB_CLONEDIR}/src/piwi-bash-library.sh' '${INTLIB_TARGET}/piwi-bash-library.sh'"
    installcmd+=" && cp -f '${INTLIB_CLONEDIR}/src/piwi-bash-library.man' '${INTLIB_TARGET}/piwi-bash-library.man'"
    if [ "$INTLIB_PRESET" = 'dev' -o "$INTLIB_PRESET" = 'full' ]; then
        installcmd+=" && cp -f '${INTLIB_CLONEDIR}/DOCUMENTATION.md' '${INTLIB_TARGET}/piwi-bash-library-DOC.md'"
    fi
    if [ "$INTLIB_PRESET" = 'user' -o "$INTLIB_PRESET" = 'full' ]; then
        installcmd+=" && cp -f '${INTLIB_CLONEDIR}/README.md' '${INTLIB_TARGET}/piwi-bash-library-README.md'"
    fi
    iexec "$installcmd"
    return 0
}

# -> do uninstall target files
do_uninstall () {
    local installcmd=""
    installcmd+="rm -f '${INTLIB_TARGET}/piwi-bash-library.sh'"
    installcmd+=" '${INTLIB_TARGET}/piwi-bash-library.man'"
    if [ -f "${INTLIB_TARGET}/piwi-bash-library-DOC.md" ]; then
        installcmd+=" '${INTLIB_TARGET}/piwi-bash-library-DOC.md'"
    fi
    if [ -f "${INTLIB_TARGET}/piwi-bash-library-README.md" ]; then
        installcmd+=" '${INTLIB_TARGET}/piwi-bash-library-README.md'"
    fi
    iexec "$installcmd"
    return 0
}


# action doc
intlibaction_documentation () {
    build_documentation
    return 0
}

intlibaction_documentation_tomd () {
    build_documentation 'markdown'
    return 0
}

intlibaction_check () {
    target_required
    # target
    local targetvers=$(get_target_gitversion)
    local targetvers_sha=$(gitversion_extract_sha "${targetvers}")
    local targetvers_branch=$(gitversion_extract_branch "${targetvers}")
    if [ "${targetvers_branch}" != 'master' ]; then
        export INTLIB_BRANCH="${targetvers_branch}"
    fi
    # distant GIT
    if [ "${INTLIB_BRANCH}" = 'master' ]
        then local remotevers_sha=$(get_remoteversion);
        else local remotevers_sha=$(get_remoteversion "${INTLIB_BRANCH}");
    fi
    if [ "${targetvers_sha}" != "${remotevers_sha}" ]
        then echo "New version available ..."; return 1;
        else echo "Up-to-date"; touch "${INTLIB_TARGET}/piwi-bash-library.sh";
    fi
    return 0
}

intlibaction_install () {
    target_required
    preset_valid
    make_homedir
    make_clone
    if [ "${INTLIB_BRANCH}" != 'master' ]; then change_branch; fi;
    do_update
    quietecho ">> ok, library installed in '${INTLIB_TARGET}'"
    return 0
}

intlibaction_update () {
    target_required
    preset_valid
    make_homedir
    make_clone
    if [ "${INTLIB_BRANCH}" != 'master' ]; then change_branch; fi;
    do_update
    quietecho ">> ok, library updated in '${INTLIB_TARGET}'"
    return 0
}

intlibaction_uninstall () {
    target_required
    preset_valid
    do_uninstall
    quietecho ">> ok, library deleted from '${INTLIB_TARGET}'"
    return 0
}

intlibaction_version () {
    target_required
    if $QUIET
        then "${INTLIB_TARGET}/piwi-bash-library.sh" -q selfvers;
        else "${INTLIB_TARGET}/piwi-bash-library.sh" selfvers;
    fi
    return 0
}

intlibaction_help () {
    clear; usage; return 0
}

intlibaction_usage () {
    simple_usage; return 0
}

intlibaction_selfupdate () {
    local _target="$0"
    export INTLIB_TARGET=`dirname $_target`
    make_homedir
    make_clone
    if [ "${INTLIB_BRANCH}" != 'master' ]; then change_branch; fi;
    do_update
    quietecho ">> ok, library updated"
    return 0
}

intlibaction_selfversion () {
    library_version $QUIET
    return 0
}

intlib_check_uptodate () {
    if $QUIET; then return 0; fi
    local now=$(date +%s)
    local fmdate
    if `in_array $USEROS ${LINUX_OS[@]}`
        then fmdate=$(stat -c %y "$0")
        else fmdate=$(stat -f "%m" "$0")
    fi
    local checkdiff=$(($now-$fmdate))
    # simple check
    local ts_limit=$(($INTLIB_OUTDATED_CHECK*24*60*60))
    if [ $checkdiff -gt $ts_limit ]; then
        export INTLIB_TARGET="`dirname $0`"
        if ! `intlibaction_check 1> /dev/null`; then
            info "This library version is more than ${INTLIB_OUTDATED_CHECK} days old and a newer version is available ... You should run '$0 selfupdate' to update it.";
        fi
    fi
    # forced check
    local ts_limit_forced=$(($INTLIB_OUTDATED_FORCE*24*60*60))
    if [ $checkdiff -gt $ts_limit_forced ]; then
        info "This library version is more than ${INTLIB_OUTDATED_FORCE} days old ... You should run '$0 selfupdate' to get last version.";
    fi
    return 0
}

# local clonevers=$(get_clone_gitversion)
# local clonevers_sha=$(gitversion_extract_sha "${clonevers}")
# local clonevers_branch=$(gitversion_extract_branch "${clonevers}")
# echo "clone: '$clonevers' ; branch: '$clonevers_branch' ; sha: '$clonevers_sha'"
# local realvers=$(get_real_gitversion)
# local realvers_sha=$(gitversion_extract_sha "${realvers}")
# local realvers_branch=$(gitversion_extract_branch "${realvers}")
# echo "real: '$realvers' ; branch: '$realvers_branch' ; sha: '$realvers_sha'"

# check last updates
intlib_check_uptodate

# parsing options
rearrangescriptoptions "$@"
[ "${#SCRIPT_OPTS[@]}" -gt 0 ] && set -- "${SCRIPT_OPTS[@]}";
[ "${#SCRIPT_ARGS[@]}" -gt 0 ] && set -- "${SCRIPT_ARGS[@]}";
[ "${#SCRIPT_OPTS[@]}" -gt 0 -a "${#SCRIPT_ARGS[@]}" -gt 0 ] && set -- "${SCRIPT_OPTS[@]}" -- "${SCRIPT_ARGS[@]}";
parsecommonoptions_strict
OPTIND=1
while getopts ":${OPTIONS_ALLOWED}" OPTION; do
    OPTARG="${OPTARG#=}"
    case $OPTION in
        h|f|i|q|v|x|V|d|l) ;;
        t) export INTLIB_TARGET="${OPTARG}";;
        p) export INTLIB_PRESET="${OPTARG}";;
        b) export INTLIB_BRANCH="${OPTARG}";;
        -) LONGOPTARG="`getlongoptionarg \"${OPTARG}\"`"
            case $OPTARG in
                target*) export INTLIB_TARGET="${LONGOPTARG}";;
                preset*) export INTLIB_PRESET="${LONGOPTARG}";;
                branch*) export INTLIB_BRANCH="${LONGOPTARG}";;
                ?) ;;
            esac ;;
        ?) ;;
    esac
done
getnextargument
ACTION="$ARGUMENT"

# checking env
# -> action is required
if [ -z $ACTION ]; then simple_error 'nothing to do'; fi
# -> check action validity
in_array "$ACTION" "${INTLIB_ACTION_ALLOWED[@]}" || simple_error "unknown action '$ACTION'!";

# prepare
INTLIB_TARGET="${INTLIB_TARGET/\~/${HOME}}"

# executing action
if $DEBUG; then library_debug "$*"; fi
case $ACTION in
    check) intlibaction_check; exit 0;;
    install) intlibaction_install; exit 0;;
    update) intlibaction_update; exit 0;;
    uninstall) intlibaction_uninstall; exit 0;;
    vers|version) intlibaction_version; exit 0;;
    help) intlibaction_help; exit 0;;
    usage) intlibaction_usage; exit 0;;
    self-update|selfupdate) intlibaction_selfupdate; exit 0;;
    self-vers*|selfvers*) intlibaction_selfversion; exit 0;;
    doc*) intlibaction_documentation; exit 0;;
    mddoc*) intlibaction_documentation_tomd; exit 0;;
    *) ;;
esac

# Endfile
# vim: autoindent tabstop=2 shiftwidth=2 expandtab softtabstop=2 filetype=sh
