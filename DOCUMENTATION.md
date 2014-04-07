# Piwi Bash Library documentation

[*Piwi Bash library 1.0.1 master@fb34ed425a494bbe22f5e47f6a6a3d735c27e2ee*]

Package [atelierspierrot/piwi-bash-library] version [1.0.1].
Copyright (c) 2013-2014 Les Ateliers Pierrot <http://www.ateliers-pierrot.fr/> - Some rights reserved. 
License GPL-3.0: <http://www.gnu.org/licenses/gpl-3.0.html>.
Sources & updates: <http://github.com/atelierspierrot/piwi-bash-library>.
Bug reports: <http://github.com/atelierspierrot/piwi-bash-library/issues>.
This is free software: you are free to change and redistribute it ; there is NO WARRANTY, to the extent permitted by law.

----


## REFERENCES (line 22)

-   @ Bash Reference Manual: <http://www.gnu.org/software/bash/manual/bashref.html>
-   @ Bash Guide for Beginners: <http://www.tldp.org/LDP/Bash-Beginners-Guide/html/Bash-Beginners-Guide.html>
-   @ Advanced Bash-Scripting Guide: <http://www.tldp.org/LDP/abs/html/abs-guide.html>
-   @ GNU coding standards: <http://www.gnu.org/prep/standards/standards.html>

## ENVIRONMENT (line 27)

-   @ SCRIPT_VARS = ( NAME VERSION DATE PRESENTATION LICENSE HOMEPAGE )
-   @ MANPAGE_VARS = ( SYNOPSIS DESCRIPTION OPTIONS EXAMPLES EXIT_STATUS FILES ENVIRONMENT COPYRIGHT BUGS AUTHOR SEE_ALSO )
-   @ VERSION_VARS = ( NAME VERSION DATE PRESENTATION COPYRIGHT_TYPE LICENSE_TYPE SOURCES_TYPE ADDITIONAL_INFO )
-   @ LIB_FLAGS = ( VERBOSE QUIET DEBUG INTERACTIVE FORCED )
-   @ COLOR_VARS = ( COLOR_LIGHT COLOR_DARK COLOR_INFO COLOR_NOTICE COLOR_WARNING COLOR_ERROR COLOR_COMMENT )
-   @ LIBCOLORS = ( default black red green yellow blue magenta cyan grey white lightred lightgreen lightyellow lightblue lightmagenta lightcyan lightgrey )
-   @ LIBTEXTOPTIONS = ( normal bold small underline blink reverse hidden )
-   @ INTERACTIVE = DEBUG = VERBOSE = QUIET = FORCED = DRYRUN = false
-   @ WORKINGDIR = pwd
-   @ USEROS="$(uname)"

## SETTINGS (line 65)

-   @ LIB_FILENAME_DEFAULT = "piwi-bash-library"
-   @ LIB_NAME_DEFAULT = "piwibashlib"
-   @ LIB_LOGFILE = "piwibashlib.log"
-   @ LIB_TEMPDIR = "tmp"
-   @ LIB_SYSHOMEDIR = "${HOME}/.piwi-bash-library/"
-   @ LIB_SYSCACHEDIR = "${LIB_SYSHOMEDIR}/cache/"

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

## LIBRARY SETUP (line 159)

-   @ LIB_NAME LIB_VERSION LIB_DATE LIB_GITVERSION

## SYSTEM (line 186)

-   **get_system_info ()**
-   **get_machine_name ()**
-   **add_path ( path )**
-   **get_script_path ( script = $0 )**
-   **set_working_directory ( path )**
-   **set_log_filename ( path )**

## FILES (line 237)

-   **get_extension ( path = $0 )**
-   **get_filename ( path = $0 )**
-   **get_basename ( path = $0 )**
-   **get_dirname ( path = $0 )**
-   **get_absolute_path ( script = $0 )**
-   **/ realpath ( string )**
-   **resolve ( path )**

## ARRAY (line 283)

