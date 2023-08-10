#!/usr/bin/env bats

bats_require_minimum_version 1.5.0

source "./src/utils.sh"
source "./src/miscellaneous_commands.sh"

function setup() {
  load 'test_helper/common_setup'
  _common_setup
}

@test "test reset" {
  run -0 escpos_reset
  assert_output $'\x1B@'
}
