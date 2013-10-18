#!/bin/sh
#
# An example hook script called before version tag creation.
# This will receive three arguments:
# - $1: the project path to work on
# - $2: the tag name to create 
# - $3: the branch name 
#
# To enable this hook, define the `DEFAULT_VERSIONTAG_HOOK` configuration variable on
# this script.

PROJECT_PATH="$1"
TAG_NAME="$2"
BRANCH_NAME="$3"

_VERSION="${TAG_NAME/v/}"
_DATE=$(git log -1 --format="%ci" --date=short | cut -s -f 1 -d ' ')
_LIBFILE="src/bash-library.sh"

if [ -f "$_LIBFILE" ]; then
    sed -i '' -e "s| LIB_VERSION=\".*\"| LIB_VERSION=\"${_VERSION}\"|;s| LIB_DATE=\".*\"| LIB_DATE=\"${_DATE}\"|" "$_LIBFILE";
    git add "$_LIBFILE" && git commit -m "Automatic version number and date insertion in '$_LIBFILE'"
else
    verecho "!! > Library file '${_LIBFILE}' not found! (can't update version number and date)"
fi

# Endfile