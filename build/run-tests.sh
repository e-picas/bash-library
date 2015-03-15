#!/bin/bash

if [ "$(pwd)/build" == "$(dirname "$(readlink -f ${BASH_SOURCE[0]})")" ]
then
    source "$(dirname $0)/_settings.sh";
else
    echo "!! you must run shell builders from package's root directory !!"
    exit 1
fi

if [ ! -d "$TESTS_DIR" ]; then
    echo "!! '${TESTS_DIR}' not found!" ;
    exit 1
fi

if [ ! -f "$BATS_BIN" ]; then
    echo "!! '${BATS_BIN}' not found!"
    echo "run 'git submodule init / update'"
    exit 1
fi

# this breaks travis-ci auto-testing ...
#if [ "$(git rev-parse --abbrev-ref HEAD)" != 'dev' ]; then
#    echo "!! test can ONLY be ran from the 'dev' branch!"
#    exit 0
#fi

_TORUN="${1:-all}"

if [ "$_TORUN" = 'all' ]
then
    i=0
    while read line
    do
        TEST_FILES+=( "${line}" )
        (( i++ ))
    done < <(find "${TESTS_DIR}" -name "*.bats")
else
    if [ -f "${TESTS_DIR}/${_TORUN}" ]
    then
        TEST_FILES=( "${TESTS_DIR}/${_TORUN}" )
    elif [ -f "${TESTS_DIR}/${_TORUN}.bats" ]
    then
        TEST_FILES=( "${TESTS_DIR}/${_TORUN}.bats" )
    elif [ -f "${TESTS_DIR}/${_TORUN}-fcts.bats" ]
    then
        TEST_FILES=( "${TESTS_DIR}/${_TORUN}-fcts.bats" )
    else
        echo "> test file '${_TORUN}' not found in '${TESTS_DIR}'!"
        exit 1
    fi
fi

for f in "${TEST_FILES[@]}"; do
    echo
    echo "# running '$(basename "$f")' ..."
    "${BATS_BIN}" "$f"
done

echo
echo '# done'
