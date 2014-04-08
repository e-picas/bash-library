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

    php vendor/atelierspierrot/markdown-extended/bin/markdown-extended -f man -o src/piwi-bash-library.man MANPAGE.md
    man src/piwi-bash-library.man

To generate the documentation to `DOCUMENTATION.md`:

    src/piwi-bash-library.sh -v mddocumentation > DOCUMENTATION.md

## TODO

-   arrange the "interface" according to new work on the dev-tools

## BUGS

-   managing SCRIPT_ARGS when no option
-   "strip_colors" method ?
