
### load the lib script
load tests_loader
load_library

### the test file path
PBL_TESTSTR='hello world!'

### flags methods tests

# verbose
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

# quiet
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
