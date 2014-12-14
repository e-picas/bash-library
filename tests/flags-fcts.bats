
### load the lib script
load tests_loader
load_library

### the test file path
PBL_TESTSTR='hello world!'

### flags methods tests

# verbose
@test "test of 'VERBOSE' status onload" {
    [ "$VERBOSE" = 'false' ]
}

@test "test of 'verbose_mode 1'" {
    flag1="$VERBOSE"
    verbose_mode 1
    flag2="$VERBOSE"
    [ "$flag1" != "$flag2" ]
    [ "$flag2" = 'true' ]
}

@test "test of 'verbose_mode 0'" {
    export VERBOSE=true
    flag1="$VERBOSE"
    verbose_mode 0
    flag2="$VERBOSE"
    [ "$flag1" != "$flag2" ]
    [ "$flag2" = 'false' ]
}

@test "test of 'verbose_mode true'" {
    flag1="$VERBOSE"
    verbose_mode true
    flag2="$VERBOSE"
    [ "$flag1" != "$flag2" ]
    [ "$flag2" = 'true' ]
}

@test "test of 'verbose_mode false'" {
    export VERBOSE=true
    flag1="$VERBOSE"
    verbose_mode false
    flag2="$VERBOSE"
    [ "$flag1" != "$flag2" ]
    [ "$flag2" = 'false' ]
}

@test "test of 'quiet_mode 1' (must turn off verbosity)" {
    export VERBOSE=true
    flag1="$VERBOSE"
    quiet_mode 1
    flag2="$VERBOSE"
    [ "$flag1" != "$flag2" ]
    [ "$flag2" = 'false' ]
}

@test "test of 'debug_mode 1' (must turn on verbosity)" {
    flag1="$VERBOSE"
    debug_mode 1
    flag2="$VERBOSE"
    [ "$flag1" != "$flag2" ]
    [ "$flag2" = 'true' ]
}

@test "test of 'verbose_echo' in not verbose mode" {
    run verbose_echo "$PBL_TESTSTR"
    [ "$output" = '' ]
    [ "$status" -eq 0 ]
}

@test "test of 'verbose_echo' in verbose mode" {
    export VERBOSE=true
    run verbose_echo "$PBL_TESTSTR"
    export VERBOSE=false
    [ -z "$output" ] && [ "$output" = "$PBL_TESTSTR" ]
    [ "$status" -eq 0 ]
}

@test "test of the 'verecho' alias in not verbose mode" {
    run verecho "$PBL_TESTSTR"
    [ "$output" = '' ]
    [ "$status" -eq 0 ]
}

@test "test of the 'verecho' alias in verbose mode" {
    export VERBOSE=true
    run verecho "$PBL_TESTSTR"
    export VERBOSE=false
    [ -z "$output" ] && [ "$output" = "$PBL_TESTSTR" ]
    [ "$status" -eq 0 ]
}

# quietness
@test "test of 'QUIET' status onload" {
    [ "$QUIET" = 'false' ]
}

@test "test of 'quiet_mode 1'" {
    flag1="$QUIET"
    quiet_mode 1
    flag2="$QUIET"
    [ "$flag1" != "$flag2" ]
    [ "$flag2" = 'true' ]
}

@test "test of 'quiet_mode 0'" {
    export QUIET=true
    flag1="$QUIET"
    quiet_mode 0
    flag2="$QUIET"
    [ "$flag1" != "$flag2" ]
    [ "$flag2" = 'false' ]
}

@test "test of 'quiet_mode true'" {
    flag1="$QUIET"
    quiet_mode true
    flag2="$QUIET"
    [ "$flag1" != "$flag2" ]
    [ "$flag2" = 'true' ]
}

@test "test of 'quiet_mode false'" {
    export QUIET=true
    flag1="$QUIET"
    quiet_mode false
    flag2="$QUIET"
    [ "$flag1" != "$flag2" ]
    [ "$flag2" = 'false' ]
}

@test "test of 'verbose_mode 1' (must turn off quietness)" {
    export QUIET=true
    flag1="$QUIET"
    verbose_mode 1
    flag2="$QUIET"
    [ "$flag1" != "$flag2" ]
    [ "$flag2" = 'false' ]
}

@test "test of 'debug_mode 1' (must turn off quietness)" {
    export QUIET=true
    flag1="$QUIET"
    debug_mode 1
    flag2="$QUIET"
    [ "$flag1" != "$flag2" ]
    [ "$flag2" = 'false' ]
}

@test "test of 'quiet_echo' in not quiet mode" {
    run quiet_echo "$PBL_TESTSTR"
    [ -z "$output" ] && [ "$output" = "$PBL_TESTSTR" ]
    [ "$status" -eq 0 ]
}

