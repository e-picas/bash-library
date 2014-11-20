Scripts Usage - Piwi-Bash-Library
=================================

This document explains the global and common usage of command line scripts as hanlded and
expected by the library.

For a full example and an help for this tutorial, see the `demo/getopts-test.sh` script.


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

    ~$ mycommand ...
    OR
    ~$ ./path/to/mycommand ...

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


## Implementation in the library

### Re-arrangement of script options 

The library can rearrange options and arguments to safely prepare and parse them. To do so, 
you need to write something like:

    rearrange_script_options "$@"
    [ "${#SCRIPT_OPTS[@]}" -gt 0 ] && set -- "${SCRIPT_OPTS[@]}";
    [ "${#SCRIPT_ARGS[@]}" -gt 0 ] && set -- "${SCRIPT_ARGS[@]}";
    [ "${#SCRIPT_OPTS[@]}" -gt 0 -a "${#SCRIPT_ARGS[@]}" -gt 0 ] && set -- "${SCRIPT_OPTS[@]}" -- "${SCRIPT_ARGS[@]}";

The `rearrange_script_options` method will load script options in the `SCRIPT_OPTS` variable 
and the arguments in the `SCRIPT_ARGS` variable. As it is not possible to reset the global
command line positional parameters inside a function, you need to manually redefine them
using the `set` program as shown above. Doing so, you can be safely sure after these lines
to have the correct options, loaded with their arguments if so (even if they are multi-words)
and the script arguments.

### Dealing with arguments

The library defines some methods to get and treat script arguments (global arguments, not
options' arguments). It defines and uses a new environment variable named `ARGIND` which
indicates the current argument index, just like `OPTIND` works for options with `getopts`.

To get and loop over arguments, you can use the `get_next_arguments` method, which will load
the "next" argument (the first one for a first usage) in the `ARGUMENT` variable and increments
`ARGIND` by one:

    # initialy
    echo $ARGIND
    0
    echo $ARGUMENT
    ''

    # first usage
    get_next_argument
    echo $ARGIND
    1
    echo $ARGUMENT
    first-arg

    # then, while a next argument is available
    get_next_argument
    echo $ARGIND
    n+1
    echo $ARGUMENT
    n-arg

For facility, a `get_last_argument` method is defined to get the last one directly. The `ARGIND`
indexer is not concerned.

### Usage of common options

To use common options in a script, just call the `parse_common_options` method passing it
the script arguments:

    #!/bin/bash
    source path/to/piwi-bash-library.sh
    parse_common_options "$@"

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

    LONGOPTARG="`get_long_option_arg \"${OPTARG}\"`"


### Options parsing and error reporting

A special `parse_common_options_strict` method is defined as an alias of the classic
`parse_common_options` but throwing an error for undefined options. To use it, you MUST
define both `OPTIONS_ALLOWED` and `LONG_OPTIONS_ALLOWED` strings in your script as they
are used to define known options names. You can use the library `COMMON_OPTIONS_ALLOWED`
and `COMMON_LONG_OPTIONS_ALLOWED` and complete them with your own options, like:

    OPTIONS_ALLOWED="t:a${COMMON_OPTIONS_ALLOWED}"
    LONG_OPTIONS_ALLOWED="test:,${COMMON_LONG_OPTIONS_ALLOWED}"

This way, the `parse_common_options_strict` method will consider the '-t' option as allowed
but will throw an error with the '-z' option that seems not allowed. It works the same for
long options.


## Full example

Below is a complete example of a script which first re-arrange the command line call and then
parse the common options throwing an error for unknown options (taken from the `demo/getopts-test.sh`
test script).

    OPTIONS_ALLOWED="t:a${COMMON_OPTIONS_ALLOWED}"
    LONG_OPTIONS_ALLOWED="test:,${COMMON_LONG_OPTIONS_ALLOWED}"

    rearrange_script_options "$@"
    [ "${#SCRIPT_OPTS[@]}" -gt 0 ] && set -- "${SCRIPT_OPTS[@]}";
    [ "${#SCRIPT_ARGS[@]}" -gt 0 ] && set -- "${SCRIPT_ARGS[@]}";
    [ "${#SCRIPT_OPTS[@]}" -gt 0 -a "${#SCRIPT_ARGS[@]}" -gt 0 ] && set -- "${SCRIPT_OPTS[@]}" -- "${SCRIPT_ARGS[@]}";

    parse_common_options_strict

    # own options usage
    OPTIND=1
    while getopts ":at:${OPTIONS_ALLOWED}" OPTION; do
        OPTARG="${OPTARG#=}"
        case $OPTION in
            t) _echo " - option 't': receiving argument \"${OPTARG}\"";;
            a) echo " - test option A";;
            -)  # for long options with argument, use fct 'get_long_option_arg ( $arg )'
                LONGOPTARG="`get_long_option_arg \"${OPTARG}\"`"
                case $OPTARG in
                    test*) _echo " - option 'test': receiving argument \"${LONGOPTARG}\"";;
                    ?) echo " - unknown long option '$OPTARG'";;
                esac ;;
            ?) echo " - unknown option '$OPTION'";;
        esac
    done

    # arguments usage
    lastarg=$(get_last_argument)
    echo " - last argument is '${lastarg}'"

    get_next_argument
    echo " - first argument is '$ARGUMENT'"
    get_next_argument
    echo " - next argument is '$ARGUMENT'"

    echo " - final 'ARGIND' is: $ARGIND"


--------------

Documentation page for the [Piwi Bash Library](http://github.com/atelierspierrot/piwi-bash-library).

**(c) 2013-2014 [Les Ateliers Pierrot](http://www.ateliers-pierrot.fr/)** - Paris, France - Some rights reserved.

This documentation is licensed under the [Creative Commons - Attribution - Share Alike - Unported - version 3.0](http://creativecommons.org/licenses/by-sa/3.0/) license.
