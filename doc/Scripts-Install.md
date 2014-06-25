Scripts Installation - Piwi-Bash-Library
========================================

This document explains how the library can help your scripts to be installed, updated or
uninstalled in a system (globally or locally). This feature is an extension of the library
internal installer you can access calling its internal interface.


## Presentation

The idea here is to allow user to "install" a script in a particular place on his machine
and to update it when necessary. The library embeds a set of methods to automatize these 
actions.

For now, the library needs to work with a GIT hosted repository as it will make a clone in
its cache directory and install this clone version or use it to update an installed version.


## How does it work?

The library handles the following "actions" to manage a script installation:

-   `install`: make a first installation of a script
-   `check`: test if the version installed is up-to-date
-   `update`: update an installed version if needed
-   `uninstall`: remove an installed version

First of all, you need to define the following constants in your script:

    # script's GIT repository URL
    SCRIPT_REPOSITORY_URL="http://path/to/your/git/repo"
    # list of files to install
    SCRIPT_FILES=( my-script.sh my-script.man my-script.ini my-script-info.txt )
    # list of files considered as scripts (optional)
    SCRIPT_FILES_BIN=( my-script.sh )
    # list of files considered as manpages (optional)
    SCRIPT_FILES_MAN=( my-script.man )
    # list of files considered as configuration (optional)
    SCRIPT_FILES_CONF=( my-script.ini )

Then, the installation wizard will use the following constants during each installation
step:

    # directory to install the script
    LIBINST_TARGET=""
    # directory of the local clone
    LIBINST_CLONE=""
    # branch to install
    LIBINST_BRANCH='master'

### Install

The installation will happen by default in user's `$HOME/bin/` directory. You can specify 
another default target directory passing it as method's argument:

    script_install ( path = $HOME/bin/ )

### Check

The "check" action if just a test between an installed version and the last version available
in the same branch of distant repository. The method will echo the result of the test informing
user if its version is up-to-date or that a new version is available.

    script_check ( path = $HOME/bin/ )

### Update

The update is basically the same as an installation: the script is "re-installed" (replaced)
with last version available:

    script_update ( path = $HOME/bin/ )

### Uninstall

The uninstallation consists in removing all files created during installation:

    script_uninstall ( path = $HOME/bin/ )


## Going deeper in the library's stuff

The library will finally have to manage a set of GIT clones in its cache directory. It will
"clone" them when needed, "pull" the new commits on its working branch when required and
then use each clone as a referrer. Once the library will never delete an existing clone,
you can clear this "cache" by deleting the `$HOME/.piwi-bash-librart/cache/` directory
manually or using the `clean` action of the internal library's interface.

Any installation call is logged in the library's default logfile.


--------------

Documentation page for the [Piwi Bash Library](http://github.com/atelierspierrot/piwi-bash-library).

**(c) 2013-2014 [Les Ateliers Pierrot](http://www.ateliers-pierrot.fr/)** - Paris, France - Some rights reserved.

This documentation is licensed under the [Creative Commons - Attribution - Share Alike - Unported - version 3.0](http://creativecommons.org/licenses/by-sa/3.0/) license.
