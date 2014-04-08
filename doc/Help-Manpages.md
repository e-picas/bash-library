Help & Manpages - Piwi-Bash-Library
===================================

The library can construct a **usage** string to quickly inform user about a script "how-to"
and a kind of **manpage** for each script, as the manual string of the library itself.

For a full example, see the `bin/manpage-test.sh` script.

## Presentation

Like for any other command (especially GNU ones) it is important to inform user about how
a command using the library works: the available options and their meanings, the various
actions featured by the script and other informations as a presentation, the concerned
files etc. The library can help building these informations in three ways:

-   it can build a very simple "synopsis" in case of error
-   it can build a simple "usage" string (displayed after an error for instance)
-   it can build a less simple "manpage-like" information

The **usage** string is considered as the script's "help" and is displayed using the `--help`
option and the **manpage** one is displayed using the `--man` option.

The library builds these strings using some variables defined in each script. As long as one
of these variables is defined, it will be shown in the concerned string. You can create rich
contents using [tagged strings](Colorized-contents.md) for all of these texts.


## Synopsis string

The synopsis is a simple reminder of all available options and arguments, without description,
the script can accept. It is built using the `SYNOPSIS_ERROR` variable, which defaults to
the simple `SYNOPSIS`, which itself defaults to the library's `LIB_SYNOPSIS`.


## Usage string

The usage information string is constructed using the entries defined in the `USAGE_VARS`
array:

    NAME
    VERSION
    PRESENTATION
    SYNOPSIS_USAGE
    OPTIONS_USAGE



## Manpage string

These variables are the entries of the `MANPAGE_VARS` array and tries to follow the common
manpages structure:

    SYNOPSIS
    DESCRIPTION
    OPTIONS
    FILES
    ENVIRONMENT
    BUGS
    AUTHOR
    SEE_ALSO

To define a script description, just write in your script:

    DESCRIPTION="\
    my description\n\
    my <bold>tagged text</bold>\n\
    ...";

Doing so for each `MANPAGE_VARS` entries, these values will be used to construct the final
manpage.

NOTE - Please note that the result is NOT a true UNIX manpage but just a string written on
terminal.

### Using library defaults

The library defines some common entries for manpages you can use as shortcuts:

    $COMMON_OPTIONS_INFO : an "options" information presenting the common library options
    $LIB_SYNOPSIS : the default bash script usage synopsis

### Library dependency

By default, the manpage of a script will include a `Dependencies` section presenting the
library itself, its version, license and homepage. You can avoid this behavior defining:

    MANPAGE_NODEPEDENCY=true


## Samples

Below is the sample of the `bin/getopts-test.sh` manpage ; have a look in the script to
learn how it is constructed.

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
        -t, --test=ARG	test a short and long option with argument
        -a		a single short option to test options order

        Common options (to use first):
        -h, --help	show this information message 
        -v, --verbose	increase script verbosity 
        -q, --quiet	decrease script verbosity, nothing will be written unless errors 
        -f, --force	force some commands to not prompt confirmation 
        -i, --interactive	ask for confirmation before any action 
        -x, --debug	see commands to run but not run them actually 
        --libvers	see the library version 
        --libhelp	see the library manpage 

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
