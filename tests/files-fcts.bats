
### load the lib script
load tests_loader
load_library

### the test file path
PBL_TESTFILE="$(pwd)/tests/tests_loader.bash"
if [ ! -f "$PBL_TESTFILE" ]; then
    echo "> test file '$PBL_TESTFILE' not found!"
    exit 1
fi

### files methods tests

@test "getting file extension ('get_extension()' method)" {
    run get_extension "$PBL_TESTFILE"
    [ "$output" = 'bash' ]
    [ "$status" -eq 0 ]
}

@test "getting file name ('get_filename()' method)" {
    run get_filename "$PBL_TESTFILE"
    [ "$output" = 'tests_loader' ]
    [ "$status" -eq 0 ]
}

@test "getting base name ('get_basename()' method)" {
    run get_basename "$PBL_TESTFILE"
    [ "$output" = "tests_loader.bash" ]
    [ "$status" -eq 0 ]
}

@test "getting directory name ('get_dirname()' method)" {
    run get_dirname "$PBL_TESTFILE"
    [ "$output" = "$(pwd)/tests" ] || [ "$output" = "$(pwd)/tests/" ]
    [ "$status" -eq 0 ]
}

@test "resolving absolute path ('get_absolute_path()' method)" {
    run get_absolute_path "$(pwd)/src/../tests/tests_loader.bash"
    [ "$output" = "$PBL_TESTFILE" ]
    [ "$status" -eq 0 ]
}

@test "test of the 'realpath()' alias (previous test)" {
    run realpath "$(pwd)/src/../tests/tests_loader.bash"
    [ "$output" = "$PBL_TESTFILE" ]
    [ "$status" -eq 0 ]
}

@test "test of the 'resolve()' utility on '~/bin'" {
    run resolve '~/bin'
    [ "$output" = "${HOME}/bin" ]
    [ "$status" -eq 0 ]
}

@test "test of the 'resolve()' utility on './tests/tests_loader.bash'" {
    run resolve './tests/tests_loader.bash'
    [ "$(realpath "$output")" = "$PBL_TESTFILE" ]
    [ "$status" -eq 0 ]
}
