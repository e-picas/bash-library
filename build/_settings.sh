#!/bin/bash

# builders settings

export HERE=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
export DATE=$(git log -1 --format="%ci" --date=short | cut -s -f 1 -d ' ')

export LIB_SOURCE="bin/piwi-bash-library.bash"
export LIB_FILE="${HERE}/../${LIB_SOURCE}"
export TESTS_DIR="${HERE}/../tests"
export MDDOC_SOURCE="DOCUMENTATION.md"
export MDDOC_FILE="${HERE}/../${MDDOC_SOURCE}"
export MDMAN_SOURCE="man/MANPAGE.md"
export MDMAN_FILE="${HERE}/../${MDMAN_SOURCE}"
export MAN_SOURCE="man/piwi-bash-library.man"
export MAN_FILE="${HERE}/../${MAN_SOURCE}"
export DOCMAN_SOURCE="man/piwi-bash-library.7.man"
export DOCMAN_FILE="${HERE}/../${DOCMAN_SOURCE}"
export MDE_BIN="${HERE}/../modules/markdown-extended/bin/markdown-extended"
export BATS_BIN="${HERE}/../modules/bats/libexec/bats"
declare -xa TEST_FILES=()

# checks

if [ ! -f "$LIB_FILE" ]; then
    echo "!! '${LIB_FILE}' not found!" ;
    exit 1
fi

if [ ! -f "$MDMAN_FILE" ]; then
    echo "!! '${MDMAN_FILE}' not found!" ;
    exit 1
fi
