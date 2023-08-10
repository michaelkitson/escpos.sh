#!/usr/bin/env bats

bats_require_minimum_version 1.5.0

source "./src/utils.sh"

function setup() {
    load 'test_helper/common_setup'
    _common_setup
}

@test "escpos_chr" {
    run -0 _escpos_chr 65
    assert_output "A"
}

@test "escpos_chr with null" {
    run -0 _escpos_chr 0
    assert_output $'\0'
}
