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

if [ "$#" -lt 1 ]; then
	echo "current version is: ${ACTUAL_VERSION} (${GIT_VERSION})"
	echo "usage: $0 <version-number> [sign=false]"
	exit 1
fi
VERSION="$1"
SIGN="${2:-false}"

./build/make-version.sh "$VERSION"
./build/make-documentation.sh
./build/make-manpage.sh

echo "> commiting new files ..."
git add "$LIB_FILE" "$MAN_OUTPUT" "$DOC_OUTPUT" \
	&& git commit -m "Version ${VERSION} : automatic version number and date insertion" \
	&& git commit --amend ;
#LASTSHA=$(git log -1 --format="%H")

echo "> making new tag '${VERSION}' ..."
if [ "$SIGN" = 'true' ]
then
	git tag --sign -a "v${VERSION}" -m "new realease '${VERSION}' (${GIT_VERSION})"
else
	git tag -a "v${VERSION}" -m "new realease '${VERSION}' (${GIT_VERSION})"
fi

echo ">> ok, realease tag 'v${VERSION}' is done, you should now run:"
echo "              git push origin master wip && git push origin v${VERSION}"

exit 0
