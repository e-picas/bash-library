Global documentation - Piwi-Bash-Library
========================================

The library defines a set of methods and constants. Some specific features are described
in a standalone documentation in this directory, and the default usage is described here.

For a full example, see the `bin/test.sh` script.


## Verbosity, Interactivity, Forcing & Debug

As described in the [Common options](Common-options.md) documentation, a set of common script
options is defined by the library to allow you to let user enabled some environment constants
or not at each script usage.

You can test any of the options used in the sections below on the `bin/test.sh` script.

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

To write a string if this mode is enabled, you may use method `verbose_echo`:

    echo 'this will be seen whatever happens ...'
    debug_echo 'this will only be seen if the VERBOSE mode is enabled'

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

## Quiet

The quiet mode is handled by variable `QUIET` and can be turned ON with options `-q` or
`--quiet`. When it is enabled, it automatically turns OFF the **verbosity** and **interactivity**.
A good practice is to write only errors in this mode.

## Forcing

The `force` feature is managed through the `FORCED` constant flag that can be turned ON with
options `-f` or `--force`. No method is defined to use it but you can simply test it's value
writing:

    if $FORCED; then ...; else ...; fi

## Debug

The debug mode is handled by variable `DEBUG` and can be turned ON with options `-x` or
`--debug`.

This mode allows you to show the commands that should be executed but not actually execute
them. To do so, you must use method `debug_exec`:

    debug_exec "rm my-file.txt"
    // will remove the file in not-debug mode
    // will output in debug mode:
    debug >> rm my-file.txt

## Methods

A full list of the current library methods can be constructed parsing the library file
itself using common option `--libdoc`.


--------------

Documentation page for the [Piwi Bash Library](http://github.com/atelierspierrot/piwi-bash-library).
