# Documentation of 'src/piwi-bash-library.sh'

## REFERENCES (line 22)

-   @ Bash Reference Manual: <http://www.gnu.org/software/bash/manual/bashref.html>
-   @ Bash Guide for Beginners: <http://www.tldp.org/LDP/Bash-Beginners-Guide/html/Bash-Beginners-Guide.html>
-   @ Advanced Bash-Scripting Guide: <http://www.tldp.org/LDP/abs/html/abs-guide.html>
-   @ GNU coding standards: <http://www.gnu.org/prep/standards/standards.html>

## ENVIRONMENT (line 27)

-   @ SCRIPT_VARS = ( NAME VERSION DATE DESCRIPTION LICENSE HOMEPAGE SYNOPSIS OPTIONS ) (read-only)
-   @ USAGE_VARS = ( NAME VERSION DATE DESCRIPTION_USAGE SYNOPSIS_USAGE OPTIONS_USAGE ) (read-only)
-   @ USAGE_SUFFIX = "_USAGE"
-   @ VERSION_VARS = ( NAME VERSION DATE DESCRIPTION COPYRIGHT LICENSE HOMEPAGE SOURCES ADDITIONAL_INFO ) (read-only)
-   @ MANPAGE_VARS = ( NAME VERSION DATE DESCRIPTION_MANPAGE SYNOPSIS_MANPAGE OPTIONS_MANPAGE EXAMPLES_MANPAGE EXIT_STATUS_MANPAGE FILES_MANPAGE ENVIRONMENT_MANPAGE COPYRIGHT_MANPAGE HOMEPAGE_MANPAGE BUGS_MANPAGE AUTHOR_MANPAGE SEE_ALSO_MANPAGE ) (read-only)
-   @ MANPAGE_SUFFIX = "_MANPAGE"
-   @ LIB_FLAGS = ( VERBOSE QUIET DEBUG INTERACTIVE FORCED ) (read-only)
-   @ COLOR_VARS = ( COLOR_LIGHT COLOR_DARK COLOR_INFO COLOR_NOTICE COLOR_WARNING COLOR_ERROR COLOR_COMMENT ) (read-only)
-   @ LIBCOLORS = ( default black red green yellow blue magenta cyan grey white lightred lightgreen lightyellow lightblue lightmagenta lightcyan lightgrey ) (read-only)
-   @ LIBTEXTOPTIONS = ( normal bold small underline blink reverse hidden ) (read-only)
-   @ INTERACTIVE = DEBUG = VERBOSE = QUIET = FORCED = DRYRUN = false
-   @ WORKINGDIR = pwd
-   @ USEROS = "$(uname)" (read-only)
-   @ LINUX_OS = ( Linux FreeBSD OpenBSD SunOS ) (read-only)

## SETTINGS (line 72)

-   @ LIB_FILENAME_DEFAULT = "piwi-bash-library" (read-only)
-   @ LIB_NAME_DEFAULT = "piwibashlib" (read-only)
-   @ LIB_LOGFILE = "piwibashlib.log" (read-only)
-   @ LIB_TEMPDIR = "tmp" (read-only)
-   @ LIB_SYSHOMEDIR = "${HOME}/.piwi-bash-library/" (read-only)
-   @ LIB_SYSCACHEDIR = "${LIB_SYSHOMEDIR}/cache/" (read-only)

## COMMON OPTIONS (line 116)

-   @ COMMON_OPTIONS_ALLOWED = "d:fhil:qvVx-:"
-   @ COMMON_OPTIONS_ALLOWED_MASK : REGEX mask that matches all common short options
-   @ COMMON_LONG_OPTIONS_ALLOWED="working-dir:,working-directory:,force,help,interactive,log:,logfile:,quiet,verbose,version,debug,dry-run,libvers,man,usage"
-   @ COMMON_LONG_OPTIONS_ALLOWED_MASK : REGEX mask that matches all common long options
-   @ ORIGINAL_SCRIPT_OPTS="$@" (read-only)
-   @ SCRIPT_OPTS=() | SCRIPT_ARGS=() | SCRIPT_PROGRAMS=()
-   @ OPTIONS_ALLOWED | LONG_OPTIONS_ALLOWED : to be defined by the script
-   @ COMMON_SYNOPSIS COMMON_SYNOPSIS_ACTION COMMON_SYNOPSIS_ERROR COMMON_SYNOPSIS_MANPAGE COMMON_SYNOPSIS_ACTION_MANPAGE COMMON_SYNOPSIS_ERROR_MANPAGE (read-only)
-   @ OPTIONS_ADDITIONAL_INFOS_MANPAGE : information string about command line options how-to (read-only)
-   @ COMMON_OPTIONS_MANPAGE : information string about common script options (read-only)
-   @ COMMON_OPTIONS_USAGE: raw information string about common script options (read-only)
-   @ COMMON_OPTIONS_FULLINFO_MANPAGE : concatenation of COMMON_OPTIONS_MANPAGE & OPTIONS_ADDITIONAL_INFOS_MANPAGE (read-only)

