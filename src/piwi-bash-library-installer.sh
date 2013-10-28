#!/bin/bash
#
# Bash Library - The open source bash library of Les Ateliers Pierrot
# Copyleft (c) 2013 Pierre Cassat and contributors
# <www.ateliers-pierrot.fr> - <contact@ateliers-pierrot.fr>
# License GPL-3.0 <http://www.opensource.org/licenses/gpl-3.0.html>
# Sources <http://github.com/atelierspierrot/piwi-bash-library>
# 
# piwi-bash-library-installer.sh

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

_REALPATH="`realpath $BASH_SOURCE`"
_REALPATH_DIR="`dirname $_REALPATH`"
declare -x _BASEDIR="`dirname $_REALPATH_DIR`"
declare -x _BIN_DIR="bin"
declare -x _TARGET
declare -x _SOURCE="${_BASEDIR}"
declare -x _DOC_FILENAME='piwi-bash-library-DOC.md'
declare -x _README_FILENAME='piwi-bash-library-README.md'
declare -x _GITVERS_FILENAME='piwi-bash-library-gitversion'
declare -x _META
declare -x _TOC=true
# the target up-to-date flag (bool)
declare -x _TARGET_UPTODATE=false
# other vars
declare -x TARGET_BRANCH TARGET_LASTCOMMIT SOURCE_LASTCOMMIT

# the error status (numeric)
declare -x _ERRSTATUS
# the error string (string)
declare -x _ERRSTR

NAME="Bash Library Installer"
BUGS="$LIB_BUGS"
AUTHOR="$LIB_AUTHOR"
DESCRIPTION="The installer/updater/uninstaller of the Bash-Library. \n\
\tThis will copy and manage a clone of the library script and its README in a binaries directory of a traget dir ; \n\
\tIt can also generate or update a documentation of the library code.";
SYNOPSIS="$LIB_SYNOPSIS_ACTION"
OPTIONS="\n\
<underline>Available actions:</underline>\n\
\t<bold>check</bold>\t\t\tcheck an installed clone\n\
\t<bold>install</bold>\t\t\tinstall a clone in a project\n\
\t<bold>update</bold>\t\t\tupdate an installed clone\n\
\t<bold>uninstall</bold>\t\tuninstall a clone from a project\n\
\t<bold>doc</bold>\t\t\twrite a documentation file of a current clone's library version\n\
\n\
<underline>Script options:</underline>\n\
\t<bold>-t | --target=PATH</bold>\tproject path (default is empty)\n\
\t<bold>-s | --source=PATH</bold>\tlibrary source root directory (default is 'pwd')\n\
\t<bold>--bindir=NAME</bold>\t\tthe binaries directory in the target where files will be cloned (default is '${_BIN_DIR}')\n\
\t<bold>--docname=NAME</bold>\t\tfilename of the generated documentation (default is '${_DOC_FILENAME}')\n\
\t<bold>--docmeta=META</bold>\t\tsome meta-data added at the head of the documentation\n\
\t<bold>--no-toc</bold>\t\tdisable default insertion of a 'table of contents' in the documentation\n\
\t${COMMON_OPTIONS_INFO}";
declare -rx SYNOPSIS_ERROR=" ${0}  [-${COMMON_OPTIONS_ARGS}] ... \n\
\t[-s path | --source=path]  [--bindir=arg]  ...\n\
\t[--docmeta=arg]  [--docname=arg]  [--no-toc]  ...\n\
\t-t path | --target=path  <action : check | install | uninstall | update | doc>  --";
MANPAGE_NODEPEDENCY=true

#### send_error ()
## send the error if _ERRSTR is not empty and then exists
send_error () {
    if [ ! -z "$_ERRSTR" ]; then
        error "$_ERRSTR" $_ERRSTATUS
        exit $_ERRSTATUS
    fi
    return 0
}

#### getTargetInfos ( target )
## read a copy 'gitversion' file
## current branch is loaded in `TARGET_BRANCH` and version in `LOCALCOMMIT`
getTargetInfos () {
    if [ ! -z "$1" ]; then export _TARGET="$1"; fi
    targetdir_required
    local targetgitvers="${_TARGET}/${_BIN_DIR}/${_GITVERS_FILENAME}"
    if [ ! -f "${targetgitvers}" ]; then
        export _ERRSTR="Git version file '${targetgitvers}' doesn't exist !"
        export _ERRSTATUS="${E_PATH}"
    fi
    i=0
    for WORD in `cat "$targetgitvers"`; do
        if [ $i -eq 0 ]
            then export TARGET_BRANCH=$WORD
            else export TARGET_LASTCOMMIT=$WORD
        fi
        i=$((i+1))
    done
    send_error
    return 0
}

