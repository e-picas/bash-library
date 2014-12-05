
### load the lib script
load tests_loader
load_library

### the test file path
PBL_TESTSTR='Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'
PBL_TESTSTR_WRAP80='Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor
incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nost
rud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis
aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugi
at nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culp
a qui officia deserunt mollit anim id est laborum.'
PBL_TESTSTR_LENGTH=446
PBL_HELLOWORLD='hEllo wOrLd!'
PBL_HELLOWORLD_EXPLODED=( 'hEllo' 'wOrLd!' )
PBL_HELLOWORLD_EXPLODED_LETTERS=( h E l l o w O r L d ! )
PBL_HELLOWORLD_LOWER='hello world!'
PBL_HELLOWORLD_UPPER='HELLO WORLD!'
PBL_HELLOWORLD_UCF='HEllo wOrLd!'

### strings methods tests

@test "test of string_length" {
    run string_length "$PBL_TESTSTR"
    [ "$output" = "$PBL_TESTSTR_LENGTH" ]
}

@test "test of the strlen alias" {
    run strlen "$PBL_TESTSTR"
    [ "$output" = "$PBL_TESTSTR_LENGTH" ]
}

@test "test of string_to_upper" {
    run string_to_upper "$PBL_HELLOWORLD"
    [ "$output" = "$PBL_HELLOWORLD_UPPER" ]
}

@test "test of the strtoupper alias" {
    run strtoupper "$PBL_HELLOWORLD"
    [ "$output" = "$PBL_HELLOWORLD_UPPER" ]
}

@test "test of string_to_lower" {
    run string_to_lower "$PBL_HELLOWORLD"
    [ "$output" = "$PBL_HELLOWORLD_LOWER" ]
}

@test "test of the strtolower alias" {
    run strtolower "$PBL_HELLOWORLD"
    [ "$output" = "$PBL_HELLOWORLD_LOWER" ]
}

@test "test of upper_case_first" {
    run upper_case_first "$PBL_HELLOWORLD"
    [ "$output" = "$PBL_HELLOWORLD_UCF" ]
}

@test "test of the ucfirst alias" {
    run ucfirst "$PBL_HELLOWORLD"
    [ "$output" = "$PBL_HELLOWORLD_UCF" ]
}

@test "test of explode a string by words" {
    output=( $(explode "$PBL_HELLOWORLD" && echo "${EXPLODED_ARRAY[@]}") )
    [ "${#output[@]}" = "${#PBL_HELLOWORLD_EXPLODED[@]}" ]
    [ "${output[*]}" = "${PBL_HELLOWORLD_EXPLODED[*]}" ]
}

@test "test of explode a string by letters" {
    output=( $(explode_letters "$PBL_HELLOWORLD" && echo "${EXPLODED_ARRAY[@]}") )
    [ "${#output[@]}" = "${#PBL_HELLOWORLD_EXPLODED_LETTERS[@]}" ]
    [ "${output[*]}" = "${PBL_HELLOWORLD_EXPLODED_LETTERS[*]}" ]
}

@test "test of implode a string by words" {
    run implode PBL_HELLOWORLD_EXPLODED[@]
    [ "${output}" = "$PBL_HELLOWORLD" ]
}

@test "test of 'word_wrap' method with defaults" {
    skip # not working for now
    run word_wrap "$PBL_TESTSTR"
    [ "${output}" = "$PBL_TESTSTR_WRAP80" ]
}