## LOREM IPSUM (line 181)

-   @ LOREMIPSUM , LOREMIPSUM_SHORT , LOREMIPSUM_MULTILINE (read-only)

## LIBRARY SETUP (line 190)

-   @ LIB_NAME LIB_VERSION LIB_DATE LIB_VCSVERSION LIB_VCSVERSION
-   @ LIB_COPYRIGHT LIB_LICENSE_TYPE LIB_LICENSE_URL LIB_SOURCES_URL

## SYSTEM (line 214)

-   **get_system_info ()**
-   **get_machine_name ()**
-   **add_path ( path )**
-   **get_path ()**
-   **get_script_path ( script = $0 )**
-   **set_working_directory ( path )**
-   **set_log_filename ( path )**
-   **get_date ( timestamp = NOW )**
-   **get_ip ()**

## FILES (line 283)

-   **get_extension ( path = $0 )**
-   **get_filename ( path = $0 )**
-   **get_basename ( path = $0 )**
-   **get_dirname ( path = $0 )**
-   **get_absolute_path ( script = $0 )**
-   **/ realpath ( string )**
-   **resolve ( path )**

## ARRAY (line 329)

-   **array_search ( item , $array[@] )**
    @return the index of an array item, 0 based
-   **in_array ( item , $array[@] )**
    @return 0 if item is found in array
-   **array_filter ( $array[@] )**
    @return array with cleaned values

## STRING (line 359)

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
-   @ MAX_LINE_LENGTH = 80 : default max line length for word wrap (integer)
-   @ LINE_ENDING = 
 : default line ending character for word wrap
-   **word_wrap ( text )**
-   **implode ( array[@] , delim = ' ' )**
-   **explode_letters ( str )**

## BOOLEAN (line 454)

-   **onoff_bit ( bool )**

## UTILS (line 460)

-   **_echo ( string )**
-   **_necho ( string )**
-   **verbose_echo ( string )**
-   **/ verecho ( string )**
-   **quiet_echo ( string )**
-   **/ quietecho ( string )**
-   **interactive_exec ( command , debug_exec = true )**
-   **/ iexec ( command , debug_exec = true )**
-   **debug_echo ( string )**
-   **/ debecho ( string )**
-   **debug_exec ( command )**
-   **/ debexec ( command )**
-   **prompt ( string , default = y , options = Y/n )**
-   **selector_prompt ( list[@] , string , list_string , default = 1 )**
-   **info ( string, bold = true )**
-   **warning ( string , funcname = FUNCNAME[1] , line = BASH_LINENO[1] , tab='    ' )**
-   **error ( string , status = 90 , funcname = FUNCNAME[1] , line = BASH_LINENO[1] , tab='   ' )**
-   @error default status is E_ERROR (90)
-   **simple_usage ( synopsis = SYNOPSIS_ERROR )**
-   **simple_error ( string , status = 90 , synopsis = SYNOPSIS_ERROR , funcname = FUNCNAME[1] , line = BASH_LINENO[1] )**
-   @error default status is E_ERROR (90)
-   **gnu_error_string ( string , filename = BASH_SOURCE[2] , funcname = FUNCNAME[2] , line = BASH_LINENO[2] )**
-   **no_option_error ()**
-   @error exits with status E_OPTS (81)
-   **no_option_simple_error ()**
-   @error exits with status E_OPTS (81)
-   **unknown_option_error ( option )**
-   @error exits with status E_OPTS (81)
-   **unknown_option_simple_error ( option )**
-   @error exits with status E_OPTS (81)
-   **command_error ( cmd )**
-   @error exits with status E_CMD (82)
-   **command_simple_error ( cmd )**
-   @error exits with status E_CMD (82)
-   **path_error ( path )**
-   @error exits with status E_PATH (83)
-   **path_simple_error ( path )**
-   @error exits with status E_PATH (83)

## VCS (line 757)

-   @ VCSVERSION : variable used as version marker like `branch@commit_sha`
-   @ SCRIPT_VCS : VCS type of the script (only 'git' for now)
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
-   @ CURRENT_GIT_CLONE_DIR : environment variable to store current GIT clone directory
-   **git_is_clone ( path = pwd , remote_url = null )**
-   **git_get_branch ( path = pwd )**
-   **git_get_commit ( path = pwd )**
-   **git_get_version ( path = pwd )**
-   **git_get_remote_version ( path = pwd , branch = HEAD )**
-   **git_make_clone ( repository_url , target_dir = LIB_SYSCACHEDIR )**
-   @env clone directory is loaded in CURRENT_GIT_CLONE_DIR
-   **git_update_clone ( target_dir )**
-   @param target_dir: name of the clone in LIB_SYSCACHEDIR or full path of concerned clone
-   **git_change_branch ( target_dir , branch = 'master' )**
-   @param target_dir: name of the clone in LIB_SYSCACHEDIR or full path of concerned clone

