
### load the lib script
load tests_loader
load_library

### the test file path
export PBL_TESTSTR='Hello World!'
export PBL_TESTSTRUNQUOTED=Hello
export PBL_TESTINTQUOTED='123'
export PBL_TESTINT=123
export PBL_TESTSTR_MULTI="${PBL_TESTSTR}\n${PBL_TESTSTR}"
declare -xa PBL_TESTARRAY=('one' 'two' 3)
export PBL_TESTBOOL=true

### utils methods tests

@test "test of the 'is_string' method on a string" {
    run is_string "$PBL_TESTSTR"
    [ "$status" -eq 0 ]
}

@test "test of the 'is_string_by_variable_name' method on a string" {
    run is_string_by_variable_name "PBL_TESTSTR"
    [ "$status" -eq 0 ]
}

@test "test of the 'is_string' method on an unquoted string" {
    run is_string "$PBL_TESTSTRUNQUOTED"
    [ "$status" -eq 0 ]
}

@test "test of the 'is_numeric' method on a string" {
    run is_numeric "$PBL_TESTSTR"
    [ "$status" -eq 1 ]
}

@test "test of the 'is_numeric' method on an unquoted string" {
    run is_numeric "$PBL_TESTSTRUNQUOTED"
    [ "$status" -eq 1 ]
}

@test "test of the 'is_numeric' method on an integer" {
    run is_numeric "$PBL_TESTINT"
    [ "$status" -eq 0 ]
}

@test "test of the 'is_numeric' method on a quoted integer" {
    run is_numeric "$PBL_TESTINTQUOTED"
    [ "$status" -eq 0 ]
}

@test "test of the 'is_numeric_by_variable_name' method on an integer" {
    run is_numeric_by_variable_name "PBL_TESTINT"
#echo "output is: $output"
#echo "lines are: "; for l in "${lines[@]}"; do echo "$l"; done
#echo "status is: $status"
    [ "$status" -eq 0 ]
}

@test "test of the 'is_boolean' method on a boolean" {
    run is_boolean "$PBL_TESTBOOL"
    [ "$status" -eq 0 ]
}

@test "test of the 'is_boolean' method on a string" {
    run is_boolean "$PBL_TESTSTR"
    [ "$status" -eq 1 ]
}

@test "test of the 'is_boolean_by_variable_name' method on a boolean" {
    run is_boolean_by_variable_name "PBL_TESTBOOL"
    [ "$status" -eq 0 ]
}

@test "test of the 'is_boolean_by_variable_name' method on a string" {
    run is_boolean_by_variable_name "PBL_TESTSTR"
    [ "$status" -eq 1 ]
}

@test "test of the 'is_array_by_variable_name' method on an array" {
skip 'array testers are not functional for now ...'
    run is_array_by_variable_name "PBL_TESTARRAY"
#echo "output is: $output"
#echo "lines are: "; for l in "${lines[@]}"; do echo "$l"; done
#echo "status is: $status"
    [ "$status" -eq 0 ]
}

@test "test of the 'is_array_by_variable_name' method on a string" {
    run is_array_by_variable_name "PBL_TESTSTR"
    [ "$status" -eq 1 ]
}

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