@test "test of 'quiet_echo' in quiet mode" {
    export QUIET=true
    run quiet_echo "$PBL_TESTSTR"
    export QUIET=false
    [ "$output" = '' ]
    [ "$status" -eq 0 ]
}

@test "test of the 'quietecho' alias in not quiet mode" {
    run quietecho "$PBL_TESTSTR"
    [ -z "$output" ] && [ "$output" = "$PBL_TESTSTR" ]
    [ "$status" -eq 0 ]
}

@test "test of the 'quietecho' alias in quiet mode" {
    export QUIET=true
    run quietecho "$PBL_TESTSTR"
    export QUIET=false
    [ "$output" = '' ]
    [ "$status" -eq 0 ]
}

# debug
@test "test of 'DEBUG' status onload" {
    [ "$DEBUG" = 'false' ]
}

@test "test of 'debug_mode 1'" {
    flag1="$DEBUG"
    debug_mode 1
    flag2="$DEBUG"
    [ "$flag1" != "$flag2" ]
    [ "$flag2" = 'true' ]
}

@test "test of 'quiet_mode 0'" {
    export DEBUG=true
    flag1="$DEBUG"
    debug_mode 0
    flag2="$DEBUG"
    [ "$flag1" != "$flag2" ]
    [ "$flag2" = 'false' ]
}

@test "test of 'quiet_mode true'" {
    flag1="$DEBUG"
    debug_mode true
    flag2="$DEBUG"
    [ "$flag1" != "$flag2" ]
    [ "$flag2" = 'true' ]
}

@test "test of 'quiet_mode false'" {
    export DEBUG=true
    flag1="$DEBUG"
    debug_mode false
    flag2="$DEBUG"
    [ "$flag1" != "$flag2" ]
    [ "$flag2" = 'false' ]
}

@test "test of 'quiet_mode 1' (must turn off debug)" {
    export DEBUG=true
    flag1="$DEBUG"
    quiet_mode 1
    flag2="$DEBUG"
    [ "$flag1" != "$flag2" ]
    [ "$flag2" = 'false' ]
}

@test "test of 'debug_echo' in not debug mode" {
    run debug_echo "$PBL_TESTSTR"
    [ "$output" = '' ]
    [ "$status" -eq 0 ]
}

@test "test of 'debug_echo' in debug mode" {
    export DEBUG=true
    run debug_echo "$PBL_TESTSTR"
    export DEBUG=false
    [ -z "$output" ] && [ "$output" = "$PBL_TESTSTR" ]
    [ "$status" -eq 0 ]
}

@test "test of the 'debecho' alias in not verbose mode" {
    run debecho "$PBL_TESTSTR"
    [ "$output" = '' ]
    [ "$status" -eq 0 ]
}

@test "test of the 'verecho' alias in verbose mode" {
    export DEBUG=true
    run debecho "$PBL_TESTSTR"
    export DEBUG=false
    [ -z "$output" ] && [ "$output" = "$PBL_TESTSTR" ]
    [ "$status" -eq 0 ]
}

# interactivity
@test "test of 'INTERACTIVE' status onload" {
    [ "$INTERACTIVE" = 'false' ]
}

@test "test of 'interactive_mode 1'" {
    flag1="$INTERACTIVE"
    interactive_mode 1
    flag2="$INTERACTIVE"
    [ "$flag1" != "$flag2" ]
    [ "$flag2" = 'true' ]
}

@test "test of 'interactive_mode 0'" {
    export INTERACTIVE=true
    flag1="$INTERACTIVE"
    interactive_mode 0
    flag2="$INTERACTIVE"
    [ "$flag1" != "$flag2" ]
    [ "$flag2" = 'false' ]
}

@test "test of 'interactive_mode true'" {
    flag1="$INTERACTIVE"
    interactive_mode true
    flag2="$INTERACTIVE"
    [ "$flag1" != "$flag2" ]
    [ "$flag2" = 'true' ]
}

@test "test of 'interactive_mode false'" {
    export INTERACTIVE=true
    flag1="$INTERACTIVE"
    interactive_mode false
    flag2="$INTERACTIVE"
    [ "$flag1" != "$flag2" ]
    [ "$flag2" = 'false' ]
}

@test "test of 'forcing_mode 1' (must turn off interactivity)" {
    export INTERACTIVE=true
    flag1="$INTERACTIVE"
    forcing_mode 1
    flag2="$INTERACTIVE"
    [ "$flag1" != "$flag2" ]
    [ "$flag2" = 'false' ]
}

# forcing
@test "test of 'FORCED' status onload" {
    [ "$FORCED" = 'false' ]
}

