#!/bin/bash
# global test

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

declare -x _DOC_FILENAME='documentation.md'
declare -x _TARGET
declare -x _META
declare -x _TOC=true
# the error status (numeric)
declare -x _ERRSTATUS
# the error string (string)
declare -x _ERRSTR

NAME="Bash-Lib Text documentation generator"
VERSION="0.0.1-dev"
DESCRIPTION="A simple tool to build the library's doc in a plain text file (using Markdown syntax)."
SYNOPSIS="$LIB_SYNOPSIS"
OPTIONS="<bold>-t | --target=PATH</bold>\tproject path (default is empty)\n\
\t<bold>-o | --output=NAME</bold>\tfilename of the generated documentaiont (default is '${_DOC_FILENAME}')\n\
\t<bold>-m | --meta=META</bold>\tsome meta-data added at the head of the file\n\
\t<bold>--no-toc</bold>\t\tdisable default insertion of a 'table of content'\n\
\n\
\t${COMMON_OPTIONS_INFO}";
MANPAGE_NODEPEDENCY=true

#### targetdir_required ()
# ensure the project target directory is defined
targetdir_required () {
    if [ -z "$_TARGET" ]; then
        prompt 'Target directory of the project to work on' `pwd` ''
        export _TARGET=$USERRESPONSE
    fi
    if [ ! -d "$_TARGET" ]; then
        export _ERRSTR="Unknown target directory '${_TARGET}' !"
        export _ERRSTATUS="${E_PATH}"
    fi
    send_error
    return 0
}

#### send_error ()
## send the error if _ERRSTR is not empty and then exists
send_error () {
    if [ ! -z "$_ERRSTR" ]; then
        error "$_ERRSTR" $_ERRSTATUS
        exit $_ERRSTATUS
    fi
    return 0
}

parsecommonoptions "$@"
verecho "_ go"

OPTIND=1
while getopts "m:o:t:${COMMON_OPTIONS_ARGS}" OPTION; do
    OPTARG="${OPTARG#=}"
    case $OPTION in
        o) _DOC_FILENAME=$OPTARG;;
        t) _TARGET=$OPTARG;;
        m) _META="${_META}${OPTARG}";;
        -) LONGOPTARG="`getlongoptionarg \"${OPTARG}\"`"
            case $OPTARG in
                output*) _DOC_FILENAME=$OPTARG;;
                target*) _TARGET=$LONGOPTARG;;
                meta*) _META="${_META}${LONGOPTARG}";;
                no-toc) _TOC=false;;
                \?) error "Unknown long option '$OPTARG'";;
            esac ;;
        d|f|h|i|l|q|v|V|x) rien=rien;;
        \?) error "Unknown option '$OPTION'";;
    esac
done

targetdir_required

docstr="";
if [ ! -z "$_META" ]; then
    docstr="${docstr}${_META}\n\n"
fi
docstr="${docstr}# Library documentation\n\n[*`library_info`*]"
if $_TOC; then
    docstr="${docstr}\n\n{% TOC %}"
fi

docstr="${docstr}\n\nPackage [**${LIB_PACKAGE}**] version [**${LIB_VERSION}**]. \n\n\
Licensed under ${LIB_LICENSE} - Copyleft (c) ${LIB_AUTHOR} - Some rights reserved. \n\n\
For sources & updates, see <${LIB_HOME}>.\n\n\
For bug reports, see <${LIB_BUGS}>. \n\n\
To read ${LIB_LICENSE} license conditions, see <${LIB_LICENSE_URL}>.\n\n----\n";

i=0
old_IFS=$IFS
IFS=$'\n'
indoc=false
intag=false
for line in $(cat "${_TARGET}/bin/bash-library.sh"); do
    if [ "$line" == '##@!@##' ]; then
        if $indoc; then indoc=false; else indoc=true; fi
        continue;
    fi
    line_str=""
    fct_line=$(echo "$line" | grep -Po "^####.[^#]*$" | sed "s|^#### \(.* (.*)\)$|-   \*\*\1\*\*|g")
    if [ $indoc -a -n "$fct_line" ]; then
        line_str="\n$fct_line"
        intag=true
    elif $indoc; then
        title_line=$(echo "$line" | grep -Po "^####.[^#]*#*$" | sed "s|^#### \(.*\) #*$|\\\n\\\n## \1 (line ${i})|g")
        if [ -n "$title_line" ]; then
            line_str="$title_line"
        elif $intag; then
            arg_line=$(echo "$line" | grep -Po "^##@[^ ]* .*$" | sed "s|^##\(@.*\) \(.*\)$|\\\n    \1 \2|g")
            comm_line=$(echo "$line" | grep -Po "^##([^!]*)$" | sed "s|^##* \(.*\)$|\\\n    \1|g")
            if [ -n "$arg_line" ]; then
                line_str="$arg_line"
            else
                if [ -n "$comm_line" ]
                    then line_str="$comm_line"
                    else intag=false
                fi
            fi
        else
            intag=false
            arg_line=$(echo "$line" | grep -Po "^##@[^ ]* .*$" | sed "s|^##@\(.*\) \(.*\)$|\\\n-   \1 \2|g")
            if [ -n "$arg_line" ]; then line_str="$arg_line"; fi
        fi
    fi
    if [ -n "$line_str" ]; then docstr="${docstr}\n${line_str}"; fi
    i=$(($i+1))
done
IFS=$old_IFS

realpath="`realpath $BASH_SOURCE`"
realpath_dir="`dirname $realpath`"
basedir="`dirname $realpath_dir`"
pathdir="`getscriptpath ${basedir}/${_TARGET}/bin/bash-library.sh`"
now=`date '+%d-%-m-%Y %X'`
docstr="${docstr}\n\n----\n\n[*Doc generated at ${now} from path '${pathdir}/bash-library.sh'*]"

_echo "$docstr" > "${_TARGET}/bin/${_DOC_FILENAME}"
info "OK - Library's documentation generated in '${_TARGET}/bin/${_DOC_FILENAME}'"

verecho "_ ok"
exit 0

# Endfile
