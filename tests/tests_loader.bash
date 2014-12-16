
# BATS usage:

#echo "> output is: $output"
#echo "> lines are: "; for l in "${lines[@]}"; do echo "$l"; done
#echo "> status is: $status"

# library path
export PBL_LIBFILE="$BATS_TEST_DIRNAME/../bin/piwi-bash-library.sh"

# load the library
load_library() {
if [ -f "$PBL_LIBFILE" ]; then source "$PBL_LIBFILE"; else
    PADDER=$(printf '%0.1s' "#"{1..1000})
    printf "\n### %*.*s\n    %s\n    %s\n%*.*s\n\n" 0 $(($(tput cols)-4)) "ERROR! ${PADDER}" \
        "Unable to find required library file '${PBL_LIBFILE}'!" \
        "Sent in '${0}' line '${LINENO}' by '$(whoami)' - pwd is '$(pwd)'" \
        0 $(tput cols) "${PADDER}";
    exit 1
fi
}
