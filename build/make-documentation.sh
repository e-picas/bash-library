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