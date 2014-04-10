#!/bin/bash
#
# Run this script at the root directory of a package when upgrading your version of the
# library from version 1.* to 2.*
#

######## Inclusion of the lib
LIBFILE="`dirname $0`/../src/piwi-bash-library.sh"
if [ -f "${LIBFILE}" ]; then source "${LIBFILE}"; else
    PADDER=$(printf '%0.1s' "#"{1..1000})
    printf "\n### %*.*s\n    %s\n    %s\n%*.*s\n\n" 0 $(($(tput cols)-4)) "ERROR! ${PADDER}" \
        "Unable to find required library file '${LIBFILE}'!" \
        "Sent in '$0' line '${LINENO}' by '`whoami`' - pwd is '`pwd`'" \
        0 $(tput cols) "${PADDER}";
    exit 1
fi
######## !Inclusion of the lib

declare -xa ORIGINAL_DATA=(getsysteminfo writeconfigfile VERSION_INFOS update_git_clone stripcolors setworkingdir setlogfilename setconfigval script_shortversion SCRIPT_INFOS rearrangescriptoptions readlog readconfigfile readconfig pathsimpleerror patherror parsecommonoptions_strict parsecommonoptions parsecolortags OPTIONS_USAGE_INFOS onoffbit nooptionsimpleerror nooptionerror MANPAGE_INFOS make_git_clone library_shortversion LIB_SYNOPSIS_ERROR LIB_SYNOPSIS_ACTION LIB_SYNOPSIS LIB_GITVERSION LIB_COPYRIGHT_TYPE LIB_COLORS isgitclone gnuerrorstr GITVERSION_MASK gitversion getuserconfigfile gettextoptiontagclose gettextoptiontag gettextoptioncode gettextformattag gettempfilepath gettempdirpath getshortoptionsstring getshortoptionsarray getscriptpath getoptionarg getnextargument getmachinename getlongoptionsstring getlongoptionsarray getlongoptionarg getlongoption getlogfilepath getlastargument getglobalconfigfile getfilename getextension getdirname getconfigval getcolortag getcolorcode getbasename get_gitcommit get_gitbranch explodeletters DESCRIPTION createtempdir COMMON_OPTIONS_LIST COMMON_OPTIONS_FULLINFO commandsimpleerror commanderror cleartempfiles cleartempdir change_git_branch buildconfigstring @gitversion@ @git_get_version@)
declare -xa REPLACE_DATA=(get_system_info write_configfile VERSION_VARS git_update_clone strip_colors set_working_directory set_log_filename set_configval script_short_version SCRIPT_VARS rearrange_script_options read_log read_configfile read_config path_simple_error path_error parse_common_options_strict parse_common_options parse_color_tags OPTIONS_ADDITIONAL_INFOS_MANPAGE onoff_bit no_option_simple_error no_option_error MANPAGE_VARS git_make_clone library_short_version COMMON_SYNOPSIS_ERROR COMMON_SYNOPSIS_ACTION COMMON_SYNOPSIS LIB_VCSVERSION LIB_COPYRIGHT COLOR_VARS git_is_clone gnu_error_string VCSVERSION_MASK git_get_version get_user_configfile get_text_option_tag_close get_text_option_tag get_text_option_code get_text_format_tag get_tempfile_path get_tempdir_path get_short_options_string get_short_options_array get_script_path get_option_arg get_next_argument get_machine_name get_long_options_string get_long_options_array get_long_option_arg get_long_option get_log_filepath get_last_argument get_global_configfile get_filename get_extension get_dirname get_configval get_color_tag get_color_code get_basename git_get_commit git_get_branch explode_letters DESCRIPTION_MANPAGE create_tempdir COMMON_OPTIONS_MANPAGE COMMON_OPTIONS_FULLINFO_MANPAGE command_simple_error command_error clear_tempfiles clear_tempdir git_change_branch build_configstring @vcsversion@ @vcsversion@)

echo "> upgrading scripts from versio 1.* to 2.* ..."

for i in ${!ORIGINAL_DATA[@]}; do
    _originalword=${ORIGINAL_DATA[${i}]}
    _replacementword=${REPLACE_DATA[${i}]}
    echo "> replacing '${_originalword}' by '${_replacementword}'"
    for file in `grep -lr --exclude=piwi-bash-lib* --exclude=build/* -e "${_originalword}" *`; do
        echo $file
        if `in_array ${USEROS} ${LINUX_OS[@]}`
            then sed -i "s/${_originalword}/${_replacementword}/g" "${file}"
            else sed -i '' "s/${_originalword}/${_replacementword}/g" "${file}"
        fi
    done
done

echo "_ ok, scripts upgraded (please double-check your scripts!)"
