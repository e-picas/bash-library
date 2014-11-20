Piwi-Bash-Library
=================

An open source day-to-day bash library.


## What is this ?

### What is *bash* ?

**Bash**, the "Bourne-Again-SHell", is the default language for command line and scripts
for UNIX systems. Bash is a Unix shell written for the GNU Project as a free software
replacement for the original "Bourne" shell `sh`.

### What is *piwi bash library* ?

It is a library of variables, constants and methods to use in bash scripts. It defines a
large set of commonly used methods to facilitate bash scripts writing, such as an handler
for errors, the construction of an output with text and color effects, some facilities 
to work with booleans, strings, arrays etc. It also offers a standardization for scripts
arguments and help and usage strings. 


## How does it work ?

### Installation

Installing the *Piwi Bash Library* is as simple as making a copy of two files in your target
directory: the **library source itself** and **its Unix's manual page**.

You can install the package in many ways explained in the [Global documentation](doc/Global-doc.md) ;
the best practice is to use **the internal interface** as it presents facilities to update the library.

    ~$ wget --no-check-certificate https://github.com/atelierspierrot/piwi-bash-library/archive/master.tar.gz
    ~$ tar -xvf master.tar.gz
    ~$ ./piwi-bash-library-master/src/piwi-bash-library.sh help

### Usage

To use the library in a bash script, just `source` it at the top of your code or before any
call of its methods or variables:

    #!/bin/bash
    source path/to/piwi-bash-library.sh
    ...

### Developer documentation

Documentation files are included in the [`doc/` directory](doc) of the package.

A quick overview of the whole library methods or variables can be written on screen running
(the `-v` option renders a complete doc with comments for each method):

    ~$ ./path/to/piwi-bash-library.sh (-v) documentation

### Demonstration files

A set of test and demonstration files is included in the `demo/` directory of the package.
These files are not required for a normal usage of the library.

To run one of these tests, just run, depending on your system:

    ~$ cd path/to/downloaded/package/piwi-bash-library
    ~$ ./demo/file-test.sh
    OR
    ~$ sh demo/file-test.sh
    OR
    ~$ bash demo/file-test.sh

You can use the `-h` option to get help or info:

    ~$ ./demo/file-test.sh -h


## Author & License

The "Piwi Bash library" is open source, licensed under the
[GNU GPL v.3 license](http://www.gnu.org/licenses/gpl-3.0.html).

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
