#!/bin/bash

if [ "$(pwd)/build" == "$(dirname "$(realpath ${BASH_SOURCE[0]})")" ]
then
    source "$(dirname $0)/_settings.sh";
else
    echo "!! you must run shell builders from package's root directory !!"
    exit 1
fi

source "$LIB_FILE"
ACTUAL_VERSION="$("$LIB_FILE" -Vq)"
GIT_VERSION="$(git_get_version)"

echo "current version is: ${ACTUAL_VERSION} (${GIT_VERSION})"

if [ "$#" -eq 0 ]; then
    echo "usage: $0 <version-number>"
    exit 1
fi
VERSION="$1"

sed -i -e "s| LIB_VERSION=\".*\"| LIB_VERSION=\"${VERSION}\"|;s| LIB_DATE=\".*\"| LIB_DATE=\"${DATE}\"|;s| LIB_VCSVERSION=\".*\"| LIB_VCSVERSION=\"${GIT_VERSION}\"|" "$LIB_FILE" \
    && sed -i -e "s|^Version: .*$|Version: ${VERSION}|;s|^Date: .*$|Date: ${DATE}|" "$MDMAN_FILE" \
    && echo "version number updated in '${LIB_FILE}' and '${MDMAN_FILE}'" \
    || echo "an error occurred!" ;

exit 0
