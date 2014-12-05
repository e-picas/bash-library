
### load the lib script
load tests_loader
load_library

### the test file path
PBL_TESTARRAY=( 'one' 'two' 'four' )

### arrays methods tests

@test "test of in_array valid" {
    run in_array two "${PBL_TESTARRAY[@]}"
    [ "$status" -eq 0 ]
}

@test "test of in_array invalid" {
    run in_array three "${PBL_TESTARRAY[@]}"
    [ "$status" -eq 1 ]
}

@test "test of array_search" {
    run array_search two "${PBL_TESTARRAY[@]}"
    [ "$status" -eq 0 ]
    [ "$output" -eq 1 ]
}

@test "test of array_search for inexistant item" {
    run array_search three "${PBL_TESTARRAY[@]}"
    [ "$status" -eq 1 ]
    [ -z "$output" ]
}

@test "test of array_filter" {
    testarray=( 'one' 'two' '' 'four' )
    output=( $(array_filter "${testarray[@]}") )
    [ "${#output[@]}" = "${#PBL_TESTARRAY[@]}" ]
    [ "${output[*]}" = "${PBL_TESTARRAY[*]}" ]
}
