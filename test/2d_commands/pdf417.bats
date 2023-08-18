#!/usr/bin/env bats

bats_require_minimum_version 1.5.0

source "./src/utils.sh"
source "./src/2d_commands/pdf417.sh"
imports='source "./src/utils.sh"; source "./src/2d_commands/pdf417.sh"; '

function setup() {
  load '../test_helper/bats-support/load'
  load '../test_helper/bats-assert/load'
}

@test "test usage messages" {
  for fn in $(compgen -A function | grep "^escpos_"); do
    run -1 "$fn" -h
    assert_output -e "^Usage: $fn"
    run -1 "$fn" --help
    assert_output -e "^Usage: $fn"
  done
}

@test "test pdf417 columns" {
  run -0 bash -c "$imports escpos_pdf417_columns | xxd -i | tr -d '\n '"
  assert_output '0x1d,0x28,0x6b,0x03,0x00,0x30,0x41,0x00'
  run -0 bash -c "$imports escpos_pdf417_columns --auto | xxd -i | tr -d '\n '"
  assert_output '0x1d,0x28,0x6b,0x03,0x00,0x30,0x41,0x00'
  run -0 bash -c "$imports escpos_pdf417_columns 5 | xxd -i | tr -d '\n '"
  assert_output '0x1d,0x28,0x6b,0x03,0x00,0x30,0x41,0x05'
}

@test "test pdf417 rows" {
  run -0 bash -c "$imports escpos_pdf417_rows | xxd -i | tr -d '\n '"
  assert_output '0x1d,0x28,0x6b,0x03,0x00,0x30,0x42,0x00'
  run -0 bash -c "$imports escpos_pdf417_rows --auto | xxd -i | tr -d '\n '"
  assert_output '0x1d,0x28,0x6b,0x03,0x00,0x30,0x42,0x00'
  run -0 bash -c "$imports escpos_pdf417_rows 5 | xxd -i | tr -d '\n '"
  assert_output '0x1d,0x28,0x6b,0x03,0x00,0x30,0x42,0x05'
}

@test "test pdf417 width" {
  run -0 bash -c "$imports escpos_pdf417_width | xxd -i | tr -d '\n '"
  assert_output '0x1d,0x28,0x6b,0x03,0x00,0x30,0x43,0x03'
  run -0 bash -c "$imports escpos_pdf417_width 5 | xxd -i | tr -d '\n '"
  assert_output '0x1d,0x28,0x6b,0x03,0x00,0x30,0x43,0x05'
}

@test "test pdf417 height" {
  run -0 bash -c "$imports escpos_pdf417_height | xxd -i | tr -d '\n '"
  assert_output '0x1d,0x28,0x6b,0x03,0x00,0x30,0x44,0x03'
  run -0 bash -c "$imports escpos_pdf417_height 5 | xxd -i | tr -d '\n '"
  assert_output '0x1d,0x28,0x6b,0x03,0x00,0x30,0x44,0x05'
}

@test "test pdf417 error correction" {
  run -0 bash -c "$imports escpos_pdf417_error_correction | xxd -i | tr -d '\n '"
  assert_output '0x1d,0x28,0x6b,0x04,0x00,0x30,0x45,0x31,0x01'
  run -0 bash -c "$imports escpos_pdf417_error_correction --ratio 1 | xxd -i | tr -d '\n '"
  assert_output '0x1d,0x28,0x6b,0x04,0x00,0x30,0x45,0x31,0x01'
  run -0 bash -c "$imports escpos_pdf417_error_correction --ratio 5 | xxd -i | tr -d '\n '"
  assert_output '0x1d,0x28,0x6b,0x04,0x00,0x30,0x45,0x31,0x05'
  run -0 bash -c "$imports escpos_pdf417_error_correction --level 0 | xxd -i | tr -d '\n '"
  assert_output '0x1d,0x28,0x6b,0x04,0x00,0x30,0x45,0x30,0x30'
  run -0 bash -c "$imports escpos_pdf417_error_correction --level 5 | xxd -i | tr -d '\n '"
  assert_output '0x1d,0x28,0x6b,0x04,0x00,0x30,0x45,0x30,0x35'
}

@test "test pdf417 options" {
  run -0 bash -c "$imports escpos_pdf417_options | xxd -i | tr -d '\n '"
  assert_output '0x1d,0x28,0x6b,0x03,0x00,0x30,0x46,0x00'
  run -0 bash -c "$imports escpos_pdf417_options --normal | xxd -i | tr -d '\n '"
  assert_output '0x1d,0x28,0x6b,0x03,0x00,0x30,0x46,0x00'
  run -0 bash -c "$imports escpos_pdf417_options --truncated | xxd -i | tr -d '\n '"
  assert_output '0x1d,0x28,0x6b,0x03,0x00,0x30,0x46,0x01'
}

@test "test sending pdf417 data" {
  run -0 bash -c "$imports escpos_pdf417_data 12345 | xxd -i | tr -d '\n '"
  assert_output '0x1d,0x28,0x6b,0x08,0x00,0x30,0x50,0x30,0x31,0x32,0x33,0x34,0x35'
}

@test "test printing pdf417 data" {
  run -0 bash -c "$imports escpos_pdf417_print | xxd -i | tr -d '\n '"
  assert_output '0x1d,0x28,0x6b,0x03,0x00,0x30,0x51,0x30'
}
