#!/bin/bash

_here=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
_source=${_here}/../modules/bats/libexec/bats
_testsuite=${_here}/../tests
declare -a _testfiles=()

torun="${1:-all}"

if [ "$torun" = 'all' ]
then
    i=0
    while read line
    do
        _testfiles+=( "${line}" )
        (( i++ ))
    done < <(find "${_testsuite}" -name "*.bats")
else
    if [ -f "${_testsuite}/${torun}" ]
    then
        _testfiles=( "${_testsuite}/${torun}" )
    elif [ -f "${_testsuite}/${torun}.bats" ]
    then
        _testfiles=( "${_testsuite}/${torun}.bats" )
    elif [ -f "${_testsuite}/${torun}-fcts.bats" ]
    then
        _testfiles=( "${_testsuite}/${torun}-fcts.bats" )
    else
        echo "> test file '${torun}' not found in '${_testsuite}'!"
        exit 1
    fi
fi

for f in "${_testfiles[@]}"; do
    echo
    echo "# running '$(basename "$f")' ..."
    ${_source} "$f"
done

echo
echo '# done'
