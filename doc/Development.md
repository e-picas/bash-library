Development - Piwi-Bash-Library
===============================

This document describes various rules to be followed by the library developers. If you made
a fork of the repository to modify a thing or add a feature, please read the rules below
and try to follow them as possible.


## Coding rules

### Methods

By convention, all methods names are written in **lower case**, with underscores to separate
words if necessary. When a method may construct a string, this string is `echo`es. All methods
must return an integer status; the classic method's return is `return 0`.

### Variables, Constants

All globals, variables or constants, are declared as:

    declare -(r)x(a) MYVAR=...

Constants may use option `-r`, "read-only", and arrays may be declared with option `-a`.

### Multi-line commands or strings

To avoid any error reading the file, any command or string that is written multi-lines may
escape each line by a trailing `\` and finish with a `;`.


## Comments for documentation

A documentation can be generated parsing the library script using method `libdoc` (called
by option `--libdoc`). By default, this documentation only contains sections titles and 
methods names but some more informations like arguments and comments can be shown in
*verbose* mode (with option `-v`).

As the automatic documentation is constructed parsing the library file content, this content
must follow some simple rules of construction:

-   each section of methods or variables has a title:

        #### TITLE #########################################

-   each method is preceded by a DocBlock:

        #### method_name ( argument1 , argument2=default )
        ##@param argument1: explanation about argument 1
        ## information about process ...
        method_name () {

-   when an important variable is defined, use the same DocBlock construction:

        #### MYVAR=...
        declare -rx MYVAR=...

### DocBlocks overview

. Sections titles are constructed like `#### TITLE (#+)`: four sharps followed by the title
itself surrounded by spaces then one or more sharps.

. A function or variable name's comment is constructed like `#### name ( arg1 , arg2=default )`:
four sharps followed by a space, the method name followed by a space, the list of possible
arguments with their default values if so, between brackets, separated by comas.

. Parameters, errors and return status can be specified using a tag like `##@param|return|error`
followed by your comment.

. Other information can be specified using a classic comment form: `## my info`.

. To write a comment that will not be shown in the documentation, use: `#! dev comment`.


--------------

Documentation page for the [Piwi Bash Library](http://github.com/atelierspierrot/piwi-bash-library).
