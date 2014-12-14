
### load the lib script
load tests_loader
load_library

### the test file path
PBL_EXEC="echo 'test'"
PBL_EVAL="echo 'std out'; echo 'std err' >&2; exit 0;"

### jobs control tests

# execute
@test "test of the 'execute' method in 'normal' mode" {
    run execute "$PBL_EXEC"
#echo "output is: $output"
#echo "lines are: "; for l in "${lines[@]}"; do echo "$l"; done
#echo "status is: $status"
    [ "$output" = 'test' ]
    [ "$status" -eq 0 ]
}

@test "test of the 'debug_execute' method in 'normal' mode" {
    run debug_execute "$PBL_EXEC"
#echo "output is: $output"
#echo "lines are: "; for l in "${lines[@]}"; do echo "$l"; done
#echo "status is: $status"
    [ "$output" = 'test' ]
    [ "$status" -eq 0 ]
}

@test "test of the 'debug_exec' alias in 'normal' mode" {
    run debug_exec "$PBL_EXEC"
#echo "output is: $output"
#echo "lines are: "; for l in "${lines[@]}"; do echo "$l"; done
#echo "status is: $status"
    [ "$output" = 'test' ]
    [ "$status" -eq 0 ]
}

@test "test of the 'debexec' alias in 'normal' mode" {
    run debexec "$PBL_EXEC"
#echo "output is: $output"
#echo "lines are: "; for l in "${lines[@]}"; do echo "$l"; done
#echo "status is: $status"
    [ "$output" = 'test' ]
    [ "$status" -eq 0 ]
}

@test "test of the 'debug_execute' method in 'debug' mode" {
    export DEBUG=true
    run debug_execute "$PBL_EXEC"
#echo "output is: $output"
#echo "lines are: "; for l in "${lines[@]}"; do echo "$l"; done
#echo "status is: $status"
    [ "${lines[0]: -13}" = "\"echo 'test'\"" ]
    [ "${lines[1]}" = 'test' ]
    [ "$status" -eq 0 ]
}

@test "test of the 'debug_exec' alias in 'debug' mode" {
    export DEBUG=true
    run debug_exec "$PBL_EXEC"
#echo "output is: $output"
#echo "lines are: "; for l in "${lines[@]}"; do echo "$l"; done
#echo "status is: $status"
    [ "${lines[0]: -13}" = "\"echo 'test'\"" ]
    [ "${lines[1]}" = 'test' ]
    [ "$status" -eq 0 ]
}

@test "test of the 'debexec' alias in 'debug' mode" {
    export DEBUG=true
    run debexec "$PBL_EXEC"
#echo "output is: $output"
#echo "lines are: "; for l in "${lines[@]}"; do echo "$l"; done
#echo "status is: $status"
    [ "${lines[0]: -13}" = "\"echo 'test'\"" ]
    [ "${lines[1]}" = 'test' ]
    [ "$status" -eq 0 ]
}

@test "test of the 'debug_execute' method in 'dry-run' mode" {
    export DRYRUN=true
    run debug_execute "$PBL_EXEC"
#echo "output is: $output"
#echo "lines are: "; for l in "${lines[@]}"; do echo "$l"; done
#echo "status is: $status"
    [ "${lines[0]: -13}" = "\"echo 'test'\"" ]
    [ "${#lines[@]}" -eq 1 ]
    [ "$status" -eq 0 ]
}

@test "test of the 'debug_exec' alias in 'dry-run' mode" {
    export DRYRUN=true
    run debug_exec "$PBL_EXEC"
#echo "output is: $output"
#echo "lines are: "; for l in "${lines[@]}"; do echo "$l"; done
#echo "status is: $status"
    [ "${lines[0]: -13}" = "\"echo 'test'\"" ]
    [ "${#lines[@]}" -eq 1 ]
    [ "$status" -eq 0 ]
}

@test "test of the 'debexec' alias in 'dry-run' mode" {
    export DRYRUN=true
    run debexec "$PBL_EXEC"
#echo "output is: $output"
#echo "lines are: "; for l in "${lines[@]}"; do echo "$l"; done
#echo "status is: $status"
    [ "${lines[0]: -13}" = "\"echo 'test'\"" ]
    [ "${#lines[@]}" -eq 1 ]
    [ "$status" -eq 0 ]
}

@test "test of the 'interactive_execute' method in 'normal' mode" {
    run interactive_execute "$PBL_EXEC"
#echo "output is: $output"
#echo "lines are: "; for l in "${lines[@]}"; do echo "$l"; done
#echo "status is: $status"
    [ "$output" = 'test' ]
    [ "$status" -eq 0 ]
}

@test "test of the 'interactive_exec' alias in 'normal' mode" {
    run interactive_exec "$PBL_EXEC"
#echo "output is: $output"
#echo "lines are: "; for l in "${lines[@]}"; do echo "$l"; done
#echo "status is: $status"
    [ "$output" = 'test' ]
    [ "$status" -eq 0 ]
}

