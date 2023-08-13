#!/usr/bin/env bats

bats_require_minimum_version 1.5.0

source "./src/utils.sh"
source "./src/print_position_commands.sh"
imports='source "./src/utils.sh"; source "./src/print_position_commands.sh"; '

function setup() {
  load 'test_helper/bats-support/load'
  load 'test_helper/bats-assert/load'
}

@test "test usage messages" {
  for fn in $(compgen -A function | grep "^escpos_"); do
    run -1 $fn -h
    assert_output -e "^Usage: $fn"
    run -1 $fn --help
    assert_output -e "^Usage: $fn"
  done
}

@test "test justify" {
  run -0 bash -c "$imports escpos_justify | xxd -i | tr -d '\n '"
  assert_output '0x1b,0x61,0x00'
  run -0 bash -c "$imports escpos_justify --left | xxd -i | tr -d '\n '"
  assert_output '0x1b,0x61,0x00'
  run -0 bash -c "$imports escpos_justify --center | xxd -i | tr -d '\n '"
  assert_output '0x1b,0x61,0x01'
  run -0 bash -c "$imports escpos_justify --right | xxd -i | tr -d '\n '"
  assert_output '0x1b,0x61,0x02'
}
