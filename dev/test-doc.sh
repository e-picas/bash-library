#!/usr/bin/env bash
##@!@##


_title='#### API methods ###############################'
_fct='#### get_sources ( url , package_name=url_filename , file_type='' ) : void'
_param='##@param qsdf qmsdlkfjqmlsdkfmqlsdjf'
_var='##@ INSTALL_PACKAGE (string)    : the name of the primary package'
_comment='## This will load the final local path into the `SOURCE_PATH` environment variable.'
_nocomment='##! This will load the final local path into the `SOURCE_PATH` environment variable.'

test () {
    local str="$1"
    echo "string is: '$str'"
    echo "> grep function:"
    echo "$str" | grep '^#### [^#]*$'
    echo "> grep title:"
    echo "$str" | grep '^#### [^#]* #*$'
    echo "> grep param:"
    echo "$str" | grep '^##@[^ ]* .*$'
    echo "> grep var:"
    echo "$str" | grep '^##@ .*$'
    echo "> grep comment:"
    echo "$str" | grep '^## .*$'
}

test "$_title"
test "$_fct"
test "$_param"
test "$_var"
test "$_comment"
test "$_nocomment"

# find_binstaller_file ( package_name / binstall_file ) : void
find_binstaller_file () {
    return 0
}

#### API methods ###############################

#### get_sources ( url , package_name=url_filename , file_type='' ) : void
## Get a package sources form an URL. You can define final local filename with `package_name`
##+ and specify a file type for a specific extraction method with `file_type` (file extension only).
##+ This will load the final local path into the `SOURCE_PATH` environment variable.
##
## Example:
##
##      get_sources http://github.com/piwi/binstaller/archive/master.tar.gz dev-tools tar.gz
##
##! no comment
get_sources () {
    return 0
}

#### install_binary ( source_path , symlink_without_extension=false , target_filename=source_filename ) : void
## Install a binary or script file into `INSTALLDIR_BIN`. You can ask for the installed file to be *symlinked*
## to its filename without extension (using `true` as `symlink_without_extension` argument) and specify
## a specific final filename with the `target_filename` argument.
##
##@param qsdf qmsdlkfjqmlsdkfmqlsdjf
install_binary () {
    return 0
}

#### install_manpage ( source_path , symlink_without_extension=false , target_filename=source_filename , manpage_section=3 ) : void
## Install a manpage file into `INSTALLDIR_MANPAGE`. You can ask for the installed file to be *symlinked*
## to its filename without extension (using `true` as `symlink_without_extension` argument) and specify
## a specific final filename with the `target_filename` argument. Finally, you can choose a specific *manpage section*
## to install this manpage in with the `manpage_section` argument.
##@error qsdf qsdmflkqjsmdlkfjqmsldfjm
install_manpage () {
    return 0
}

#### install_config ( source_path , target_filename=source_filename ) : void
## Install a configuration file into `INSTALLDIR_CONFIG`. You can specify a specific final filename with
## the `target_filename` argument.
##@return qsdf qsdmflkqjsmdlkfjqmsldfjm
install_config () {
    return 0
}

#### install_library ( source_path , target_filename=source_filename ) : void
## Install a library into `INSTALLDIR_LIB`. You can specify a specific final filename with
## the `target_filename` argument.
install_library () {
    return 0
}

#### make_install ( package_name / binstall_file ) : void
## Install a package or dependency. This requires that you provide a `binstall_file` script with your own one.
make_install () {
    return 0
}

#### Internal API methods ###############################

##@ INSTALL_PACKAGE (string)    : the name of the primary package

#### prepare_binstaller () : void
## This will "prepare" the environment for an installation (e.g. create the temporary directory ...).
prepare_binstaller () {
    return 0
}

#### shutdown_binstaller () : void
## This will "clean" the environment after an installation (e.g. clean the temporary directory, launch final actions ...).
shutdown_binstaller () {
    return 0
}

# Environment #############################

# default variables
declare -x GLOBAL=false

#### Environment variables ##############################

##@ INSTALL_PACKAGE (string)    : the name of the primary package
##@ SOURCE_PATH (string)        : the original sources directory (local) is loaded
##@ WORKINGDIR (string)         : path to your terminal 'pwd' running your command
##@ INSTALLDIR (string)         : global path for the installation process
##@ INSTALLDIR_BIN (string)     : path for the installation process of binaries or scripts
##@ INSTALLDIR_MANPAGE (string) : global path for the installation process of manpages
##@ INSTALLDIR_CONFIG (string)  : global path for the installation process of configuration files
##@ INSTALLDIR_LIB (string)     : global path for the installation process of libraries
##@ GLOBAL (bool)               : whether the installation is in global system paths
##@ RESULT_INFO (misc)          : the output of last method called
declare -x SOURCE_PATH

##@!@##
# Endfile