#### makeInstall ( branch=master )
## read the remote last commit hash
## version is loaded in `LASTCOMMIT`
getRemoteCommit () {
    local mybranch="master"
    if [ ! -z "$1" ]; then mybranch="$1"; fi
    i=0
    for WORD in `git ls-remote "${LIB_HOME}.git" "${mybranch}"`; do
        if [ $i -eq 0 ]; then export SOURCE_LASTCOMMIT=$WORD; fi
        i=$((i+1))
    done
    return 0
}

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

#### sourcedir_required ()
# ensure the library source directory is defined
sourcedir_required () {
    if [ -z "$_SOURCE" ]; then
        prompt 'Library sources directory to work with' `pwd` ''
        export _SOURCE=$USERRESPONSE
    fi
    if [ ! -d "$_SOURCE" ]; then
        export _ERRSTR="Unknown sources directory '${_SOURCE}' !"
        export _ERRSTATUS="${E_PATH}"
    fi
    if [ ! -f "${_SOURCE}/src/piwi-bash-library.sh" ]; then
        export _ERRSTR="Directory '${_SOURCE}' doesn't seem to be a valid library sources remote!"
        export _ERRSTATUS="${E_PATH}"
    fi
    send_error
    return 0
}

#### isUpToDate ( target )
## returns 0 if a copy seems up-to-date
isUpToDate () {
    if [ ! -z "$1" ]; then export _TARGET="$1"; fi
    targetdir_required
    getTargetInfos "${_TARGET}"
    getRemoteCommit "${TARGET_BRANCH}"
    if [ "${SOURCE_LASTCOMMIT}" == "${TARGET_LASTCOMMIT}" ]
        then export _TARGET_UPTODATE=true
        else export _TARGET_UPTODATE=false
    fi
    return 0
}

#### makeInstall ( target , origin )
makeInstall () {
    if [ ! -z "$1" ]; then export _TARGET="$1"; fi
    targetdir_required
    export _TARGET="`realpath ${_TARGET}`"
    if [ ! -z "$2" ]; then export _SOURCE="$2"; fi
    sourcedir_required
    export _SOURCE="`realpath ${_SOURCE}`"
    if [ ! -d "${_TARGET}/${_BIN_DIR}" ]; then
        iexec "mkdir -p ${_TARGET}/${_BIN_DIR}"
    fi
    iexec "cp -f ${_SOURCE}/src/piwi-bash-library.sh ${_TARGET}/${_BIN_DIR}/"
    iexec "cp -f ${_SOURCE}/README.md ${_TARGET}/${_BIN_DIR}/${_README_FILENAME}"
    if [ -f "${_TARGET}/${_BIN_DIR}/${_GITVERS_FILENAME}" ]; then
        iexec "rm -f ${_TARGET}/${_BIN_DIR}/${_GITVERS_FILENAME}"
    fi
    iexec "cd ${_SOURCE} && echo \"\`git rev-parse --abbrev-ref HEAD\` \`git rev-parse HEAD\`\" > ${_TARGET}/${_BIN_DIR}/${_GITVERS_FILENAME}"
    if [ -f "${_SOURCE}/src/piwi-bash-library.man" ]; then
        iexec "cp -f ${_SOURCE}/src/piwi-bash-library.man ${_TARGET}/${_BIN_DIR}/"
    fi
    return 0
}

#### makeUninstall ( target )
makeUninstall () {
    if [ ! -z "$1" ]; then export _TARGET="$1"; fi
    targetdir_required
    iexec "rm -f ${_TARGET}/${_BIN_DIR}/piwi-bash-library.sh"
    iexec "rm -f ${_TARGET}/${_BIN_DIR}/${_README_FILENAME}"
    iexec "rm -f ${_TARGET}/${_BIN_DIR}/${_GITVERS_FILENAME}"
    if [ -f "${_TARGET}/${_BIN_DIR}/${_DOC_FILENAME}" ]; then
        iexec "rm -f ${_TARGET}/${_BIN_DIR}/${_DOC_FILENAME}"
    fi    
    return 0
}