## COLORIZED CONTENTS (line 1022)

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
-   **get_text_option_tag_close ( name )**
    @param name must be in LIBTEXTOPTIONS
-   **colorize ( string , text_option , foreground , background )**
    @param text_option must be in LIBTEXTOPTIONS
    @param foreground must be in LIBCOLORS
    @param background must be in LIBCOLORS
-   **parse_color_tags ( "string with <bold>tags</bold>" )**
-   **strip_colors ( string )**

## TEMPORARY FILES (line 1188)

-   **get_tempdir_path ( dirname = "LIB_TEMPDIR" )**
    @param dirname The name of the directory to create (default is `tmp/`)
-   **get_tempfile_path ( filename , dirname = "LIB_TEMPDIR" )**
    @param filename The temporary filename to use
    @param dirname The name of the directory to create (default is `tmp/`)
-   **create_tempdir ( dirname = "LIB_TEMPDIR" )**
    @param dirname The name of the directory to create (default is `tmp/`)
-   **clear_tempdir ( dirname = "LIB_TEMPDIR" )**
    @param dirname The name of the directory (default is `tmp/`)
-   **clear_tempfiles ( dirname = "LIB_TEMPDIR" )**
    @param dirname The name of the directory (default is `tmp/`)

## LOG FILES (line 1275)

-   **get_log_filepath ()**
-   **log ( message , type='' )**
-   **read_log ()**

## CONFIGURATION FILES (line 1313)

-   **get_global_configfile ( file_name )**
-   **get_user_configfile ( file_name )**
-   **read_config ( file_name )**
-   **read_configfile ( file_path )**
-   **write_configfile ( file_path , array_keys , array_values )**
-   **set_configval ( file_path , key , value )**
-   **get_configval ( file_path , key )**
-   **build_configstring ( array_keys , array_values )**

## SCRIPT OPTIONS / ARGUMENTS (line 1466)

-   **get_short_options_array ()**
-   **get_short_options_string ( delimiter = '|' )**
-   **get_long_options_array ()**
-   **get_long_options_string ( delimiter = '|' )**
-   **get_option_arg ( "$x" )**
-   **get_long_option ( "$x" )**
-   **get_long_option_arg ( "$x" )**
-   **get_next_argument ()**
-   **get_last_argument ()**
-   **rearrange_script_options ( "$@" )**
-   **parse_common_options_strict ( "$@" = SCRIPT_OPTS )**
-   **parse_common_options ( "$@" = SCRIPT_OPTS )**

## SCRIPT INFOS (line 1698)

-   **get_script_version_string ( quiet = false )**
-   **script_title ( lib = false )**
-   **script_short_title ()**
-   **script_usage ()**
-   **script_long_usage ( synopsis = SYNOPSIS_ERROR , options_string = COMMON_OPTIONS_USAGE )**
-   **script_help ( lib_info = true )**
-   **script_manpage ( cmd = $0 , section = 3 )**
-   **script_short_version ( quiet = false )**
-   **script_version ( quiet = false )**

## DOCBUILDER (line 1910)

-   @ DOCBUILDER_MASKS = ()
-   @ DOCBUILDER_MARKER = '##@!@##'
-   @ DOCBUILDER_RULES = ( ... )
-   **build_documentation ( type = TERMINAL , output = null , source = BASH_SOURCE[0] )**
-   **generate_documentation ( filepath = BASH_SOURCE[0] , output = null )**

## LIBRARY INFOS (line 2018)

-   **get_library_version_string ( path = $0 )**
-   **library_info ()**
-   **library_path ()**
-   **library_help ()**
-   **library_usage ()**
-   **library_short_version ( quiet = false )**
-   **library_version ( quiet = false )**
-   **library_debug ( "$*" )**
-   **/ libdebug ( "$*" )**

## LIBRARY INTERNALS (line 2140)

-   @ LIBRARY_REALPATH LIBRARY_DIR LIBRARY_BASEDIR LIBRARY_SOURCEFILE
-   **make_library_homedir ()**
-   **make_library_cachedir ()**
-   **clean_library_cachedir ()**

## INSTALLATION WIZARD (line 2165)

-   @ INSTALLATION_VARS = ( SCRIPT_VCS VCSVERSION SCRIPT_REPOSITORY_URL SCRIPT_FILES SCRIPT_FILES_BIN SCRIPT_FILES_MAN SCRIPT_FILES_CONF ) (read-only)
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

## COMPATIBILITY (line 2317)


----

[*Doc generated at 16-4-2014 11:27:34 from path 'src/piwi-bash-library.sh'*]
