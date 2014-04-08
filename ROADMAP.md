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

-   the output of 'version' may follow GNU specs: => OK

		GNU hello 2.3
		Copyright (C) 2007 Free Software Foundation, Inc.
		License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
		This is free software: you are free to change and redistribute it. There is NO WARRANTY, to the extent permitted by law.

-   arrange the "interface" according to new work on the dev-tools

sample output of 'man' error:

    ¬$ man src/piwi-bash-library.man -x
    man, version 1.6c

    usage: man [-adfhktwW] [section] [-M path] [-P pager] [-S list]
        [-m system] [-p string] name ...

      a : find all matching entries
      c : do not use cat file
      d : print gobs of debugging information
      D : as for -d, but also display the pages
      f : same as whatis(1)
      h : print this help message
      k : same as apropos(1)
      K : search for a string in all pages
      t : use troff to format pages for printing
      w : print location of man page(s) that would be displayed
          (if no name given: print directories that would be searched)
      W : as for -w, but display filenames only

      C file   : use `file' as configuration file
      M path   : set search path for manual pages to `path'
      P pager  : use program `pager' to display pages
      S list   : colon separated section list
      m system : search for alternate system's man pages
      p string : string tells which preprocessors to run
                   e - [n]eqn(1)   p - pic(1)    t - tbl(1)
                   g - grap(1)     r - refer(1)  v - vgrind(1)


## BUGS

-   managing SCRIPT_ARGS when no option
-   "strip_colors" method ?