#### makeUpdate ( target )
makeUpdate () {
    if [ ! -z "$1" ]; then export _TARGET="$1"; fi
    targetdir_required
    oldpwd=$(pwd)
    sourcedir_required
    getTargetInfos
    gettempdirpath
    clonedir="${TEMPDIR}/piwi-bash-library"
    if [ ! -d "$clonedir" ]
    then
        iexec "mkdir $clonedir && cd $clonedir"
        iexec "git clone ${LIB_HOME}.git ."
    else
        iexec "cd $clonedir"
    fi
    iexec "git checkout ${TARGET_BRANCH} && git pull"
    cd $oldpwd
    makeInstall "$_TARGET" "$clonedir"
    return 0
}

#### makeDocumentation ( target )
makeDocumentation () {
    if [ ! -z "$1" ]; then export _TARGET="$1"; fi
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
    for line in $(cat "${_TARGET}/${_BIN_DIR}/piwi-bash-library.sh"); do
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
    pathdir="`getscriptpath ${_BASEDIR}/${_TARGET}/${_BIN_DIR}/piwi-bash-library.sh`"
    now=`date '+%d-%-m-%Y %X'`
    docstr="${docstr}\n\n----\n\n[*Doc generated at ${now} from path '${pathdir}/piwi-bash-library.sh'*]"
    _echo "$docstr" > "${_TARGET}/${_BIN_DIR}/${_DOC_FILENAME}"
    return 0
}

parsecommonoptions "$@"
verecho "_ go"

OPTIND=1
options=$(getscriptoptions "$@")
ACTION=$(getlastargument $options)
while getopts "s:t:${COMMON_OPTIONS_ARGS}" OPTION; do
    OPTARG="${OPTARG#=}"
    case $OPTION in
        s) _SOURCE=$OPTARG;;
        t) _TARGET=$OPTARG;;
        -) LONGOPTARG="`getlongoptionarg \"${OPTARG}\"`"
            case $OPTARG in
                target*) _TARGET=$LONGOPTARG;;
                source*) _SOURCE=$LONGOPTARG;;
                bindir*) _BIN_DIR=$LONGOPTARG;;
                docname*) _DOC_FILENAME=$LONGOPTARG;;
                docmeta*) _META="${_META}${LONGOPTARG}";;
                no-toc) _TOC=false;;
                \?) error "Unknown long option '$OPTARG'";;
            esac ;;
        d|f|h|i|l|q|v|V|x) rien=rien;;
        \?) error "Unknown option '$OPTION'";;
    esac
done

if [ ! -z "$ACTION" ]
then
    case $ACTION in
        check)
            targetdir_required
            getTargetInfos
            getRemoteCommit "${TARGET_BRANCH}"
            if [ "${SOURCE_LASTCOMMIT}" = "${TARGET_LASTCOMMIT}" ]
                then info "Library is up-to-date"
                else info "Needs update to version #${SOURCE_LASTCOMMIT}"
            fi;;
        install)
            targetdir_required
            sourcedir_required
            makeInstall
            if [ -z "$_ERRSTR" ]
                then info "OK - Library installed in '${_TARGET}'"
                else send_error
            fi;;
        uninstall)
            targetdir_required
            makeUninstall
            if [ -z "$_ERRSTR" ]
                then info "OK - Library removed from '${_TARGET}'"
                else send_error
            fi;;
        update)
            targetdir_required
            sourcedir_required
            getTargetInfos
            getRemoteCommit "${TARGET_BRANCH}"
            if [ "${SOURCE_LASTCOMMIT}" != "${TARGET_LASTCOMMIT}" ]; then
                makeUpdate
                if [ -z "$_ERRSTR" ]
                    then info "OK - Library updated in '${_TARGET}'"
                    else send_error
                fi
            else info "Library is up-to-date"
            fi;;
        doc)
            targetdir_required
            makeDocumentation
            if [ -z "$_ERRSTR" ]
                then info "OK - Library's documentation generated in '${_TARGET}/${_BIN_DIR}/${_DOC_FILENAME}'"
                else send_error
            fi;;
        *) error "Unknown action '${ACTION}' !";;
    esac
else
    simple_error "no action to execute"
fi

verecho "_ ok"
exit 0

# Endfile
