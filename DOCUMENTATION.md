# Piwi Bash Library documentation

[*Piwi Bash library 1.0.1 master@fb34ed425a494bbe22f5e47f6a6a3d735c27e2ee*]

Package [atelierspierrot/piwi-bash-library] version [1.0.1].
Copyright (c) 2013-2014 Les Ateliers Pierrot <http://www.ateliers-pierrot.fr/> - Some rights reserved. 
License GPL-3.0: <http://www.gnu.org/licenses/gpl-3.0.html>.
Sources & updates: <http://github.com/atelierspierrot/piwi-bash-library>.
Bug reports: <http://github.com/atelierspierrot/piwi-bash-library/issues>.
This is free software: you are free to change and redistribute it ; there is NO WARRANTY, to the extent permitted by law.

----


## REFERENCES (line 21)

-   @ Bash Reference Manual: <http://www.gnu.org/software/bash/manual/bashref.html>
-   @ Bash Guide for Beginners: <http://www.tldp.org/LDP/Bash-Beginners-Guide/html/Bash-Beginners-Guide.html>
-   @ Advanced Bash-Scripting Guide: <http://www.tldp.org/LDP/abs/html/abs-guide.html>
-   @ GNU coding standards: <http://www.gnu.org/prep/standards/standards.html>

## SETTINGS (line 26)

-   @ SCRIPT_INFOS = ( NAME VERSION DATE PRESENTATION LICENSE HOMEPAGE )
-   @ MANPAGE_INFOS = ( SYNOPSIS DESCRIPTION OPTIONS EXAMPLES EXIT_STATUS FILES ENVIRONMENT COPYRIGHT BUGS AUTHOR SEE_ALSO )
-   @ VERSION_INFOS = ( NAME VERSION DATE PRESENTATION COPYRIGHT_TYPE LICENSE_TYPE SOURCES_TYPE ADDITIONAL_INFO )
-   @ LIB_FLAGS = ( VERBOSE QUIET DEBUG INTERACTIVE FORCED )
-   @ LIB_COLORS = ( COLOR_LIGHT COLOR_DARK COLOR_INFO COLOR_NOTICE COLOR_WARNING COLOR_ERROR COLOR_COMMENT )
-   @ LIBCOLORS = ( default black red green yellow blue magenta cyan grey white lightred lightgreen lightyellow lightblue lightmagenta lightcyan lightgrey )
-   @ LIBTEXTOPTIONS = ( normal bold small underline blink reverse hidden )
-   @ LIB_FILENAME_DEFAULT = "piwi-bash-library"
-   @ LIB_NAME_DEFAULT = "piwibashlib"
-   @ LIB_LOGFILE = "piwibashlib.log"
-   @ LIB_TEMPDIR = "tmp"
-   @ LIB_SYSHOMEDIR = "${HOME}/.piwi-bash-library/"
-   @ LIB_SYSCACHEDIR = "${LIB_SYSHOMEDIR}/cache/"

## ENVIRONMENT (line 93)

-   @ INTERACTIVE = DEBUG = VERBOSE = QUIET = FORCED = DRYRUN = false
-   @ WORKINGDIR = pwd
-   @ USEROS="$(uname)"

## COMMON OPTIONS (line 109)

-   @ COMMON_OPTIONS_ALLOWED = "d:fhil:qvVx-:"
-   @ COMMON_OPTIONS_ALLOWED_MASK : REGEX mask that matches all common short options
-   @ COMMON_LONG_OPTIONS_ALLOWED="working-dir:,working-directory:,force,help,interactive,log:,logfile:,quiet,verbose,version,debug,dry-run,libvers,man,usage"
-   @ COMMON_LONG_OPTIONS_ALLOWED_MASK : REGEX mask that matches all common long options
-   @ ORIGINAL_SCRIPT_OPTS="$@"
-   @ SCRIPT_OPTS=() | SCRIPT_ARGS=() | SCRIPT_PROGRAMS=()
-   @ OPTIONS_ALLOWED | LONG_OPTIONS_ALLOWED : to be defined by the script
-   @ OPTIONS_USAGE_INFOS : information string about command line options how-to
-   @ COMMON_OPTIONS_LIST : information string about common script options
-   @ COMMON_OPTIONS_FULLINFO : concatenation of COMMON_OPTIONS_LIST & OPTIONS_USAGE_INFOS

## LOREM IPSUM (line 150)

-   @ LOREMIPSUM , LOREMIPSUM_SHORT , LOREMIPSUM_MULTILINE

