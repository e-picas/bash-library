#!/bin/bash

_here=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
_source=src/piwi-bash-library.sh
_output=DOCUMENTATION.md
_lib=${_here}/../${_source}
_type=markdown
#_type=terminal

# for dev
#_source=${_here}/../dev/test-doc.sh
#_output=${_here}/documentation.md

source ${_lib} || echo "!! piwi-bash-library not found!" ;

export VERBOSE=true

build_documentation "$_type" "$_output" "$_source" \
    && echo "documentation generated in '$_output'" \
    || echo "an error occurred!" ;

exit 0

# generate a manpage from the doc ...
_source="$_output"
_output=src/piwi-bash-library.7.man
_mde=${_here}/../modules/markdown-extended/bin/markdown-extended

${_mde} -f man -o "$_output" "${_source}" \
    && echo "manpage generated in '$_output'" \
    || echo "an error occurred!" ;