-   **array_search ( item , $array[@] )**
    @return the index of an array item, 0 based
-   **in_array ( item , $array[@] )**
    @return 0 if item is found in array
-   **array_filter ( $array[@] )**
    @return array with cleaned values

## STRING (line 313)

-   **string_length ( string )**
    @return the number of characters in string
-   **/ strlen ( string )**
-   **string_to_upper ( string )**
-   **/ strtoupper ( string )**
-   **string_to_lower ( string )**
-   **/ strtolower ( string )**
-   **upper_case_first ( string )**
-   **/ ucfirst ( string )**
-   **explode ( str , delim = ' ' )**
-   **implode ( array[@] , delim = ' ' )**
-   **explode_letters ( str )**

## BOOLEAN (line 395)

-   **onoff_bit ( bool )**

## UTILS (line 401)

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
-   **nooption_error ()**
-   @error exits with status E_OPTS (81)
-   **command_error ( cmd )**
-   @error exits with status E_CMD (82)
-   **path_error ( path )**
-   @error exits with status E_PATH (83)
-   **simple_usage ( synopsis = SYNOPSIS_ERROR )**
-   **simple_error ( string , status = 90 , synopsis = SYNOPSIS_ERROR , funcname = FUNCNAME[1] , line = BASH_LINENO[1] )**
-   @error default status is E_ERROR (90)
-   **nooption_simple_error ()**
-   @error exits with status E_OPTS (81)
-   **command_simple_error ( cmd )**
-   @error exits with status E_CMD (82)
-   **path_simple_error ( path )**
-   @error exits with status E_PATH (83)
-   **gnu_error_string ( string , filename = BASH_SOURCE[2] , funcname = FUNCNAME[2] , line = BASH_LINENO[2] )**

## VCS (line 676)

-   @ VCSVERSION : variable used as version marker like `branch@commit_sha`
-   @ SCRIPT_VCS = VCS type of the script
-   **get_version_string ( file_path = $0 , constant_name = VCSVERSION )**
-   **get_version_sha ( get_version_string )**
-   **get_version_branch ( get_version_string )**
-   **vcs_is_clone ( path = pwd , remote_url = null )**
-   **vcs_get_branch ( path = pwd )**
-   **vcs_get_commit ( path = pwd )**
-   **vcs_get_version ( path = pwd )**
-   **vcs_get_remote_version ( path = pwd , branch = HEAD )**
-   **vcs_make_clone ( repository_url , target_dir = LIB_SYSCACHEDIR )**
-   **vcs_update_clone ( target_dir )**
-   **vcs_change_branch ( target_dir , branch = 'master' )**
-   **git_is_clone ( path = pwd , remote_url = null )**
-   **git_get_branch ( path = pwd )**
-   **git_get_commit ( path = pwd )**
-   **git_get_version ( path = pwd )**
-   **git_get_remote_version ( path = pwd , branch = HEAD )**
-   **git_make_clone ( repository_url , target_dir = LIB_SYSCACHEDIR )**
-   **git_update_clone ( target_dir )**
-   @param target_dir: name of the clone in $LIB_SYSCACHEDIR or full path of concerned clone
-   **git_change_branch ( target_dir , branch = 'master' )**
-   @param target_dir: name of the clone in $LIB_SYSCACHEDIR or full path of concerned clone

## COLORIZED CONTENTS (line 930)

-   **get_text_format_tag ( code )**
    @param code must be one of the library colors or text-options codes
-   **get_color_code ( name , background = false )**
    @param name must be in LIBCOLORS
-   **get_color_tag ( name , background = false )**
    @param name must be in LIBCOLORS
-   **get_text_option_code ( name )**
    @param name must be in LIBTEXTOPTIONS
-   **get_text_option_tag ( name )**
    @param name must be in LIBTEXTOPTIONS
-   **get_text_option_tagclose ( name )**
    @param name must be in LIBTEXTOPTIONS
