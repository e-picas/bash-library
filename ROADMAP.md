ROADMAP - Piwi-Bash-Library
===========================

This document explains how to use the package during development and the things to do ...


## Help guides

-   [Bash Reference Manual](http://www.gnu.org/software/bash/manual/bashref.html)
-   [Bash Guide for Beginners](http://www.tldp.org/LDP/Bash-Beginners-Guide/html/Bash-Beginners-Guide.html),
    by **Machtelt Garrels**.
-   [Advanced Bash-Scripting Guide](http://www.tldp.org/LDP/abs/html/abs-guide.html),
    by **Mendel Cooper**.
-   Usage of bash test-suite: <https://github.com/sstephenson/bats>, by **Sam Stephenson**.


## Dev procedures

To install/update dependencies:

    git submodules init
    git submodule update

To run the test suite:

    ./build/run-tests.sh [test-filename]

To generate the manpage from `MANPAGE.md`:

    chmod a+x modules/markdown-extended/bin/markdown-extended
    php modules/markdown-extended/bin/markdown-extended -f man -o src/piwi-bash-library.man MANPAGE.md
    man src/piwi-bash-library.man

To generate the documentation to `DOCUMENTATION.md`:

    src/piwi-bash-library.sh -v mddocumentation > DOCUMENTATION.md


## TODO

-   arrange the "interface" according to new work on the dev-tools
-   write a Tutorial
-   add a new 'taillog' action
-   add a '--plain' option for a script-usable output rendering (lists of options for instance)

-   review all usage of synopsis and more largely user strings
-   review documentation strings and buildings
-   include the `binstaller` work for internal interface

-   new feature: execute a list of commands (from an array) with the possibility to split
    them one by one and choose which part to execute or not (in the base of the `iexec` method)
    inspired by the GIT stuff

-   the library on the "wip" branch should be with a version number "X.Y.(Z+1)-dev" and a LIB_VCSVERSION
    of "wip@last_commit_sha" (check with the 'dev-tools' that this can be handled by the 'version-tag' action)


## BUGS

-   managing SCRIPT_ARGS when no option
-   "strip_colors" method on MacOSX ?
