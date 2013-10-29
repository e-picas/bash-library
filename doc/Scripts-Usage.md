Scripts Usage - Piwi-Bash-Library
=================================

This document explains the global and common usage of command line scripts as hanlded and
expected by the library.


## Classic script usage

The library tries to define the most classic usage of the command line scripts. A global
overview of this could be:

    ~$ path/to/script.sh  -flags((=)argument)  --long-option(=argument)  (--)  script arguments
             [1]                [2(a)]                  [2(b)]          [2(c)]       [3]

We can distinguish in this usage three entities that are explained below:

1.  the **program**
2.  some **options** with or without argument, required or not
3.  some **arguments** to pass to the script, required or not


### The program

It determines the executed script and, on some systems, the shell script to use. We can 
distinguish here an installed program and a local script file. In the first case, you will
just write the program's name, in the second, you may write the full relative path to the
executed file.

The path of the script may exist from you current working directory, or could be stored
in a directory that is included in the global `$PATH` environment variable, which is usually
a collection of system's and user's `bin/` directories. This is the case of programs.

Depending on the system you are running on, you may preceed the program name or the script
path calling explicitely the shell binary to use to parse it. On Darwin systems for instance,
you may run semthing like:

    ~$ bash path/to/script.sh
    OR
    ~$ sh path/to/script.sh

### The options

Most of programs or scripts may accept options. An option will, for instance, enable a special
environment variable (like verbosity), select a new working directory etc. Options can accept
arguments, optional or required, depending on script definitions.

We can here distinguish two types of "options" : the **short options**, also called **flags**,
and the **long options**. Most of the time, the short options are just an alias of a long
option, which name will have a real meaning, for quick script's usage.

#### The short options, or "flags"

A short option is one single letter prefixed by a dash: `-a`. It can accept an argument that
can be written in three equivalent ways:

    ~$ path/to/script.sh -a argument
    ~$ path/to/script.sh -a=argument
    ~$ path/to/script.sh -aargument

The short options can be grouped in a single string like `-ab` as long as there is no 
argument inside the group. An argument can be added to the last option of a group.

For instance, the followings are equivalent:

    ~$ path/to/script.sh -a -b=arg -c
    ~$ path/to/script.sh -ac -b=arg
    ~$ path/to/script.sh -acb=arg
    ~$ path/to/script.sh -ab=arg -c

The short options are also called "flags" because they are a single letter and they often
define a simple behaviour, such as rendering the script verbose, quiet, interactive etc.

#### The long options

A long option is a multi-letters string prefixed by a double-dash: `--my-option`. It can
accept an argument just like the short options, with the difference that the argument MUST
be separated from the option name by the equal sign: `--my-option=argument`. The long options
can NOT be grouped and are often written AFTER the short options.

#### The end of options

The end of command line options can be explicitely written using the special option `--`
(a double dash). This is NOT required but can be useful in some special cases with a long
set of options with arguments, to tell the script that the rest of the line will be global
arguments and not options' ones.

#### Note about options arguments

For both short and long options accepting an argument, this argument can be surrounded by
quotes:

    ~$ path/to/script.sh -a "my arg"

This is NOT required, except in the case where the argument contains a space or a special
character (like in the example above). Actually, on certain systems this is not required at 
all, but it is a good practice to ALWAYS use quotes for complicated arguments to be safely
system compliant.

### The arguments

Finally, the command line may contains some arguments that will be handled by the script.
The arguments may be distinguished from the options or the options arguments. They often
represent the "real" things handled by the script's logic while the options are used to
define some special behaviors during this logic. The arguments are just some strings written
"as is" at the end of the command line. They are NOT required, can be one, two or more.


## List of library's common options

The library handles, if you say so, a set of commonly used arguments that enables/disables
a set of flags or actions commonly used.

For a full example with custom options, see the `bin/getopts-test.sh` script.

### Interactions & informations

**-v** | **--verbose**
:   increase verbosity of the script ;

**-x** | **--debug** | **--dry-run**
:   drastically increase verbosity of the script ; some commands will be shown but not
    really executed ;

**-q** | **--quiet**
:   drastically decrease verbosity of the script ; only errors are shown ;

**-i** | **--interactive**
:   the script will ask confirmation before some actions ;

**-f** | **--force**
:   force actions to execute, no confirmation is asked when possible ;

**-d** | **--working-dir** *=path*
:   redefine the working directory (default is the current directory) ;

**-l** | **--log** *=filename*
:   redefine a log filename to use ;

These options just enables or disables a constant flag in the environment; to make
them really "works", you will need to use some of the related functions of the library.
See the [Global documentation](Global-doc.md) to learn more.

### Man-page for each script

**-h** | **--help** | **--usage**
:   get a usage string about current script ;

**--man**
:   will try to open a man page of the current script if it exists, or show the usage string
    about current script if not ;

**-V** | **--vers** | **--version**
:   get the script version if available ; you can use
    the `quiet` option to only have the version number ; by default, this will write the
    version number, the last commit hash and the last commit date ;

See the specific [Man-pages](Man-pages.md) and [Versioning](Versioning.md) documentation for more infos.

### Library infos

**--libhelp** | **--lib-help**
:   get the usage string of the library itself ;

**--libvers** | **--libversion** | **--lib-vers** | **--lib-version**
:   get the version number of the library ; you can use
    the `quiet` option to only have the version number ; by default, this will write the
    version number, the last commit hash and the last commit date ;

**--libdoc** | **--libdocumentation** | **--lib-doc** | **--lib-documentation**
:   get the library documentation by parsing its 
    source ; you can use the `verbose` option to increase rendering informations ;


## Usage of common options

To use common options in a script, just call the `parsecommonoptions` method passing it
the script arguments:

    #!/bin/bash
    source path/to/piwi-bash-library.sh
    parsecommonoptions "$@"

After that, if you want to define and use some custom options, you can write (here for the 
custom options '-t' and '--test' with arguments):

    OPTIND=1
    while getopts "t:${COMMON_OPTIONS_ALLOWED}" OPTION; do
        OPTARG="${OPTARG#=}"
        case $OPTION in
            t) 
                # your script for option 't' with argument $OPTARG
                ;;
            -) case $OPTARG in
                test) 
                    # your script for option 'test' with argument "${OPTARG#*=}"
                    ;;
                esac
            ;;
        esac
    done

To get any long option argument, you can use:

    LONGOPTARG="`getlongoptionarg \"${OPTARG}\"`"

To get the full array of options before any `--` sign (which may notify the end of the
command line options), you can use:

    FULL_OPTIONS=`getscriptoptions "$@"`


--------------

Documentation page for the [Piwi Bash Library](http://github.com/atelierspierrot/piwi-bash-library).