@test "test of 'forcing_mode 1'" {
    flag1="$FORCED"
    forcing_mode 1
    flag2="$FORCED"
    [ "$flag1" != "$flag2" ]
    [ "$flag2" = 'true' ]
}

@test "test of 'forcing_mode 0'" {
    export FORCED=true
    flag1="$FORCED"
    forcing_mode 0
    flag2="$FORCED"
    [ "$flag1" != "$flag2" ]
    [ "$flag2" = 'false' ]
}

@test "test of 'forcing_mode true'" {
    flag1="$FORCED"
    forcing_mode true
    flag2="$FORCED"
    [ "$flag1" != "$flag2" ]
    [ "$flag2" = 'true' ]
}

@test "test of 'forcing_mode false'" {
    export FORCED=true
    flag1="$FORCED"
    forcing_mode false
    flag2="$FORCED"
    [ "$flag1" != "$flag2" ]
    [ "$flag2" = 'false' ]
}

@test "test of 'interactive_mode 1' (must turn off forcing)" {
    export FORCED=true
    flag1="$FORCED"
    interactive_mode 1
    flag2="$FORCED"
    [ "$flag1" != "$flag2" ]
    [ "$flag2" = 'false' ]
}

# dry-run
@test "test of 'DRYRUN' status onload" {
    [ "$DRYRUN" = 'false' ]
}

@test "test of 'dryrun_mode 1'" {
    flag1="$DRYRUN"
    dryrun_mode 1
    flag2="$DRYRUN"
    [ "$flag1" != "$flag2" ]
    [ "$flag2" = 'true' ]
}

@test "test of 'dryrun_mode 0'" {
    export DRYRUN=true
    flag1="$DRYRUN"
    dryrun_mode 0
    flag2="$DRYRUN"
    [ "$flag1" != "$flag2" ]
    [ "$flag2" = 'false' ]
}

@test "test of 'dryrun_mode true'" {
    flag1="$DRYRUN"
    dryrun_mode true
    flag2="$DRYRUN"
    [ "$flag1" != "$flag2" ]
    [ "$flag2" = 'true' ]
}

@test "test of 'dryrun_mode false'" {
    export DRYRUN=true
    flag1="$DRYRUN"
    dryrun_mode false
    flag2="$DRYRUN"
    [ "$flag1" != "$flag2" ]
    [ "$flag2" = 'false' ]
}

# options
@test "test of '--verbose' script option" {
    run $PBL_LIBFILE --verbose --exec 'echo "$VERBOSE"'
    [ "${lines[1]}" = 'true' ]
    [ "$status" -eq 0 ]
}

@test "test of '-v' shortcut script option" {
    run $PBL_LIBFILE -v --exec 'echo "$VERBOSE"'
    [ "${lines[1]}" = 'true' ]
    [ "$status" -eq 0 ]
}

@test "test of '--quiet' script option" {
    run $PBL_LIBFILE --quiet --exec 'echo "$QUIET"'
    [ -z "$output" ]
    [ "$status" -eq 0 ]
}

@test "test of '-q' shortcut script option" {
    run $PBL_LIBFILE -q --exec 'echo "$QUIET"'
    [ -z "$output" ]
    [ "$status" -eq 0 ]
}

@test "test of '--interactive' script option" {
    run $PBL_LIBFILE --interactive --exec 'echo "$INTERACTIVE"'
    [ "${lines[0]}" = 'true' ]
    [ "$status" -eq 0 ]
}

@test "test of '-i' script option" {
    run $PBL_LIBFILE -i --exec 'echo "$INTERACTIVE"'
    [ "${lines[0]}" = 'true' ]
    [ "$status" -eq 0 ]
}

@test "test of '--force' script option" {
    run $PBL_LIBFILE --force --exec 'echo "$FORCED"'
    [ "${lines[0]}" = 'true' ]
    [ "$status" -eq 0 ]
}

@test "test of '-f' script option" {
    run $PBL_LIBFILE -f --exec 'echo "$FORCED"'
    [ "${lines[0]}" = 'true' ]
    [ "$status" -eq 0 ]
}

@test "test of '--dry-run' script option" {
    run $PBL_LIBFILE --dry-run --exec 'echo "$DRYRUN"'
    [ "${lines[0]}" = 'true' ]
    [ "$status" -eq 0 ]
}

@test "test of '--quiet --verbose' script options for precedence" {
    run $PBL_LIBFILE --quiet --verbose --exec 'echo "$VERBOSE"'
    [ "${lines[1]}" = 'true' ]
    [ "$status" -eq 0 ]
}

@test "test of '-q -v' shortcut script options for precedence" {
    run $PBL_LIBFILE -q -v --exec 'echo "$VERBOSE"'
    [ "${lines[1]}" = 'true' ]
    [ "$status" -eq 0 ]
}