## LIBRARY INFOS (line 159)

-   @ LIB_NAME LIB_VERSION LIB_DATE LIB_GITVERSION

## SYSTEM (line 209)

-   **getsysteminfo ()**
-   **getmachinename ()**
-   **addpath ( path )**
-   **getscriptpath ( script = $0 )**
-   **setworkingdir ( path )**
-   **setlogfilename ( path )**

## FILES (line 260)

-   **getextension ( path = $0 )**
-   **getfilename ( path = $0 )**
-   **getbasename ( path = $0 )**
-   **getdirname ( path = $0 )**
-   **realpath ( script = $0 )**
-   **resolve ( path )**

## ARRAY (line 303)

-   **array_search ( item , $array[@] )**
    @return the index of an array item, 0 based
-   **in_array ( item , $array[@] )**
    @return 0 if item is found in array
-   **array_filter ( $array[@] )**
    @return array with cleaned values

## STRING (line 333)

-   **strlen ( string )**
    @return the number of characters in string
-   **strtoupper ( string )**
-   **strtolower ( string )**
-   **ucfirst ( string )**
-   **explode ( str , delim = ' ' )**
-   **implode ( array[@] , delim = ' ' )**
-   **explodeletters ( str )**

## BOOLEAN (line 403)

-   **onoffbit ( bool )**

## VCS (line 409)

-   **isgitclone ( path = pwd , remote_url = null )**
-   **get_gitbranch ()**
-   **get_gitcommit ()**
-   **gitversion ( quiet = false )**
-   **make_git_clone ( repository_url , target_dir = LIB_SYSCACHEDIR )**
-   **update_git_clone ( target_dir )**
-   @param target_dir: name of the clone in $LIB_SYSCACHEDIR or full path of concerned clone
-   **change_git_branch ( target_dir , branch = 'master' )**
-   @param target_dir: name of the clone in $LIB_SYSCACHEDIR or full path of concerned clone

## UTILS (line 544)

-   **_echo ( string )**
-   **_necho ( string )**
-   **verbose_echo ( string )**
-   **/ verecho ( string )**
-   **quiet_echo ( string )**
-   **/ quietecho ( string )**
-   **interactive_exec ( command , debug_exec = true )**
-   **/ iexec ( command , debug_exec = true )**
-   **debug_exec ( command )**
-   **/ debexec ( command )**
-   **prompt ( string , default = y , options = Y/n )**
-   **selector_prompt ( list[@] , string , list_string , default = 1 )**
-   **info ( string, bold = true )**
-   **warning ( string , funcname = FUNCNAME[1] , line = BASH_LINENO[1] , tab='    ' )**
-   **error ( string , status = 90 , funcname = FUNCNAME[1] , line = BASH_LINENO[1] , tab='   ' )**
-   @error default status is E_ERROR (90)
-   **nooptionerror ()**
-   @error exits with status E_OPTS (81)
-   **commanderror ( cmd )**
-   @error exits with status E_CMD (82)
-   **patherror ( path )**
-   @error exits with status E_PATH (83)
-   **simple_usage ( synopsis = SYNOPSIS_ERROR )**
-   **simple_error ( string , status = 90 , synopsis = SYNOPSIS_ERROR , funcname = FUNCNAME[1] , line = BASH_LINENO[1] )**
-   @error default status is E_ERROR (90)
-   **nooptionsimpleerror ()**
-   @error exits with status E_OPTS (81)
-   **commandsimpleerror ( cmd )**
-   @error exits with status E_CMD (82)
-   **pathsimpleerror ( path )**
-   @error exits with status E_PATH (83)
-   **gnuerrorstr ( string , filename = BASH_SOURCE[2] , funcname = FUNCNAME[2] , line = BASH_LINENO[2] )**

## COLORIZED CONTENTS (line 819)

-   **gettextformattag ( code )**
    @param code must be one of the library colors or text-options codes
-   **getcolorcode ( name , background = false )**
    @param name must be in LIBCOLORS
-   **getcolortag ( name , background = false )**
    @param name must be in LIBCOLORS
-   **gettextoptioncode ( name )**
    @param name must be in LIBTEXTOPTIONS
-   **gettextoptiontag ( name )**
    @param name must be in LIBTEXTOPTIONS
-   **gettextoptiontagclose ( name )**
    @param name must be in LIBTEXTOPTIONS
-   **colorize ( string , text_option , foreground , background )**
    @param text_option must be in LIBTEXTOPTIONS
    @param foreground must be in LIBCOLORS
    @param background must be in LIBCOLORS
