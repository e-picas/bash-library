Help & Manpages - Piwi-Bash-Library
===================================

The library can construct a **usage** string to quickly inform user about a script "how-to"
and a kind of **manpage** for each script, as the manual string of the library itself.

For a full example, see the `bin/manpage-test.sh` script.

## Presentation

Like for any other command (especially GNU ones) it is important to inform user about how
a command using the library works: the available options and their meanings, the various
actions featured by the script and other informations as a presentation, the concerned
files etc. The library can help building these informations in four ways:

-   it can build a very simple "synopsis" in case of error and displayed using the
    `--usage` option
-   it can build a simple "usage" string ; it is displayed using the `--help` option
    or after an error
-   it can build a less simple "manpage-like" information, displayed using the `--man` option
-    it can build a classic "version" string, displayed using the `--version`

The library builds these strings using some variables defined in each script. As long as one
of these variables is defined, it will be shown in the concerned string. You can create rich
contents using [tagged strings](Colorized-contents.md) for all of these texts.


## Global variables

The very first thing to do when you use the library in your scripts is to define the variables
contained in the `SCRIPT_VARS` table. They are used in many ways (for instance in the
"fallback" system described below). Please refer to the [Documentation](../DOCUMENTATION.md)
of your library's version for the last variables'list to use.

    SCRIPT_VARS=(

        # these are highly recommended:

        NAME            # the name of your script
        VERSION         # the version number : X.Y.Z(-alpha/beta/...)
        DATE            # the date of this version
        DESCRIPTION     # a short presentation of the script
        LICENSE         # the license type protecting the script
        HOMEPAGE        # an URL of the script sources or your command website
        SYNOPSIS        # your script's general synopsis
        OPTIONS         # your script's options description
        
        # these are optional:
        
        EXAMPLES        # examples infos
        EXIT_STATUS     # exist statuses if so
        FILES           # concerned files
        ENVIRONMENT     # environment variables
        COPYRIGHT       # copyright info
        BUGS            # how to transmit bugs infos
        AUTHOR          # author's infos
        SEE_ALSO        # see alos infos
        COPYRIGHT       # copyright info
        LICENSE         # license info specific for "version"
        SOURCES         # sources info (defaults to HOMEPAGE)
        ADDITIONAL_INFO # a random and free aditionnal information

    )

The `NAME`, `VERSION` and `DESCRIPTION` variables are important as they will be used in all the
informational strings. The `DATE` variable MAY be defined, but is not required if you use the 
[internal versioning system](Versioning-Licensing.md). For each of the informational strings
described in this document, only the `NAME`, `VERSION` and `DATE` will NEVER be replaced by their
suffixed equivalent.


### Using library defaults

The library defines some common entries for all the informational strings you can use as shortcuts:

    COMMON_OPTIONS_MANPAGE and COMMON_OPTIONS_USAGE : simple lists of available common options
    COMMON_OPTIONS_FULLINFO_MANPAGE : an "options" information presenting the common library options

    COMMON_SYNOPSIS : the default bash script usage synopsis
    COMMON_SYNOPSIS_ACTION : the default bash script usage synopsis for a script with "action" argument
    COMMON_SYNOPSIS_ERROR : the default bash script usage synopsis shown for the error short string

### Library dependency

By default, the manpage of a script will include a `Dependencies` section presenting the
library itself, its version, license and homepage. You can avoid this behavior defining:

    MANPAGE_NODEPEDENCY=true

### Fallback system

For all the variables defined in this documentation, a simple fallback rule is designed to use
the "global" variable if the specific one is not found.

For instance, usage string uses the `SYNOPSIS_USAGE` variable but will finally use the simple
`SYNOPSIS` variable if the first one was not found.

In some cases (when the information seems important and relevant) the library will finally use
its own internal equivalent strings if no other was found.


## Synopsis string

The synopsis is a simple reminder of all available options and arguments, without description,
the script can accept. It is built using the `SYNOPSIS_ERROR` variable, which defaults to
the simple `SYNOPSIS`, which itself defaults to the library's `COMMON_SYNOPSIS`.

    SYNOPSIS_ERROR # long synopsis used in case of error


## Usage string

The usage information string is constructed using the entries defined in the `USAGE_VARS`
array and uses the `_USAGE` suffix:

    USAGE_VARS=(
        NAME                 # global var
        VERSION              # global var
        DATE                 # global var
        DESCRIPTION_USAGE    # presentation used only for the "usage" string
        SYNOPSIS_USAGE       # synopsis used only for the "usage" string
        OPTIONS_USAGE        # options description used only for the "usage" string
    )


## Manpage string

These variables are the entries of the `MANPAGE_VARS` array and tries to follow the common
manpages structure ; they use the `_MANPAGE` suffix:

    MANPAGE_VARS=(
        NAME                      # global var
        VERSION                   # global var
        DATE                      # global var
        SYNOPSIS                  # global var
        DESCRIPTION_MANPAGE       # special long description used only for "man" string
        OPTIONS_MANPAGE           # global var
        EXAMPLES_MANPAGE          # examples infos
        EXIT_STATUS_MANPAGE       # exist statuses if so
        FILES_MANPAGE             # concerned files
        ENVIRONMENT_MANPAGE       # environment variables
        COPYRIGHT_MANPAGE         # copyright info
        BUGS_MANPAGE              # how to transmit bugs infos
        AUTHOR_MANPAGE            # author's infos
        SEE_ALSO_MANPAGE          # see alos infos
    )

To define a script description, just write in your script:

    DESCRIPTION="\
    my description\n\
    my <bold>tagged text</bold>\n\
    ...";

