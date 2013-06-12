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

NAME="Bash-Lib installer"
VERSION="0.0.1-dev"
DESCRIPTION="An installer/updater for the Bash-Library \n\
\tThis will copy a clone of the library script and its README in a 'bin/' directory of a traget dir."
SYNOPSIS="$LIB_SYNOPSIS"
OPTIONS="<bold>check</bold>\t\t\tcheck an installed lib\n\
\t<bold>install</bold>\t\t\tinstall the lib in a project\n\
\t<bold>update</bold>\t\t\tupdate an installed lib\n\
\t<bold>uninstall</bold>\t\tuninstall the lib from a project\n\
\t<bold>-t | --target=PATH</bold>\tproject path (default is empty)\n\
\t<bold>-s | --source=PATH</bold>\tlibrary source root directory (default is 'pwd')\n\
\n\
\t<underline>COMMON OPTIONS</underline>\n\
\t${LIB_OPTIONS}";
MANPAGE_NODEPEDENCY=true

_REALPATH="`realpath $BASH_SOURCE`"
_REALPATH_DIR="`dirname $_REALPATH`"
declare -x _BASEDIR="`dirname $_REALPATH_DIR`"
declare -x _TARGET
declare -x _SOURCE="$_BASEDIR"

#### getTargetInfos ( target )
## read a copy 'gitversion' file
## current branch is loaded in `BRANCH` and version in `LOCALCOMMIT`
getTargetInfos () {
    if [ ! -z "$1" ]; then _TARGET="$1"; fi
    targetdir_required
    i=0
    for WORD in `cat "${_TARGET}/bin/gitversion"`; do
        if [ $i -eq 0 ]
            then BRANCH=$WORD
            else LOCALCOMMIT=$WORD
        fi
        i=$((i+1))
    done
    export LOCALCOMMIT BRANCH
    return 0
}

#### makeInstall ( branch=master )
## read the remote last commit hash
## version is loaded in `LASTCOMMIT`
getRemoteCommit () {
    if [ ! -z "$1" ]; then mybranch="$1"; else mybranch="master"; fi
    i=0
    for WORD in `git ls-remote "${LIB_HOME}.git" "${mybranch}"`; do
        if [ $i -eq 0 ]; then LASTCOMMIT=$WORD; fi
        i=$((i+1))
    done
    export LASTCOMMIT
    return 0
}

#### isUpToDate ( target )
## returns 0 if a copy seems up-to-date
isUpToDate () {
    if [ ! -z "$1" ]; then _TARGET="$1"; fi
    targetdir_required
    getTargetInfos "$_TARGET"
    getRemoteCommit "$BRANCH"
    if [ "$LASTCOMMIT" != "$LOCALCOMMIT" ]
        then return 0
        else return 1
    fi
}

#### makeInstall ( target , origin )
makeInstall () {
    if [ ! -z "$1" ]; then _TARGET="$1"; fi
    targetdir_required
    if [ ! -z "$2" ]; then _SOURCE="$2"; fi
    sourcedir_required
    if [ ! -d "${_TARGET}/bin" ]; then
        iexec "mkdir -p ${_TARGET}/bin"
    fi
    iexec "cp -f ${_SOURCE}/src/bash-library.sh ${_TARGET}/bin/"
    iexec "cp -f ${_SOURCE}/README.md ${_TARGET}/bin/"
    if [ -f "${_TARGET}/bin/gitversion" ]; then
        iexec "rm -f ${_TARGET}/bin/gitversion"
    fi
    iexec "echo \"`git rev-parse --abbrev-ref HEAD` `git rev-parse HEAD`\" > ${_TARGET}/bin/gitversion"
    return 0
}

#### makeUninstall ( target )
makeUninstall () {
    if [ ! -z "$1" ]; then _TARGET="$1"; fi
    targetdir_required
    iexec "rm -f ${_TARGET}/bin//bash-library.sh"
    iexec "rm -f ${_TARGET}/bin//README.md"
    iexec "rm -f ${_TARGET}/bin/gitversion"
    return 0
}

#### makeUpdate ( target )
makeUpdate () {
    if [ ! -z "$1" ]; then _TARGET="$1"; fi
    targetdir_required
    if `isUpToDate`
    then
        oldpwd=$(pwd)
        sourcedir_required
        getTargetInfos
        gettempdirpath
        clonedir="${TEMPDIR}/bash-library"
        if [ ! -d "$clonedir" ]
        then
            iexec "mkdir $clonedir && cd $clonedir"
            iexec "git clone ${LIB_HOME}.git ."
        else
            iexec "cd $clonedir"
        fi
        iexec "git checkout ${BRANCH} && git pull"
        cd $oldpwd
        makeInstall "$_TARGET" "$clonedir"
        return 0
    else
        return 1
    fi
}

#### targetdir_required ()
# ensure the project target directory is defined
targetdir_required () {
	if [ -z "$_TARGET" ]; then
		prompt 'Target directory of the project to work on' `pwd` ''
		export _TARGET=$USERRESPONSE
	fi
	if [ ! -d "$_TARGET" ]; then
	    error "Unknown target directory '${_TARGET}' !" $E_PATH
	    return 1
	fi
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
	    error "Unknown sources directory '${_SOURCE}' !" $E_PATH
	    return 1
	fi
	if [ ! -f "${_SOURCE}/src/bash-library.sh" ]; then
	    error "Directory '${_SOURCE}' doesn't seem to be a valid library sources remote!" "$E_PATH"
	    return 1
	fi
    return 0
}

parsecomonoptions "$@"
verecho "_ go"

OPTIND=1
options=$(getscriptoptions "$@")
ACTION=$(getlastargument $options)
while getopts "s:t:${COMMON_OPTIONS_ARGS}" OPTION $options; do
	OPTARG="${OPTARG#=}"
	case $OPTION in
		d|f|h|i|l|q|v|V|x) rien=rien;;
        s) _SOURCE=$OPTARG;;
        t) _TARGET=$OPTARG;;
		-) LONGOPTARG="`getlongoptionarg \"${OPTARG}\"`"
			case $OPTARG in
				target*) _TARGET=$LONGOPTARG;;
				source*) _SOURCE=$LONGOPTARG;;
				\?) error "Unknown long option '$OPTARG'";;
			esac ;;
        \?) error "Unknown option '$OPTION'";;
	esac
done

if [ ! -z "$ACTION" ]
then
	case $ACTION in
		check)
            if `isUpToDate`
            then
                getTargetInfos
                getRemoteCommit "$BRANCH"
                info "Needs update to version #${LASTCOMMIT}"
            else
                info "Library is up-to-date"
            fi;;
        install)
            if `makeInstall`; then
                info "OK - Library installed in '${_TARGET}'"
            fi;;
        uninstall)
            if `makeUninstall`; then
                info "OK - Library removed from '${_TARGET}'"
            fi;;
		update)
		    if `isUpToDate`
		    then
                if `makeUpdate`; then
                    info "OK - Library updated in '${_TARGET}'"
                fi
            else
                info "Library is up-to-date"
            fi;;
        *) error "Unknown action '${ACTION}' !";;
	esac
else
    usage
fi

verecho "_ ok"
exit 0

# Endfile
