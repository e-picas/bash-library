#!/bin/bash

_here=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
_source=${_here}/../src/piwi-bash-library.sh
_output=${_here}/documentation.md
_lib=${_source}

source ${_lib} || echo "!! piwi-bash-library not found!" ;

export VERBOSE=true

build_documentation markdown $_output $_source \
    && echo "documentation generated in '$_output'" \
    || echo "an error occurred!" ;
