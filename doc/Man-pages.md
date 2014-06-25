Man pages - Piwi-Bash-Library
=============================

The library can construct a kind of **manpage** for each script, as the manual string
of the library itself.

For a full example, see the `bin/manpage-test.sh` script.

From any demo script, use the option `--libhelp` to see the library manpage.


## Structure

The library builds its manpages using some variables defined in each script. As long as one
of these variables is defined, it will be shown in the concerned manpage. You can create rich
contents using [tagged strings](Colorized-contents.md) for all of these texts.

These variables are the entries of the `MANPAGE_INFOS` array and tries to follow the common
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

Doing so for each `MANPAGE_INFOS` entries, these values will be used to construct the final
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


## Sample

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
