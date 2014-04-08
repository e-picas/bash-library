Versioning & Licensing - Piwi-Bash-Library
==========================================

This document describes the best practice to build version numbers (for package releases)
and license informations.


## Naming & Versioning

First of all, a good practice is to **name** your scripts. Giving it a name which describes
its feature is the first step to a good and useful work (!).

The library uses the `NAME` constant in many methods which identifies the script (this is
the case of the `help`, `version` and `usage` methods). 

### Specifications

The construction of version numbers MUST follow the [Semantic Versioning](http://semver.org/)
rules to be compliant with standards.

Give your scripts a version number is, of course, not an obligation. But it can be very
useful to identify evolutions and compare an actual version to yours. The library itself
uses a version number constructed following the Semantice versioning: `X.Y.Z` where `X`
is the major version reference, `Y` is a minor version number and `Z` the last bugfix version.

Once it has been published, a release MUST NOT (never !!) change its version number.

### Usage of versioning with the library

The library uses the following constants to get name and version number of a script (here with
the default values of the library):

	NAME     ="PiwiBashLibrary"
	VERSION  ="1.0.0"


## Licensing

The library is licensed under the [General Public License version 3.0](http://www.gnu.org/licenses/gpl-3.0.html).
This means that any script using it MUST be licensed under a [compatible license](http://www.gnu.org/licenses/quick-guide-gplv3.html).

### Informing about your license

The library uses the following constants to build the `--version` option output (here
with their default values in the library):

    LICENSE            ="GPL-3.0"
    LICENSE_URL        ="http://www.gnu.org/licenses/gpl-3.0.html"
    COPYRIGHT_TYPE     ="Copyright (c) 2013-2014 Les Ateliers Pierrot <http://www.ateliers-pierrot.fr/>"
    LICENSE_TYPE       ="License ${LIB_LICENSE}: <${LIB_LICENSE_URL}>"
    SOURCES_TYPE       ="Sources & updates: <${LIB_HOME}>"
    ADDITIONAL_INFO    ="This is free software: you are free to change and redistribute it ; there is NO WARRANTY, to the extent permitted by law.";

To test the final rendering, you can run:

	./path/to/library.sh version


--------------

Documentation page for the [Piwi Bash Library](http://github.com/atelierspierrot/piwi-bash-library).

**(c) 2013-2014 [Les Ateliers Pierrot](http://www.ateliers-pierrot.fr/)** - Paris, France - Some rights reserved.

This documentation is licensed under the [Creative Commons - Attribution - Share Alike - Unported - version 3.0](http://creativecommons.org/licenses/by-sa/3.0/) license.