-   **colorize ( string , text_option , foreground , background )**
    @param text_option must be in LIBTEXTOPTIONS
    @param foreground must be in LIBCOLORS
    @param background must be in LIBCOLORS
-   **parse_color_tags ( "string with <bold>tags</bold>" )**
-   **strip_colors ( string )**

## TEMPORARY FILES (line 1096)

-   **get_tempdir_path ( dirname = "LIB_TEMPDIR" )**
    @param dirname The name of the directory to create (default is `tmp/`)
-   **get_temp_filepath ( filename , dirname = "LIB_TEMPDIR" )**
    @param filename The temporary filename to use
    @param dirname The name of the directory to create (default is `tmp/`)
-   **create_tempdir ( dirname = "LIB_TEMPDIR" )**
    @param dirname The name of the directory to create (default is `tmp/`)
-   **clear_tempdir ( dirname = "LIB_TEMPDIR" )**
    @param dirname The name of the directory (default is `tmp/`)
-   **clear_tempfiles ( dirname = "LIB_TEMPDIR" )**
    @param dirname The name of the directory (default is `tmp/`)

## LOG FILES (line 1183)

-   **get_log_filepath ()**
-   **log ( message , type='' )**
-   **read_log ()**

## CONFIGURATION FILES (line 1221)

-   **get_global_configfile ( file_name )**
-   **get_user_configfile ( file_name )**
-   **read_config ( file_name )**
-   **read_configfile ( file_path )**
-   **write_configfile ( file_path , array_keys , array_values )**
-   **set_configval ( file_path , key , value )**
-   **get_configval ( file_path , key )**
-   **build_configstring ( array_keys , array_values )**

## SCRIPT OPTIONS / ARGUMENTS (line 1371)

-   **get_short_options_array ()**
-   **get_short_options_string ( delimiter = '|' )**
-   **get_long_options_array ()**
-   **get_long_options_string ( delimiter = '|' )**
-   **get_option_arg ( "$x" )**
-   **get_long_option ( "$x" )**
-   **get_long_optionarg ( "$x" )**
-   **get_next_argument ()**
-   **get_last_argument ()**
-   **rearrange_script_options ( "$@" )**
-   **parse_common_options_strict ( "$@" = SCRIPT_OPTS )**
-   **parse_common_options ( "$@" = SCRIPT_OPTS )**

## SCRIPT INFOS (line 1603)

-   **get_script_version_string ( quiet = false )**
-   **script_title ( lib = false )**
-   **script_usage ()**
-   **script_help ( lib_info = true )**
-   **script_manpage ( cmd = $0 , section = 3 )**
-   **script_short_version ( quiet = false )**
-   **script_version ( quiet = false )**

## DOCBUILDER (line 1737)

-   @ DOCBUILDER_MASKS = ()
-   @ DOCBUILDER_MARKER = '##@!@##'
-   @ DOCBUILDER_RULES = ( ... )
-   **build_documentation ( type = TERMINAL , output = null , source = BASH_SOURCE[0] )**
-   **generate_documentation ( filepath = BASH_SOURCE[0] , output = null )**

## LIBRARY INFOS (line 1844)

-   **get_library_version_string ( path = $0 )**
-   **library_info ()**
-   **library_path ()**
-   **library_help ()**
-   **library_usage ()**
-   **library_short_version ( quiet = false )**
-   **library_version ( quiet = false )**
-   **library_debug ( "$*" )**
-   **/ libdebug ( "$*" )**

## LIBRARY INTERNALS (line 1956)

-   @ LIBRARY_REALPATH LIBRARY_DIR LIBRARY_BASEDIR LIBRARY_SOURCEFILE
-   **make_library_homedir ()**
-   **make_library_cachedir ()**
-   **clean_library_cachedir ()**

## INSTALLATION WIZARD (line 1981)

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

## COMPATIBILITY (line 2131)


----

[*Doc generated at 06-4-2014 22:51:49 from path 'src/piwi-bash-library.sh'*]
