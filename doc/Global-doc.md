Global documentation - Piwi-Bash-Library
========================================

The library defines a set of methods and variables. Some specific features are described
in a specific documentation file in this directory, and the default usage is described here.
Some test scripts (not required to use the library) are defined in the `bin/` directory.

For a full example, run the `bin/test.sh` script.


## Methods & Variables

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


--------------

Documentation page for the [Piwi Bash Library](http://github.com/atelierspierrot/piwi-bash-library).

**(c) 2013-2014 [Les Ateliers Pierrot](http://www.ateliers-pierrot.fr/)** - Paris, France - Some rights reserved.

This documentation is licensed under the [Creative Commons - Attribution - Share Alike - Unported - version 3.0](http://creativecommons.org/licenses/by-sa/3.0/) license.
