#!/usr/bin/env bats

bats_require_minimum_version 1.5.0

source "./src/utils.sh"
source "./src/print_commands.sh"

function setup() {
  load 'test_helper/common_setup'
  _common_setup
}

@test "test print and feed blank" {
  run -0 escpos_feed
  assert_output $'\x1Bd\x01'
}

@test "test print and feed blank with 4 units" {
  run -0 escpos_feed --units 4
  assert_output $'\x1BJ\x04'
}

@test "test print and feed blank with 4 lines (by default)" {
  run -0 escpos_feed 4
  assert_output $'\x1Bd\x04'
}

@test "test print and feed blank with 4 lines" {
  run -0 escpos_feed --lines 4
  assert_output $'\x1Bd\x04'
}
