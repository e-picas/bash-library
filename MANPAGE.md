Man:        piwi-bash-library.sh Manual
Name:       Piwi Bash Library
Author:     Les Ateliers Pierrot
Date: 2013-11-03
Version: 1.0.0


## NAME

piwi-bash-library - An open source bash library

## SYNOPSIS

**piwi-bash-library-script [common options] [script options [=value]] [arguments] --**

**piwi-bash-library-script**  [**-h**|**-V**]  [**-x**|**-v**|**-i**|**-q**|**-f**]
    [**--help**|**--usage**|**--man**]
    [**-d** *path*]  [**-l** *filename*]
    [**--force**|**--help**|**--interactive**|**--quiet**|**--verbose**|**--debug**|**--dry-run**]
    [**--version**|**--libversion**]
    [**--logfile** *=filename*] [**working-dir** *=path*]
        [script options ...]  (--)  [arguments ...]

## DESCRIPTION

**Bash**, the "*Bourne-Again-SHell*", is a *Unix shell* written for the GNU Project as a
free software replacement for the original Bourne shell (sh). The present library is a tool
for Bash scripts facilities. To use the library, just include its source file using:
`source path/to/piwi-bash-library.sh` and call its methods.

The library is NOT a script doing some work itself except dealing with a copy of the library
; it is just a library. This manual explains the library itself, its options and
usage methods but you MAY keep in mind that the final manual page to read is the one of
the real script you will call, using the tools of the library to build its own work. See the
"Interface" section of this manual for informations about the library interface (when calling
it directly).

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
-   use a set of **common options** (described in next "Options" section) to let the user interact
    with the script, such as increase or decrease verbosity, make a dry run, ask to force 
    commands or to always prompt for confirmation

