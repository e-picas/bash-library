Man:        bash-library.sh Manual
Name:       Bash Shell Library
Author:     Les Ateliers Pierrot
Date: 2013-10-20
Version: 1.0.3


## NAME

bash-library - The open source bash library of Les Ateliers Pierrot

## SYNOPSIS

**bash-library-script [common options] [script options [=value]] [arguments] --**

**bash-library-script**  [**-h**|**-V**]  [**-x**|**-v**|**-i**|**-q**|**-f**]
    [**-d** *path*]  [**-l** *filename*]
    [script options ...] [arguments ...] --

## DESCRIPTION

**Bash**, the "*Bourne-Again-SHell*", is a *Unix shell* written for the GNU Project as a
free software replacement for the original Bourne shell (sh). The present library is a tool
for Bash scripts facilities. To use the library, just include its source file using:
`source path/to/bash-library.sh` and call its methods.

The library is NOT a script doing some work itself ; it is just a library. So running it
directly may not do anything. This manual explains the library itself, its options and
usage methods but you MAY keep in mind that the final manual page to read is the one of
the real script you will call, using the tools of the library to build its own work.

The following features are available using the library:

-   some common methods to work with strings and arrays in Bash
-   manage information messages like warnings and errors
-   manage a simple **help or usage information** for each script (just defining some variables
    in this script)
-   create some **colorized and styled content** for terminal output: some methods are designed
    to wrap a string between colored or styled tags, according to the current system running,
    and to build a colorized content using XML-like tags (`<mytag>my content</mytag>`)
-   manage a **configuration dotfile** for a script: some methods allows you to read, write,
    update and delete configuration values in a file
-   manage **temporary files** and **log files**
-   use a set of **common options** (described in next section) to let the user interact
    with the script, such as increase or decrease verbosity, make a dry run, ask to force 
    commands or to always prompt for confirmation

## OPTIONS

Each script depending on the library may define its own options. Report to the script
manpage or help string for more infos.

*The following common options are supported (MUST be used first):*

**-h | --help**
:    show this information message 

**-v | --verbose**
:    increase script verbosity 

**-q | --quiet**
:    decrease script verbosity, nothing will be written unless errors 

**-f | --force**
:    force some commands to not prompt confirmation 

**-i | --interactive**
:    ask for confirmation before any action 

**-x | --debug**
:    see commands to run but not run them actually 

**-V | --version**
:    see the script version when available

**-d | --working-dir** =path
:    redefine the working directory (default is `pwd` - `PATH` must exist)

**-l | --log** =filename
:    define the log filename to use (default is `bashlib.log`)

**--libvers**
:    see the library version 

**--libhelp**
:    see the library manpage

**--libdoc**
:    see the library documentation (use option `-v` to increase output)

You can group short options like `-xc`, set an option argument like `-d(=)value` or
`--long=value` and use `--` to explicitly specify the end of the script options.

## ENVIRONMENT

The following environment variables are available:

COLOR_LIGHT COLOR_DARK COLOR_INFO COLOR_NOTICE COLOR_WARNING COLOR_ERROR COLOR_COMMENT
:    a set of predefined colors

VERBOSE QUIET DEBUG INTERACTIVE FORCED
:    the library flags, activated by script common options (see previous section)

USEROS
:    the current user operating system

SYNOPSIS DESCRIPTION OPTIONS FILES ENVIRONMENT BUGS AUTHOR SEE_ALSO
:    these are used to build man-pages and usage infors ; they may be defined for each script

## EXIT STATUS

The library defines and uses some specific error status:

E_ERROR=**90**
:   classic error

E_OPTS=**81**
:   script options error

E_CMD=**82**
:   missing command error

E_PATH=**83**
:   path not found error

## FILES

**bash-library.sh**
:    the standalone library source file 

**bashlib.log**
:    the default library log file

## LICENSE

The library is licensed under GPL-3.0 - Copyleft (c) Les Ateliers Pierrot
<http://www.ateliers-pierrot.fr/> - Some rights reserved. For documentation,
sources & updates, see <http://github.com/atelierspierrot/bash-library>. 
To read GPL-3.0 license conditions, see <http://www.gnu.org/licenses/gpl-3.0.html>.

## BUGS

To transmit bugs, see <http://github.com/atelierspierrot/bash-library/issues>.

## AUTHOR

**Les Ateliers Pierrot** <http://www.ateliers-pierrot.fr/>.

## SEE ALSO

bash(1), sed(1), grep(1), printf(1), echo(1), tput(1), uname(1), getopts(1)

