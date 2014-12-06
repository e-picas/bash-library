
### load the lib script
load tests_loader
load_library

### the test file path
PBL_TESTSTR='Hello World!'
PBL_TESTSTR_MULTI="${PBL_TESTSTR}\n${PBL_TESTSTR}"

### utils methods tests

@test "test of the '_echo' method" {
    run _echo "$PBL_TESTSTR"
    [ "$output" = "$PBL_TESTSTR" ]
    [ "$status" -eq 0 ]
}

@test "test of the '_echo' method on a multi-lines string" {
    run _echo "$PBL_TESTSTR_MULTI"
    [ "${lines[0]}" = "$PBL_TESTSTR" ]
    [ "${lines[1]}" = "$PBL_TESTSTR" ]
    [ "$status" -eq 0 ]
}

@test "test of the '_necho' method" {
    run _necho "$PBL_TESTSTR"
    [ "$output" = "$PBL_TESTSTR" ]
    [ "${lines[0]}" = "$PBL_TESTSTR" ]
    [ "$status" -eq 0 ]
}

@test "test of the '_necho' method on a multi-lines string" {
    run _necho "$PBL_TESTSTR_MULTI"
    [ "${lines[0]}" = "$PBL_TESTSTR" ]
    [ "${lines[1]}" = "$PBL_TESTSTR" ]
    [ "$status" -eq 0 ]
}
