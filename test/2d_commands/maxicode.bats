#!/usr/bin/env bats

bats_require_minimum_version 1.5.0

source "./src/utils.sh"
source "./src/2d_commands/maxicode.sh"
imports='source "./src/utils.sh"; source "./src/2d_commands/maxicode.sh"; '

function setup() {
  load '../test_helper/bats-support/load'
  load '../test_helper/bats-assert/load'
}

@test "test usage messages" {
  for fn in $(compgen -A function | grep "^escpos_"); do
    run -1 $fn -h
    assert_output -e "^Usage: $fn"
    run -1 $fn --help
    assert_output -e "^Usage: $fn"
  done
}

@test "test maxicode mode" {
  run -0 bash -c "$imports escpos_maxicode_mode | xxd -i | tr -d '\n '"
  assert_output '0x1d,0x28,0x6b,0x03,0x00,0x32,0x41,0x32'
  run -0 bash -c "$imports escpos_maxicode_mode 5 | xxd -i | tr -d '\n '"
  assert_output '0x1d,0x28,0x6b,0x03,0x00,0x32,0x41,0x35'
}

@test "test sending maxicode data" {
  run -0 bash -c "$imports escpos_maxicode_data 12345 | xxd -i | tr -d '\n '"
  assert_output '0x1d,0x28,0x6b,0x08,0x00,0x32,0x50,0x30,0x31,0x32,0x33,0x34,0x35'
}

@test "test printing maxicode data" {
  run -0 bash -c "$imports escpos_maxicode_print | xxd -i | tr -d '\n '"
  assert_output '0x1d,0x28,0x6b,0x03,0x00,0x32,0x51,0x30'
}
