Common options - Bash-Library
=============================

The library handles, if you say so, a set of commonly used arguments that enable/disable
a set of flags or actions commonly useful.

For a full example with custom options, see the `bin/getopts-test.sh` script.


## Interactions & informations

-   **-v | --verbose**: increase verbosity of the script,
-   **-x | --debug**: drastically increase verbosity of the script,
-   **-q | --quiet**: drastically decrease verbosity of the script, only errors are shown,
-   **-i | --interactive**: the script will ask confirmation before some actions,
-   **-f | --force**: force actions to execute, no confirmation is asked when possible.

These options just enables or disables a constant flag in the environment ; to make
them really "works", you will need to use some of the related functions of the library.


## Man-page for each script

-   **-h | --help**: get a sort of man-page about current script.

See the specific [Man-pages](Man-pages.md) documentation for more infos.


## Library infos

-   **--libhelp**: get the man-page of the library,
-   **--libvers**: get the version of the library.

--------------

Documentation page for the [Bash Library of Les Ateliers Pierrot](https://github.com/atelierspierrot/bash-library).
