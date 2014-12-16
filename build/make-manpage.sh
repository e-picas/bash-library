#!/bin/bash

_here=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
_source=MANPAGE.md
_output=man/piwi-bash-library.man
_mde=${_here}/../modules/markdown-extended/bin/markdown-extended

${_mde} -f man -o "$_output" "${_source}" \
    && echo "manpage generated in '$_output'" \
    || echo "an error occurred!" ;
