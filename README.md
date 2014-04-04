Piwi-Bash-Library
=================

An open source day-to-day bash library.


## What is *bash* ?

**Bash**, the "Bourne-Again-SHell", is the default language for command line and scripts
for UNIX systems. Bash is a Unix shell written for the GNU Project as a free software
replacement for the original Bourne shell (sh).

## What is *piwi bash library* ?

It is a library of variables, constants and methods to use in bash scripts. It defines a
large set of commonly used methods to facilitate bash scripts writing, such as an handler
for errors, the construction of an output with text and color effects, some facilities 
to work with booleans, strings, arrays etc. It also offers a standardization for scripts
arguments and help and usage strings. 

## Usage of the library

### Installation

Installing the *Piwi Bash Library* means to make a copy of two files in your target directory:
the **library source itself** and **its Unix's manual page**.

You can install the package in many ways explained below ; the best practice is to use **the
internal interface** as it presents facilities to update the library.

#### Classic installation

Once you have downloaded or cloned the package sources, just copy the `src/piwi-bash-library.sh`
file to your project directory and begin to use it ... We recommend to also copy the library's
manpage `src/piwi-bash-library.man` in the same directory.

For a global usage on your machine, you can copy the library in your `bin/` directory.

As for any script file, it must have execution rights for all users.

A direct and complete installation, including downloading sources, could be:

    ~$ wget --no-check-certificate https://github.com/atelierspierrot/piwi-bash-library/archive/master.tar.gz
    ~$ tar -xvf master.tar.gz
    ~$ cp piwi-bash-library-master/src/piwi-bash-library.* path/to/your/project/bin/
    ~$ chmod a+x path/to/your/project/bin/piwi-bash-library.sh
    ~$ man path/to/your/project/bin/piwi-bash-library.man

#### Composer install

If you are a [Composer](http://getcomposer.org/) user, you can add to your package requirements:

    "atelierspierrot/piwi-bash-library": "1.*"

The library will automatically be added in your package's `bin` directory.

#### Internal interface

The library embeds an internal interface to manage (instal/update/uninstall) the library
itself locally or globally. To use it, run:

    ~$ path/to/piwi-bash-library.sh help

It is sometimes useful to include the library file to your project and manage it manually
under version control. The interface will handle the installation and update of the library
files for you.

A direct and complete installation, including downloading sources, could be:

    ~$ wget --no-check-certificate https://github.com/atelierspierrot/piwi-bash-library/archive/master.tar.gz
    ~$ tar -xvf master.tar.gz
    ~$ ./piwi-bash-library-master/src/piwi-bash-library.sh install


### Usage

To use the library in a bash script, just `source` it at the top of your code or before any
call of its methods or variables:

    #!/bin/bash
    source path/to/piwi-bash-library.sh

For a complete loading writing an error if the library is not found (if it is a requirement), use the following:

    LIBFILE="path/to/piwi-bash-library.sh"
    if [ -f "$LIBFILE" ]; then source "$LIBFILE"; else
        PADDER=$(printf '%0.1s' "#"{1..1000})
        printf "\n### %*.*s\n    %s\n    %s\n%*.*s\n\n" 0 $(($(tput cols)-4)) "ERROR! $PADDER" \
            "Unable to find required library file '$LIBFILE'!" \
            "Sent in '$0' line '${LINENO}' by '`whoami`' - pwd is '`pwd`'" \
            0 $(tput cols) "$PADDER";
        exit 1
    fi

This way, if the library was not found, your script will end with an error and write:

    ### ERROR! ###########################################################
        Unable to find required library file 'path/to/piwi-bash-library.sh'!
        Sent in 'current-file.sh' line '0' by 'username' - pwd is '...'
    ######################################################################

### Developer documentation

Documentation files are included in the [`doc/` directory](doc) of the package.

A quick overview of the whole library methods or variables can be written on screen running
(the `-v` option renders a complete doc with comments for each method):

    ~$ ./path/to/piwi-bash-library.sh (-v) documentation


### Demonstration files

A set of test and demonstration files is included in the `bin/` directory of the package.
These files are not required for a normal usage of the library.

To run one of these tests, just run, depending on your system:

    ~$ cd path/to/downloaded/package/piwi-bash-library
    ~$ ./bin/file-test.sh
    OR
    ~$ sh bin/file-test.sh
    OR
    ~$ bash bin/file-test.sh

You can use the `-h` option to get help or info:

    ~$ ./bin/file-test.sh -h


## Author & License

    Piwi Bash Library - An open source day-to-day bash library
	Copyright (C) 2013-2014 Les Ateliers Pierrot
	<http://www.ateliers-pierrot.fr/> - Some rights reserved.
	Created & maintained by Pierre Cassat & contributors

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

	For documentation, sources & updates, see <http://github.com/atelierspierrot/piwi-bash-library>. 
	To read GPL-3.0 license conditions, see <http://www.gnu.org/licenses/gpl-3.0.html>.
