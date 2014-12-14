
### load the lib script
load tests_loader
load_library

### the test file path
PBL_HERE=$(pwd)

### utils methods tests

@test "test of the 'get_system_info' method [compatibility]" {
    run get_system_info
    [ "$output" != '' ]
    [ "$status" -eq 0 ]
}

@test "test of the 'get_machine_name' method [compatibility]" {
    run get_machine_name
    [ "$output" != '' ]
    [ "$status" -eq 0 ]
}

@test "test of the 'get_path' method" {
    run get_path
    count=$(grep -o ':' <<< "$output" | wc -l)
    [ "$count" = 0 ]
    [ "${#lines[@]}" -gt 1 ]
    [ "$status" -eq 0 ]
}

@test "test of the 'add_path' method" {
    flag1="$PATH"
    add_path "$PBL_HERE"
    flag2="$PATH"
    export PATH="$flag1"
    [ "$flag1" != "$flag2" ]
}

@test "test of the 'add_path' & 'get_path' methods" {
    flag1="$PATH"
    run get_path
    lines1="${#lines[@]}"
    add_path "$PBL_HERE"
    run get_path
    lines2="${#lines[@]}"
    export PATH="$flag1"
    [ "$lines1" -ne "$lines2" ]
}

@test "test of the 'get_ip' method" {
    get_ip
#echo "$USERIP"
#echo "$USERISP"
    [ -n "$USERIP" ]
    [ -n "$USERISP" ]
}
