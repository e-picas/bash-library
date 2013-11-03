Common options - Piwi-Bash-Library
==================================

The library handles, if you say so, a set of commonly used arguments that enables/disables
a set of flags or actions commonly used. See the [Scripts Usage](Scripts-Usage.md) document
for a coding usage review.

For a full example with custom options, see the `bin/getopts-test.sh` script.


## Interactions & informations

**-v** | **--verbose**
:   increase verbosity of the script ;

**-x** | **--debug**
:   drastically increase verbosity of the script ;

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

**--dry-run**
:   some commands will be shown but not really executed ;

These options just enables or disables a constant flag in the environment; to make
them really "works", you will need to use some of the related functions of the library.
See the [Global documentation](Global-doc.md) to learn more.

## Man-page for each script

**-h** | **--help**
:   get a help string about current script ;

**--usage**
:   get a usage string about current script ;

**--man**
:   will try to open a man page of the current script if it exists, or show the usage string
    about current script if not ;

**-V** | **--vers** | **--version**
:   get the script version if available ; you can use
    the `quiet` option to only have the version number ; by default, this will write the
    version number, the last commit hash and the last commit date ;

See the specific [Man-pages](Man-pages.md) and [Versioning](Versioning.md) documentation for more infos.

## Library infos

**--libvers** | **--libversion** | **--lib-vers** | **--lib-version**
:   get the version number of the library ; you can use
    the `quiet` option to only have the version number ; by default, this will write the
    version number, the last commit hash and the last commit date ;


--------------

Documentation page for the [Piwi Bash Library](http://github.com/atelierspierrot/piwi-bash-library).
