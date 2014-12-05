
load_library() {
######## Inclusion of the lib
LIBFILE="$BATS_TEST_DIRNAME/../src/piwi-bash-library.sh"
if [ -f "$LIBFILE" ]; then source "$LIBFILE"; else
    PADDER=$(printf '%0.1s' "#"{1..1000})
    printf "\n### %*.*s\n    %s\n    %s\n%*.*s\n\n" 0 $(($(tput cols)-4)) "ERROR! ${PADDER}" \
        "Unable to find required library file '${LIBFILE}'!" \
        "Sent in '${0}' line '${LINENO}' by '$(whoami)' - pwd is '$(pwd)'" \
        0 $(tput cols) "${PADDER}";
    exit 1
fi
######## !Inclusion of the lib
}
