#!/usr/bin/env bats

bats_require_minimum_version 1.5.0

source "./src/utils.sh"
source "./src/2d_commands.sh"
imports='source "./src/utils.sh"; source "./src/2d_commands.sh"; '

function setup() {
    load 'test_helper/common_setup'
    _common_setup
}

@test "test usage messages" {
  for fn in $(compgen -A function | grep "^escpos_"); do
    run -1 $fn -h
    assert_output -e "^Usage: $fn"
    run -1 $fn --help
    assert_output -e "^Usage: $fn"
  done
}

@test "test qr model" {
  run -0 bash -c "$imports escpos_qr_model | xxd -i | tr -d '\n '"
  assert_output '0x1d,0x28,0x6b,0x04,0x00,0x31,0x41,0x32,0x00'
  run -0 bash -c "$imports escpos_qr_model -1 | xxd -i | tr -d '\n '"
  assert_output '0x1d,0x28,0x6b,0x04,0x00,0x31,0x41,0x31,0x00'
  run -0 bash -c "$imports escpos_qr_model -2 | xxd -i | tr -d '\n '"
  assert_output '0x1d,0x28,0x6b,0x04,0x00,0x31,0x41,0x32,0x00'
  run -0 bash -c "$imports escpos_qr_model --micro | xxd -i | tr -d '\n '"
  assert_output '0x1d,0x28,0x6b,0x04,0x00,0x31,0x41,0x33,0x00'
}

@test "test qr size" {
  run -0 bash -c "$imports escpos_qr_size | xxd -i | tr -d '\n '"
  assert_output '0x1d,0x28,0x6b,0x03,0x00,0x31,0x43,0x03'
  run -0 bash -c "$imports escpos_qr_size 5 | xxd -i | tr -d '\n '"
  assert_output '0x1d,0x28,0x6b,0x03,0x00,0x31,0x43,0x05'
}

@test "test qr error correction" {
  run -0 bash -c "$imports escpos_qr_error_correction | xxd -i | tr -d '\n '"
  assert_output '0x1d,0x28,0x6b,0x03,0x00,0x31,0x45,0x30'
  run -0 bash -c "$imports escpos_qr_error_correction --low | xxd -i | tr -d '\n '"
  assert_output '0x1d,0x28,0x6b,0x03,0x00,0x31,0x45,0x30'
  run -0 bash -c "$imports escpos_qr_error_correction --medium | xxd -i | tr -d '\n '"
  assert_output '0x1d,0x28,0x6b,0x03,0x00,0x31,0x45,0x31'
  run -0 bash -c "$imports escpos_qr_error_correction --quartile | xxd -i | tr -d '\n '"
  assert_output '0x1d,0x28,0x6b,0x03,0x00,0x31,0x45,0x32'
  run -0 bash -c "$imports escpos_qr_error_correction --high | xxd -i | tr -d '\n '"
  assert_output '0x1d,0x28,0x6b,0x03,0x00,0x31,0x45,0x33'  
}

@test "test sending qr data" {
  run -0 bash -c "$imports escpos_qr_data 12345 | xxd -i | tr -d '\n '"
  assert_output '0x1d,0x28,0x6b,0x08,0x00,0x31,0x50,0x30,0x31,0x32,0x33,0x34,0x35'
}

@test "test printing qr data" {
  run -0 bash -c "$imports escpos_qr_print | xxd -i | tr -d '\n '"
  assert_output '0x1d,0x28,0x6b,0x03,0x00,0x31,0x51,0x30'
}
