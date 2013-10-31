ROADMAP - Piwi-Bash-Library
===========================

This document explains how to use the package during development and the things to do ...


## Dev procedures

To install/update dependencies:

    php composer.phar install
    php composer.phar update

To generate the manpage from `MANPAGE.md`:

    php vendor/atelierspierrot/markdown-extended/bin/markdown-extended -f man -o src/piwi-bash-library.man MANPAGE.md
    man src/piwi-bash-library.man

To generate the documentation to `DOCUMENTATION.md`:


## TODO

-   skip the 'libhelp' option (which have no real meaning) to prefer the manpage => OK
-   the output of 'version' may follow GNU specs: => OK

    GNU hello 2.3
    Copyright (C) 2007 Free Software Foundation, Inc.
    License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
    This is free software: you are free to change and redistribute it.
    There is NO WARRANTY, to the extent permitted by law.

-   skip the 'libdoc' option ; it just can be invoked by calling the lib itself => OK

-   arrange the "interface" according to new work on the dev-tools
-   format of the error and log infos (according to GNU)


## BUGS

-   incrementation of ARGIND
-   managing SCRIPT_ARGS when no option
