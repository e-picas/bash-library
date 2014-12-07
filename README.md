Piwi-Bash-Library
=================

An open source day-to-day bash library.


Installation
------------

Installing the *Piwi Bash Library* is as simple as making a copy of two files in your target
directory: the **library source itself** and **its Unix manual page**.

You can install the package in many ways explained in the [Global documentation](http://github.com/piwi/bash-library/wiki) ;
the best practice is to use **the internal interface** as it presents facilities to update the library.

    wget --no-check-certificate https://github.com/piwi/bash-library/archive/master.tar.gz
    tar -xvf master.tar.gz
    ./piwi-bash-library-master/src/piwi-bash-library.sh help

To read the library's manpage, run:

    man ./piwi-bash-library-master/piwi-bash-library.man

Usage
-----

To use the library in a bash script, just `source` it at the top of your code or before any
call of its methods or variables:

    #!/bin/bash
    source path/to/piwi-bash-library.sh
    ...

The full documentation of the library is available online at <http://github.com/piwi/bash-library/wiki>.


Demonstrations
--------------

A set of test and demonstration files is included in the `demo/` directory of the package.
These files are not required for a normal usage of the library.

To run one of these tests, just run, depending on your system:

    cd path/to/downloaded/package/piwi-bash-library
    ./demo/file-test.sh
    # OR
    sh demo/file-test.sh
    # OR
    bash demo/file-test.sh

You can use the `-h` option to get help or info:

    ./demo/file-test.sh -h


Author & License
----------------

The "Piwi Bash library" is open source, licensed under the
[GNU GPL v.3 license](http://www.gnu.org/licenses/gpl-3.0.html).

    Piwi Bash Library - An open source day-to-day bash library
    Copyright (C) 2013-2014, Pierre Cassat & contributors
    <http://e-piwi.fr/> - Some rights reserved.

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

    For documentation, sources & updates, see <http://github.com/piwi/bash-library>.
    To read GPL-3.0 license conditions, see <http://www.gnu.org/licenses/gpl-3.0.html>.
