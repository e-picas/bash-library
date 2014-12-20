#!/bin/bash

if [ "$(pwd)/build" == "$(dirname "$(realpath ${BASH_SOURCE[0]})")" ]
then
    source "$(dirname $0)/_settings.sh";
else
    echo "!! you must run shell builders from package's root directory !!"
    exit 1
fi

if [ ! -f "$MDE_BIN" ]; then
    echo "!! '${MDE_BIN}' not found!"
    echo "run 'git submodule init / update'"
    exit 1
fi

echo "> ${MDE_BIN} -f man -o '$MAN_FILE' '$MDMAN_FILE'"
"${MDE_BIN}" -f man -o "$MAN_FILE" "$MDMAN_FILE" \
    && echo "manpage generated in '${MDMAN_FILE}'" \
    || echo "an error occurred!" ;

exit 0

# generate a manpage from the doc ...

if [ ! -f "$MDDOC_FILE" ]; then
    echo "!! '${MDDOC_FILE}' not found!" ;
    exit 1
fi

echo "> ${MDE_BIN} -f man -o '$DOC_MANPAGE' '$MDDOC_FILE'"
"${MDE_BIN}" -f man -o "$DOCMAN_FILE" "$MDDOC_FILE" \
    && echo "manpage generated in '${DOCMAN_FILE}'" \
    || echo "an error occurred!" ;

exit 0
