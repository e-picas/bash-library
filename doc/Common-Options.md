Common options - Piwi-Bash-Library
==================================

The library handles, if you say so, a set of commonly used arguments that enables/disables
a set of flags or actions commonly used. See the [Scripts Usage](Scripts-Usage.md) document
for a coding usage review.

For a full example with custom options, see the `demo/getopts-test.sh` script.


## Verbosity, Interactivity, Forcing & Debug

A set of common script options is defined by the library to allow you to let user
enabled some environment constants or not at each script usage.

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
See the [Global documentation](Global-doc.md) to learn more. Keep in mind that **there
is no automation of these flags effects, you have to us the internal methods to make
them work**.

### Common behavior

Verbosity, interactivity, forcing and debug are some common bash script options any user may
already know ... We tried to keep these classic options in the library to let user evolve in
a known environment.

In the library, these features are handled using simple boolean variables that are all `false`
by default and can be turned on `true` by a script option (or manually in your script).

The environment variables used by the library are:

    VERBOSE QUIET DEBUG FORCED INTERACTIVE

To enable one of these constants by default in your script, just redefine it after the
library inclusion. For example:

    #!/bin/bash
    source path/to/piwi-bash-library.sh
    VERBOSE=true

### Verbosity

The verbosity is managed through the `VERBOSE` constant flag that can be enabled using
options `-v` or `--verbose`.

To write a string if this mode is enabled, you may use method `verbose_echo` (or its 
shortcut alias `verecho`):

    echo 'this will be seen whatever happens ...'
    verbose_echo 'this will only be seen if the VERBOSE mode is enabled'

Verbosity is automatically disabled in `QUIET` mode ([see below](#quiet)).

### Interactivity

The interactivity is managed through the `INTERACTIVE` constant flag that can be turned
ON with options `-i` or `--interactive`.

To write a command using the interactive feature, you may use method `interactive_exec`:

    cd my/path
    interactive_exec "rm -f a-file.txt"

When interactivity is enabled, user will be questionned about the command to run and this
command will only be executed if he answered `yes` to this question (note that the default
user response is `yes` to keep a normal script usage). If the user respond `n` or `no`, the
execution will not be done.

Interactivity is automatically disabled in `QUIET` mode ([see below](#quiet)).

### Quiet

The quiet mode is handled by variable `QUIET` and can be turned ON with options `-q` or
`--quiet`. When it is enabled, it automatically turns OFF the **verbosity** and **interactivity**.
A good practice is to write only errors in this mode.

### Forcing

The `force` feature is managed through the `FORCED` constant flag that can be turned ON with
options `-f` or `--force`. No method is defined to use it but you can simply test it's value
writing:

    if $FORCED; then ...; else ...; fi

### Debugging

The debug mode is handled by variable `DEBUG` and can be turned ON with options `-x` or
`--debug`.

This mode allows you to show the commands that should be executed but not actually execute
them. To do so, you must use method `debug_exec`:

    debug_exec "rm my-file.txt"
    // will remove the file in not-debug mode
    // will output in debug mode:
    debug >> rm my-file.txt



## Man-page & infos for each script

**-h** | **--help**
:   get a help string about current script ;

**--usage**
:   get a usage string about current script ;

**--man**
:   will try to open a man page of the current script if it exists, or show the usage string
    about current script if not ;

**-V** | **--version**
:   get the script version if available ; you can use the `quiet` option to only have
	the version number ; by default, this will write the version number, the last commit hash
	and the last commit date ;

See the specific [Man-pages](Man-pages.md) and [Versioning & Licensing](Versioning-Licensing.md) documentation for more infos.


## Other useful options

**-l** | **--log**
:   set a log filename to replace default

**-d** | **--working-dir**
:   set the working directory path which will replace current working directory


--------------

Documentation page for the [Piwi Bash Library](http://github.com/atelierspierrot/piwi-bash-library).

**(c) 2013-2014 [Les Ateliers Pierrot](http://www.ateliers-pierrot.fr/)** - Paris, France - Some rights reserved.

This documentation is licensed under the [Creative Commons - Attribution - Share Alike - Unported - version 3.0](http://creativecommons.org/licenses/by-sa/3.0/) license.
