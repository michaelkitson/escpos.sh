#!/usr/bin/env bats

bats_require_minimum_version 1.5.0

source "./src/utils.sh"
source "./src/character_commands.sh"
imports='source "./src/utils.sh"; source "./src/character_commands.sh"; '

function setup() {
  load 'test_helper/bats-support/load'
  load 'test_helper/bats-assert/load'
}

@test "test emphasis" {
  run -0 escpos_emphasis
  assert_output $'\x1BE\x01'
}

@test "test emphasis --on" {
  run -0 escpos_emphasis --on
  assert_output $'\x1BE\x01'
}

@test "test emphasis --off" {
  run -0 bash -c "$imports escpos_emphasis --off | xxd -i"
  assert_output '  0x1b, 0x45, 0x00'
}

@test "test underline" {
  run -0 escpos_underline
  assert_output $'\x1B-\x01'
}

@test "test underline --single" {
  run -0 escpos_underline --single
  assert_output $'\x1B-\x01'
}

@test "test underline --double" {
  run -0 escpos_underline --double
  assert_output $'\x1B-\x02'
}

@test "test underline --off" {
  run -0 bash -c "$imports escpos_underline --off | xxd -i"
  assert_output '  0x1b, 0x2d, 0x00'
}

@test "test reverse color" {
  run -0 escpos_reverse_colors
  assert_output $'\x1DB\x01'
}

@test "test reverse color --on" {
  run -0 escpos_reverse_colors --on
  assert_output $'\x1DB\x01'
}

@test "test reverse color --off" {
  run -0 bash -c "$imports escpos_reverse_colors --off | xxd -i"
  assert_output '  0x1d, 0x42, 0x00'
}

@test "test upside down" {
  run -0 escpos_upside_down
  assert_output $'\x1B{\x01'
}

@test "test upside down --on" {
  run -0 escpos_upside_down --on
  assert_output $'\x1B{\x01'
}

@test "test upside down --off" {
  run -0 bash -c "$imports escpos_upside_down --off | xxd -i"
  assert_output '  0x1b, 0x7b, 0x00'
}

@test "test double strike" {
  run -0 escpos_double_strike
  assert_output $'\x1BG\x01'
}

@test "test double strike --on" {
  run -0 escpos_double_strike --on
  assert_output $'\x1BG\x01'
}

@test "test double strike --off" {
  run -0 bash -c "$imports escpos_double_strike --off | xxd -i"
  assert_output '  0x1b, 0x47, 0x00'
}

@test "test smoothing" {
  run -0 escpos_smoothing
  assert_output $'\x1Db\x01'
}

@test "test smoothing --on" {
  run -0 escpos_smoothing --on
  assert_output $'\x1Db\x01'
}

@test "test smoothing --off" {
  run -0 bash -c "$imports escpos_smoothing --off | xxd -i"
  assert_output '  0x1d, 0x62, 0x00'
}

@test "test text size default" {
  run -0 bash -c "$imports escpos_text_size | xxd -i"
  assert_output '  0x1d, 0x21, 0x00'
}

@test "test text size with one value" {
  run -0 escpos_text_size 3
  assert_output $'\x1D!\x22'
}

@test "test text size with width and height" {
  run -0 escpos_text_size 2 4
  assert_output $'\x1D!\x13'
}

@test "test font default" {
  run -0 bash -c "$imports escpos_font | xxd -i"
  assert_output '  0x1b, 0x4d, 0x00'
}

@test "test font A" {
  run -0 bash -c "$imports escpos_font -a | xxd -i"
  assert_output '  0x1b, 0x4d, 0x00'
}

@test "test font B" {
  run -0 escpos_font -b
  assert_output $'\x1BM\x01'
}
