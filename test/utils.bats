#!/usr/bin/env bats

bats_require_minimum_version 1.5.0

source "./src/utils.sh"

function setup() {
  load 'test_helper/bats-support/load'
  load 'test_helper/bats-assert/load'
}

@test "_escpos_chr" {
  run -0 _escpos_chr 65
  assert_output "A"
}

@test "_escpos_chr with null" {
  run -0 bash -c "source './src/utils.sh'; _escpos_chr 0 | xxd -i | tr -d '\n '"
  assert_output "0x00"
}

@test "_escpos_chr with multiple args" {
  run -0 _escpos_chr 1 2 3
  assert_output $'\x01\x02\x03'
  run -0 bash -c "source './src/utils.sh'; _escpos_chr 0 0 0 | xxd -i | tr -d '\n '"
  assert_output "0x00,0x00,0x00"
}

@test "_escpos_uint16 with null" {
  run -0 bash -c "source './src/utils.sh'; _escpos_uint16 0 | xxd -i | tr -d '\n '"
  assert_output "0x00,0x00"
  run -0 bash -c "source './src/utils.sh'; _escpos_uint16 4 | xxd -i | tr -d '\n '"
  assert_output "0x04,0x00"
  run -0 bash -c "source './src/utils.sh'; _escpos_uint16 512 | xxd -i | tr -d '\n '"
  assert_output "0x00,0x02"
  run -0 bash -c "source './src/utils.sh'; _escpos_uint16 65535 | xxd -i | tr -d '\n '"
  assert_output "0xff,0xff"
}
