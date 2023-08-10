#!/usr/bin/env bats

bats_require_minimum_version 1.5.0

source "./src/utils.sh"
source "./src/mechanism_control_commands.sh"

function setup() {
  load 'test_helper/common_setup'
  _common_setup
}

@test "test cut partial" {
  run -0 escpos_cut --partial
  assert_output $'\x1DV1'
}

@test "test cut full" {
  run -0 escpos_cut --full
  assert_output $'\x1DV0'
}

@test "test cut default" {
  run -0 escpos_cut
  assert_output $'\x1DV0'
}

@test "test feed and cut partial" {
  run -0 escpos_cut --partial 3
  assert_output $'\x1DVB\x03'
}

@test "test feed and cut full" {
  run -0 escpos_cut --full 3
  assert_output $'\x1DVA\x03'
}

@test "test feed and cut default" {
  run -0 escpos_cut 3
  assert_output $'\x1DVA\x03'
}