Doing so for each `MANPAGE_VARS` entries, these values will be used to construct the final
manpage.

If you need to overwrite the full result of the `--man` option, you can define in your script
the `USAGE` global variable. Doing so, nothing will be added to your string (it replaces the
whole manpage construction).

NOTE - Please note that the result is NOT a true UNIX manpage but just a string written on
terminal.


## GNU version string

The library also handles the construction of a "classic" GNU version string, with the name and
version of the script, its license and copyright informations and a random additional string.

To define these strings in your script, you must define each item of the `VERSION_VARS` table:

    VERSION_VARS=(
        NAME            # global var
        VERSION         # global var
        DATE            # global var
        DESCRIPTION     # global var
        COPYRIGHT       # copyright info
        LICENSE         # license info specific for "version"
        SOURCES         # sources info (defaults to HOMEPAGE)
        ADDITIONAL_INFO # a random and free aditionnal information
    )


## Samples

Below is the sample of the `bin/getopts-test.sh` manpage ; have a look in the script to
learn how it is constructed.

-   the `--version` option:

        Piwi Bash library 1.0.1 wip@292de0572d7a45e71bc22eaf9427908725a64ec3
        An open source day-to-day bash library
        Copyright (c) 2013-2014 Les Ateliers Pierrot <http://www.ateliers-pierrot.fr/>
        License GPL-3.0: <http://www.gnu.org/licenses/gpl-3.0.html>
        Sources & updates: <https://github.com/atelierspierrot/piwi-bash-library>
        This is free software: you are free to change and redistribute it ; there is NO WARRANTY, to the extent permitted by law.

-   the `--usage` option:

        usage: bin/getopts-test.sh  [-h|f|i|q|v|x|V|d|l]
            [-a]  [-t [=value]]  [--test [=value]]  --  <arguments>
        Run option '-h' for help.

-   the `--help` option:

        Bash-Lib script options & arguments test 0.1.0 [wip@292de0572d7a45e71bc22eaf9427908725a64ec3]
        A script to test custom script options & arguments usage ...
        To test it, run:

            ~$ path/to/getopts-test.sh myaction1 -vi -t "two words" -a -f --test="three wor ds" myaction2 -- myaction3 -x

        usage: bin/getopts-test.sh -[common options] -[script options [=value]] [--] [arguments]

            -t, --test=ARG            test a short and long option with argument
            -a                        a single short option to test options order
            -v, --verbose            increase script verbosity
            -q, --quiet                decrease script verbosity, nothing will be written unless errors
            -f, --force                force some commands to not prompt confirmation
            -i, --interactive        ask for confirmation before any action
            -x, --debug                enable debug mode
            -d, --working-dir=PATH    redefine the working directory (default is 'pwd' - 'PATH' must exist)
            -l, --log=FILENAME        define the log filename to use (default is 'piwibashlib.log')
            --dry-run                see commands to run but not run them actually

            -V, --version    see the script version when available
                            use option '-q' to get the version number only
            -h, --help        show this information message
            --usage            show quick usage information
            --man            see the current script manpage if available
                            a 'manpage-like' output will be guessed otherwise
            --libvers        see the library version

-   the `--man` option:

        NAME
            Bash-Lib script options & arguments test - v. [0.0.1-test]

        SYNOPSIS
            ~$ bin/getopts-test.sh -[COMMON OPTIONS] -[SCRIPT OPTIONS [=VALUE]] [ARGUMENTS] --

        DESCRIPTION
            A script to test custom script options & arguments usage ...
            To test it, run:
                ~$ path/to/getopts-test.sh -vi -t "two words" -a -q --test="three wor ds" -- -x
            Result is:
                - the first common options 'v' and 'i' are parsed and considered by the library,
                - the third common option 'q' is parsed but NOT considered by the library as it is after a custom option,
                - the custom 't' and 'test' options are parsed and considered by this script and their multi-words arguments are red,
                - the custom 'a' option is parsed and considered by this script,
                - the last common option 'x' is NOT parsed at all as it is after '--'.

        OPTIONS
            -t, --test=ARG    test a short and long option with argument
            -a        a single short option to test options order

            Common options (to use first):
            -h, --help    show this information message
            -v, --verbose    increase script verbosity
            -q, --quiet    decrease script verbosity, nothing will be written unless errors
            -f, --force    force some commands to not prompt confirmation
            -i, --interactive    ask for confirmation before any action
            -x, --debug    see commands to run but not run them actually
            --libvers    see the library version
            --libhelp    see the library manpage

        You can group short options like '-xc', set an option argument like '-d(=)value'
        or '--long=value' and use '--' to explicitly specify the end of the script options.

        DEPENDENCIES
            This script is based on the Bash shell library, "The open source bash library of Les Ateliers Pierrot".
            Package [atelierspierrot/piwi-bash-library] version [0.0.1].
            Licensed under GPL-3.0 - Copyleft (c) Les Ateliers Pierrot <http://www.ateliers-pierrot.fr/> - Some rights reserved.
            For sources & updates, see <http://github.com/atelierspierrot/piwi-bash-library>.
            For bug reports, see <http://github.com/atelierspierrot/piwi-bash-library/issues>.

--------------

Documentation page for the [Piwi Bash Library](http://github.com/atelierspierrot/piwi-bash-library).

**(c) 2013-2014 [Les Ateliers Pierrot](http://www.ateliers-pierrot.fr/)** - Paris, France - Some rights reserved.

This documentation is licensed under the [Creative Commons - Attribution - Share Alike - Unported - version 3.0](http://creativecommons.org/licenses/by-sa/3.0/) license.
