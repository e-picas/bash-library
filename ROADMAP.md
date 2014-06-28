ROADMAP - Piwi-Bash-Library
===========================

This document explains how to use the package during development and the things to do ...


## Help guides

-   [Bash Reference Manual](http://www.gnu.org/software/bash/manual/bashref.html)
-   [Bash Guide for Beginners](http://www.tldp.org/LDP/Bash-Beginners-Guide/html/Bash-Beginners-Guide.html),
    by **Machtelt Garrels**.
-   [Advanced Bash-Scripting Guide](http://www.tldp.org/LDP/abs/html/abs-guide.html),
    by **Mendel Cooper**.


## Dev procedures

To install/update dependencies:

    php composer.phar install
    php composer.phar update

To generate the manpage from `MANPAGE.md`:

    chmod a+x vendor/piwi/markdown-extended/bin/markdown-extended
    php vendor/piwi/markdown-extended/bin/markdown-extended -f man -o src/piwi-bash-library.man MANPAGE.md
    man src/piwi-bash-library.man

To generate the documentation to `DOCUMENTATION.md`:

    src/piwi-bash-library.sh -v mddocumentation > DOCUMENTATION.md


## TODO

-   arrange the "interface" according to new work on the dev-tools
-   write a Tutorial
-   add a new 'taillog' action
-   add a '--plain' option for a script-usable output rendering (lists of options for instance)

-   move the "bin/" to "demo/" (which is more what they are)

-   new feature: execute a list of commands (from an array) with the possibility to split
    them one by one and choose which part to execute or not (in the base of the `iexec` method)
    inspired by the GIT stuff


## BUGS

-   managing SCRIPT_ARGS when no option
-   "strip_colors" method on MacOSX ?