For the library source code and messages outputs, we mostly try to follow the
[GNU coding standards](http://www.gnu.org/prep/standards/standards.html) to keep user in
a known environment ...

## INTERFACE

When calling the library script itself from command line, a user interface is available to
deal (install/update/uninstall) with a copy of the library locally or globally in your 
system. To start with this interface, you can run:

    path/to/piwi-bash-library.sh (--less) help

A basic synopsis of the interface is:

    path/to/piwi-bash-library.sh -[common options] --target=path --preset=default action-name

See the "Options" section below for specific options usage.

### The following actions are available

**help** and **usage**
:   get an 'help' and 'usage' information about the interface itself

**install**
:   install a copy of the library locally or in your system

**version**
:   get the version informations about an installed copy ; use option `quiet` to get only
the version number

**check**
:   check if an installed copy is up-to-date

**update**
:   update an installed copy with newer version if so ; this will update the MINOR version

**uninstall**
:   uninstall a copy from a system path

**selfupdate**, **self-update**
:   update the current library script (called script `$0`) with newer version if so

**selfvers**, **self-version**
:   get the current library script version informations (called script `$0`) ; use option
`quiet` to get only the version number

**doc**, **documentation**
:   see the library documentation ; use option `verbose` to increase verbosity ; you can
add an `md` prefix to get the documentation in Markdown format ('mddoc' or 'mddocumentation')

## OPTIONS

Each script depending on the library may define its own options. Report to the script
manpage or help string for more infos.

*The following common options are supported (MAY be used first):*

**-h**, **--help**
:    show an information message 

**-v**, **--verbose**
:    increase script verbosity ; this will define the environment variables `VERBOSE` on `true`
and `QUIET` on `false`

**-q**, **--quiet**
:    decrease script verbosity, nothing will be written unless errors ; this will define
the environment variables `VERBOSE` and `INTERACTIVE` on `false` and `QUIET` on `true`

**-f**, **--force**
:    force some commands to not prompt confirmation ; this will define the environment
variable `FORCED` on `true`

**-i**, **--interactive**
:    ask for confirmation before any action ; this will define the environment variable
`INTERACTIVE` on `true` and `QUIET` on `false`

**-x**, **--debug**
:    enable debug mode ; this will define the environment variable `DEBUG` on `true`

**-V**, **--vers**, **--version**
:    see the script version when available ; use option `quiet` to only have the version number

**-d**, **--working-dir** =path
:    redefine the working directory (default is `pwd` - `path` must exist) ; this will update
the environment variable `WORKINGDIR`

**-l**, **--log** =filename
:    define the log filename to use (default is `pwibashlib.log`) ; this will update
the environment variable `LOGFILE`

**--usage**
:    show a quick usage information

**--man**
:    try to open a manpage for current script if available, or show the help string otherwise

**--dry-run**
:    see commands to run but not run them actually ; this will define the environment variable
`DRYRUN` on `true`

**--libvers**, **--libversion**
:    see the library version ; use option `quiet` to only have the version number

You can group short options like `-xc`, set an option argument like `-d(=)value` or
`--long=value` and use `--` to explicitly specify the end of the script options.

In some cases, you can use an automatic long option named as a program like `--less` for the
"less" program. If this program is installed in the system, it will be used for certain
option rendering. For instance, a long "help" output can be loaded via `less` running:

    piwi-bash-library-script -h --less

### Specific options of the library's interface

Calling the library script itself to use its interface, you can use the following options:

**-t**, **--target** =path
:    define the target directory of a copy installation ; if it does not exist, `path` will
be created ; it defaults to current path (`pwd`)

**-p**, **--preset** =type
:    define the preset type to use for an installation ; can be "**default**" (default value),
"**user**", "**dev**" or "**full**" ; the value of this option will be used to define the
files to install ; see the "Files" section below for more informations

**-b**, **--branch** =name
:    define the GIT branch to use from the remote repository ; the branch MUST exist in the
repository ; it defaults to "master"


## ENVIRONMENT

The following environment variables are available:

COLOR_LIGHT COLOR_DARK COLOR_INFO COLOR_NOTICE COLOR_WARNING COLOR_ERROR COLOR_COMMENT
:    a set of predefined colors

VERBOSE QUIET DEBUG INTERACTIVE FORCED
:    the library flags, activated by script common options (see previous section)

USEROS
:    the current user operating system

NAME VERSION DATE PRESENTATION LICENSE HOMEPAGE
:   these are used to build the help information of the scripts ; they may be defined for each script

SYNOPSIS DESCRIPTION OPTIONS EXAMPLES EXIT_STATUS FILES ENVIRONMENT COPYRIGHT BUGS AUTHOR SEE_ALSO
:    these are used to build man-pages and help informations ; they may be defined for each script

NAME VERSION DATE PRESENTATION COPYRIGHT_TYPE LICENSE_TYPE SOURCES_TYPE ADDITIONAL_INFO
:   these are used to build the version string of the scripts ; they may be defined for each script

SCRIPT_OPTS SCRIPT_ARGS SCRIPT_PROGRAMS OPTIONS_ALLOWED LONG_OPTIONS_ALLOWED ARGIND ARGUMENT
:   these are used for options and arguments ; see the documentation for more informations

LOREMIPSUM LOREMIPSUM_SHORT LOREMIPSUM_MULTILINE
:   these are defined for tests with sample strings


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

**piwi-bash-library.sh** | **piwi-bash-library**
:    the standalone library source file 

**piwi-bash-library.man**
:    the manpage of the library, installed in section 3 of system manpages for global installation

**piwi-bash-library-README.md** (optional)
:    the standard README file of the version installed (Markdown syntax) ; it is installed
by the interface using the "user" or "full" presets

**piwi-bash-library-DOC.md** (optional)
:    the development documentation file of the version installed (Markdown syntax) ; it
is installed by the interface using the "dev" or "full" presets

## LICENSE

The library is licensed under GPL-3.0 - Copyleft (c) Les Ateliers Pierrot
Copyright (C) 2013-2014 "Les Ateliers Pierrot"

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program. If not, see <http://www.gnu.org/licenses/>.

<http://www.ateliers-pierrot.fr/> - Some rights reserved. For documentation,
sources & updates, see <http://github.com/atelierspierrot/piwi-bash-library>. 
To read GPL-3.0 license conditions, see <http://www.gnu.org/licenses/gpl-3.0.html>.

This is free software: you are free to change and redistribute it ; there is NO WARRANTY,
to the extent permitted by law.
	
## BUGS

To transmit bugs, see <http://github.com/atelierspierrot/piwi-bash-library/issues>.

## AUTHOR

**Piwi** <piero.wbmstr@gmail.com> for Les Ateliers Pierrot <http://www.ateliers-pierrot.fr/>.

## SEE ALSO

bash(1), sed(1), grep(1), printf(1), echo(1), tput(1), uname(1), getopts(1)

