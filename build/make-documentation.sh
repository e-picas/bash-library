#!/bin/bash

if [ "$(pwd)/build" == "$(dirname "$(realpath ${BASH_SOURCE[0]})")" ]
then
    source "$(dirname $0)/_settings.sh";
else
    echo "!! you must run shell builders from package's root directory !!"
    exit 1
fi

source "$LIB_FILE"

DOC_TYPE=markdown
#DOC_TYPE=terminal
# for dev
#LIBSOURCE="${HERE}/../dev/test-doc.sh"
#DOC_OUTPUT="${HERE}/documentation.md"

verbose_mode 1

echo "> build_documentation '$DOC_TYPE' '$MDDOC_FILE' '$LIB_SOURCE'"
build_documentation "$DOC_TYPE" "$MDDOC_FILE" "$LIB_SOURCE" \
    && echo "documentation generated in '${MDDOC_FILE}'" \
    || echo "an error occurred!" ;

exit 0