@test "test of the 'iexec' alias in 'normal' mode" {
    run iexec "$PBL_EXEC"
#echo "output is: $output"
#echo "lines are: "; for l in "${lines[@]}"; do echo "$l"; done
#echo "status is: $status"
    [ "$output" = 'test' ]
    [ "$status" -eq 0 ]
}

@test "test of the 'interactive_execute' method in 'interactive' mode" {
    export INTERACTIVE=true
    run interactive_execute "$PBL_EXEC" <<-USERINPUT
y
USERINPUT
#echo "output is: $output"
#echo "lines are: "; for l in "${lines[@]}"; do echo "$l"; done
#echo "status is: $status"
    [ "${lines[0]:0:1}" = '?' ]
    [ "${lines[0]: -4}" = 'test' ]
    [ "$status" -eq 0 ]
}

@test "test of the 'interactive_exec' alias in 'interactive' mode" {
    export INTERACTIVE=true
    run interactive_exec "$PBL_EXEC" <<-USERINPUT
y
USERINPUT
#echo "output is: $output"
#echo "lines are: "; for l in "${lines[@]}"; do echo "$l"; done
#echo "status is: $status"
    [ "${lines[0]:0:1}" = '?' ]
    [ "${lines[0]: -4}" = 'test' ]
    [ "$status" -eq 0 ]
}

@test "test of the 'iexec' alias in 'interactive' mode" {
    export INTERACTIVE=true
    run iexec "$PBL_EXEC" <<-USERINPUT
y
USERINPUT
#echo "output is: $output"
#echo "lines are: "; for l in "${lines[@]}"; do echo "$l"; done
#echo "status is: $status"
    [ "${lines[0]:0:1}" = '?' ]
    [ "${lines[0]: -4}" = 'test' ]
    [ "$status" -eq 0 ]
}

@test "test of the 'interactive_execute' method in 'interactive' mode with response 'no'" {
    export INTERACTIVE=true
    run interactive_execute "$PBL_EXEC" <<-USERINPUT
no
USERINPUT
#echo "output is: $output"
#echo "lines are: "; for l in "${lines[@]}"; do echo "$l"; done
#echo "status is: $status"
    [ "${lines[0]: -2}" = 'no' ]
    [ "$status" -eq 1 ]
}

@test "test of the 'interactive_exec' alias in 'interactive' mode with response 'no'" {
    export INTERACTIVE=true
    run interactive_exec "$PBL_EXEC" <<-USERINPUT
no
USERINPUT
#echo "output is: $output"
#echo "lines are: "; for l in "${lines[@]}"; do echo "$l"; done
#echo "status is: $status"
    [ "${lines[0]: -2}" = 'no' ]
    [ "$status" -eq 1 ]
}

@test "test of the 'iexec' alias in 'interactive' mode with response 'no'" {
    export INTERACTIVE=true
    run iexec "$PBL_EXEC" <<-USERINPUT
no
USERINPUT
#echo "output is: $output"
#echo "lines are: "; for l in "${lines[@]}"; do echo "$l"; done
#echo "status is: $status"
    [ "${lines[0]: -2}" = 'no' ]
    [ "$status" -eq 1 ]
}

@test "test of the 'interactive_exec' alias in 'debug' mode" {
    export DEBUG=true
    run interactive_exec "$PBL_EXEC" <<-USERINPUT
y
USERINPUT
#echo "output is: $output"
#echo "lines are: "; for l in "${lines[@]}"; do echo "$l"; done
#echo "status is: $status"
    [ "${lines[0]: -13}" = "\"echo 'test'\"" ]
    [ "${lines[1]}" = 'test' ]
    [ "$status" -eq 0 ]
}

@test "test of the 'interactive_exec' alias in 'debug' mode with second argument 'false'" {
    export DEBUG=true
    run interactive_exec "$PBL_EXEC" false <<-USERINPUT
y
USERINPUT
#echo "output is: $output"
#echo "lines are: "; for l in "${lines[@]}"; do echo "$l"; done
#echo "status is: $status"
    [ "${lines[0]}" = 'test' ]
    [ "$status" -eq 0 ]
}

# evaluate
@test "test of the 'evaluate' method in 'normal' mode" {
    evaluate "$PBL_EVAL"
#echo "output is: $output"
#echo "lines are: "; for l in "${lines[@]}"; do echo "$l"; done
#echo "status is: $status"
#echo "cmd out: $CMD_OUT"
#echo "cmd err: $CMD_ERR"
#echo "cmd status: $CMD_STATUS"
    [ "$CMD_OUT" = 'std out' ]
    [ "$CMD_ERR" = 'std err' ]
    [ "$CMD_STATUS" -eq 0 ]
}