-   **parsecolortags ( "string with <bold>tags</bold>" )**
-   **stripcolors ( string )**

## TEMPORARY FILES (line 985)

-   **gettempdirpath ( dirname = "LIB_TEMPDIR" )**
    @param dirname The name of the directory to create (default is `tmp/`)
-   **gettempfilepath ( filename , dirname = "LIB_TEMPDIR" )**
    @param filename The temporary filename to use
    @param dirname The name of the directory to create (default is `tmp/`)
-   **createtempdir ( dirname = "LIB_TEMPDIR" )**
    @param dirname The name of the directory to create (default is `tmp/`)
-   **cleartempdir ( dirname = "LIB_TEMPDIR" )**
    @param dirname The name of the directory (default is `tmp/`)
-   **cleartempfiles ( dirname = "LIB_TEMPDIR" )**
    @param dirname The name of the directory (default is `tmp/`)

## LOG FILES (line 1072)

-   **getlogfilepath ()**
-   **log ( message , type='' )**
-   **readlog ()**

## CONFIGURATION FILES (line 1110)

-   **getglobalconfigfile ( file_name )**
-   **getuserconfigfile ( file_name )**
-   **readconfig ( file_name )**
-   **readconfigfile ( file_path )**
-   **writeconfigfile ( file_path , array_keys , array_values )**
-   **setconfigval ( file_path , key , value )**
-   **getconfigval ( file_path , key )**
-   **buildconfigstring ( array_keys , array_values )**

## SCRIPT OPTIONS / ARGUMENTS (line 1260)

-   **getshortoptionsarray ()**
-   **getshortoptionsstring ( delimiter = '|' )**
-   **getlongoptionsarray ()**
-   **getlongoptionsstring ( delimiter = '|' )**
-   **getoptionarg ( "$x" )**
-   **getlongoption ( "$x" )**
-   **getlongoptionarg ( "$x" )**
-   **getnextargument ()**
-   **getlastargument ()**
-   **rearrangescriptoptions ( "$@" )**
-   **parsecommonoptions_strict ( "$@" = SCRIPT_OPTS )**
-   **parsecommonoptions ( "$@" = SCRIPT_OPTS )**

## SCRIPT INFOS (line 1492)

-   **version ( quiet = false )**
-   **title ( lib = false )**
-   **usage ( lib_info = true )**
-   **manpage ( cmd = $0 , section = 3 )**
-   **script_shortversion ( quiet = false )**
-   **script_version ( quiet = false )**
-   **build_documentation ( type = TERMINAL , output = null , source = BASH_SOURCE[0] )**
-   **generate_documentation ( filepath = BASH_SOURCE[0] , output = null )**

## LIBRARY INFOS (line 1699)

-   **get_gitversion ( path = $0 )**
-   **gitversion_extract_sha ( gitversion_string )**
-   **gitversion_extract_branch ( gitversion_string )**
-   **library_info ()**
-   **library_path ()**
-   **library_help ()**
-   **library_usage ()**
-   **library_shortversion ( quiet = false )**
-   **library_version ( quiet = false )**
-   **library_debug ( "$*" )**
-   **/ libdebug ( "$*" )**

## LIBRARY INTERNALS (line 1818)

-   @ LIBRARY_REALPATH LIBRARY_DIR LIBRARY_BASEDIR LIBRARY_SOURCEFILE
-   **make_library_homedir ()**
-   **make_library_cachedir ()**
-   **clean_library_cachedir ()**

## INSTALLATION WIZARD (line 1843)

-   @ SCRIPT_REPOSITORY_URL = url of your distant repository
-   @ SCRIPT_FILES = array of installable files
-   @ SCRIPT_FILES_BIN = array of installable binary files
-   @ SCRIPT_FILES_MAN = array of manpages files
-   @ SCRIPT_FILES_CONF = array of configuration files
-   **script_installation_target ( target_dir = $HOME/bin )**
-   **script_installation_source ( clone_repo = SCRIPT_REPOSITORY_URL , clone_dir = LIB_SYSCACHEDIR )**
-   **script_install ( path = $HOME/bin/ )**
-   **script_check ( file_name , original = LIBINST_CLONE , target = LIBINST_TARGET )**
    @param file_name: the file to check and compare on both sides
-   **script_update ( path = $HOME/bin/ )**
-   **script_uninstall ( path = $HOME/bin/ )**

## COMPATIBILITY (line 2007)


----

[*Doc generated at 05-4-2014 17:08:15 from path 'src/piwi-bash-library.sh'*]
