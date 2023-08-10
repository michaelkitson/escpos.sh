#!/usr/bin/env bats

bats_require_minimum_version 1.5.0

source "./src/utils.sh"
source "./src/line_spacing_commands.sh"

function setup() {
  load 'test_helper/common_setup'
  _common_setup
}

@test "test line spacing empty" {
  run -0 escpos_line_spacing
  assert_output $'\x1B2'
}

@test "test line spacing default" {
  run -0 escpos_line_spacing --default
  assert_output $'\x1B2'
}

@test "test line spacing 3" {
  run -0 escpos_line_spacing 3
  assert_output $'\x1B3\x03'
}
