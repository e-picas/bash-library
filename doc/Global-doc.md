Global documentation - Piwi-Bash-Library
========================================

The library defines a set of methods and variables. Some specific features are described
in a specific documentation file in this directory, and the default usage is described here.
Some test scripts (not required to use the library) are defined in the `bin/` directory.

For a full example, run the `bin/test.sh` script.


## Usage of the library

To use the library in a bash script, just `source` it at the top of your code or before any
call of its methods or variables:

    #!/bin/bash
    source path/to/piwi-bash-library.sh

For a complete loading writing an error if the library is not found (if it is a requirement), use the following:

    LIBFILE="path/to/piwi-bash-library.sh"
    if [ -f "${LIBFILE}" ]; then source "${LIBFILE}"; else
        PADDER=$(printf '%0.1s' "#"{1..1000})
        printf "\n### %*.*s\n    %s\n    %s\n%*.*s\n\n" 0 $(($(tput cols)-4)) "ERROR! ${PADDER}" \
            "Unable to find required library file '${LIBFILE}'!" \
            "Sent in '$0' line '${LINENO}' by '`whoami`' - pwd is '`pwd`'" \
            0 $(tput cols) "${PADDER}";
        exit 1
    fi

This way, if the library was not found, your script will end with an error and write:

    ### ERROR! ###########################################################
        Unable to find required library file 'path/to/piwi-bash-library.sh'!
        Sent in 'current-file.sh' line '0' by 'username' - pwd is '...'
    ######################################################################

For more informations about library's usage in your scripts, please see the following
documentations:

-	[Scripts Usage](Scripts-Usage.md) explains how to use the [Common options](Common-Options.md)
	handled by the library ; the "common options" are defined according to the best practices
	and usages in *NIX commands
-	[Help & Manpages](Help-Manpages.md) will show you how to create information strings and 
	manuals for your scripts ; a special [Versioning & Licensing](Versioning-Licensing.md) documentation
	explains the usage of "in-script"'s variables to correctly name and versioned your scripts
-	[Colorized Contents](Colorized-Contents.md) explains how the library handles the construction of
	colorized and styled terminal output
-	[Scripts Install](Scripts-Install.md) describes the library's installation wizard you can use for
	your scripts
-	finally, the [Development](Development.md) explains the rules to follow to write well-coded and
	well-documentated scripts


## Internal Methods & Variables

A full list of the current library methods and defined variables can be constructed
parsing the library file itself using common option `documentation` action of the 
library's interface (when you call it directly). The result is a long output
presenting each variable/method with a description and, if neede, its signature.

The documentation output follows some simple rules:

-	any line begining with `@ TEXT` is a variable defined in the library ;
	you can use it with `${TEXT}` or, in certain cases, redefine it 
-	any line constructed like `string ( ... )` is a method ; you can call
	it with `result=$(string ...)` where the dots may be replaced by the
	method arguments if needed ; as for any other language, a signature like
	`path = $0` means that a `path` argument can be passed calling the method
	and defaults to `$0` otherwise
-	any line constructed like `/ string ( ... )` describes an alias
-	some tags are defined to describe a specific feature:
	-	the `@return` mark describes the return type of the method (type or status)
	-	the `@param` mark describes a method's parameter
	-	the `@error` mark describes the condition of a thrown error


## Script Methods & Variables

When using the library, you can overwrite any method by defining it again after having
sourced the library. This way, your implementation will be used by bash.

You can do so for variables, as long as they are not "read-only" (please refer to the
library's documentation).


--------------

Documentation page for the [Piwi Bash Library](http://github.com/atelierspierrot/piwi-bash-library).

**(c) 2013-2014 [Les Ateliers Pierrot](http://www.ateliers-pierrot.fr/)** - Paris, France - Some rights reserved.

This documentation is licensed under the [Creative Commons - Attribution - Share Alike - Unported - version 3.0](http://creativecommons.org/licenses/by-sa/3.0/) license.
