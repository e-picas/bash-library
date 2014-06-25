#!/bin/bash

declare -xa ORIGINAL_DATA=(getsysteminfo getmachinename getscriptpath setworkingdir setlogfilename getextension getfilename getbasename getdirname strlen strtoupper strtolower ucfirst explodeletters onoffbit isgitclone get_gitbranch get_gitcommit make_git_clone update_git_clone change_git_branch nooptionerror commanderror patherror nooptionsimpleerror commandsimpleerror pathsimpleerror gnuerrorstr gettextformattag getcolorcode getcolortag gettextoptioncode gettextoptiontag gettextoptiontagclose parsecolortags stripcolors gettempdirpath gettempfilepath createtempdir cleartempdir cleartempfiles getlogfilepath readlog getglobalconfigfile getuserconfigfile readconfig readconfigfile writeconfigfile setconfigval getconfigval buildconfigstring getshortoptionsarray getshortoptionsstring getlongoptionsarray getlongoptionsstring getoptionarg getlongoption getlongoptionarg getnextargument getlastargument rearrangescriptoptions parsecommonoptions_strict parsecommonoptions script_shortversion library_shortversion gitversion )
declare -xa REPLACE_DATA=(get_system_info get_machine_name get_script_path set_working_directory set_log_filename get_extension get_filename get_basename get_dirname string_length string_to_upper string_to_lower upper_case_first explode_letters onoff_bit git_is_clone git_get_branch git_get_commit git_make_clone git_update_clone git_change_branch nooption_error command_error path_error nooption_simple_error command_simple_error path_simple_error gnu_error_string get_text_format_tag get_color_code get_color_tag get_text_option_code get_text_option_tag get_text_option_tag_close parse_color_tags strip_colors get_tempdir_path get_temp_filepath create_tempdir clear_tempdir clear_tempfiles get_log_filepath read_log get_global_configfile get_user_configfile read_config read_configfile write_configfile set_configval get_configval build_configstring get_short_options_array get_short_options_string get_long_options_array get_long_options_string get_option_arg get_long_option get_long_option_arg get_next_argument get_last_argument rearrange_script_options parse_common_options_strict parse_common_options script_short_version library_short_version git_get_version )

for i in ${!ORIGINAL_DATA[@]}; do
    _originalword=${ORIGINAL_DATA[${i}]}
    _replacementword=${REPLACE_DATA[${i}]}
    echo "> replacing '${_originalword}' by '${_replacementword}'"
    for file in `grep -lr --exclude=build/* -e "${_originalword}" *`; do
        echo $file
        sed -i '' "s/${_originalword}/${_replacementword}/g" "${file}"
    done
done
