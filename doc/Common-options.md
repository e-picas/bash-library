Common options - Bash-Library
=============================

The library handles, if you say so, a set of commonly used arguments that enable/disable
a set of flags or actions commonly useful.

For a full example with custom options, see the `bin/getopts-test.sh` script.


## Usage

To use common options in a script, just call the `parsecommonoptions` method passing it
the script arguments:

    #!/bin/bash
    source path/to/bash-library.sh
    parsecomonoptions "$@"

After that, if you want to define and use some custom options, you can write (here for the 
custom options '-t' and '--test' with arguments):

    OPTIND=1
    while getopts "t:${COMMON_OPTIONS_ARGS}" OPTION; do
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

To get the full array of arguments before any `--` sign (which may notify the end of the
command line arguments), you can use:

    FULL_OPTIONS=`getscriptoptions "$@"`


## List of library's common options

### Interactions & informations

-   **-v | --verbose**: increase verbosity of the script,
-   **-x | --debug**: drastically increase verbosity of the script,
-   **-q | --quiet**: drastically decrease verbosity of the script, only errors are shown,
-   **-i | --interactive**: the script will ask confirmation before some actions,
-   **-f | --force**: force actions to execute, no confirmation is asked when possible,
-   **-d | --working-dir=PATH**: redefine the working directory (default is the current directory).

These options just enables or disables a constant flag in the environment ; to make
them really "works", you will need to use some of the related functions of the library.
See the [Global documentation](Global-doc.md) to learn more.

### Man-page for each script

-   **-h | --help | --man | --usage**: get a sort of man-page about current script,
-   **-V | --vers | --version**: get the script version if available.

See the specific [Man-pages](Man-pages.md) and [Versioning](Versioning.md) documentation for more infos.

### Library infos

-   **--libhelp**: get the man-page of the library,
-   **--libvers**: get the version of the library.

--------------

Documentation page for the [Bash Library of Les Ateliers Pierrot](https://github.com/atelierspierrot/bash-library).
