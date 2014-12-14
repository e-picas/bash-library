
### load the lib script
load tests_loader
load_library

### test of the aliasing method
PBL_TESTFCT () {
    local i=0
    for var in "$@"
    do
        ((i++))
        echo "${i} : ${var}"
    done
    return "${i}"
}
PBL_TESTALIAS () {
#    PBL_TESTFCT "$*" # this DOES NOT work !
    PBL_TESTFCT $*
    return "$?"
}
PBL_TESTOUTPUT=$(cat <<EOF
1 : arg1
2 : arg2
3 : arg3
4 : 4
EOF
);

### strings methods tests

@test "test of simple function" {
    run PBL_TESTFCT 'arg1' 'arg2' 'arg3' 4
#echo "$output"
#echo "$status"
    [ "$output" = "$PBL_TESTOUTPUT" ]
    [ "$status" = '4' ]
}

@test "test of custom aliasing" {
    run PBL_TESTALIAS 'arg1' 'arg2' 'arg3' 4
#echo "$output"
#echo "$status"
    [ "$output" = "$PBL_TESTOUTPUT" ]
    [ "$status" = '4' ]
}
