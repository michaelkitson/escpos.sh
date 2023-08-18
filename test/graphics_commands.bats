#!/usr/bin/env bats

bats_require_minimum_version 1.5.0

source "./src/utils.sh"
source "./src/graphics_commands.sh"
imports='source "./src/utils.sh"; source "./src/graphics_commands.sh"; '

function setup() {
  load 'test_helper/bats-support/load'
  load 'test_helper/bats-assert/load'
}

@test "test usage messages" {
  for fn in $(compgen -A function | grep "^escpos_"); do
    run -1 "$fn" -h
    assert_output -e "^Usage: $fn"
    run -1 "$fn" --help
    assert_output -e "^Usage: $fn"
  done
}

@test "test escpos_graphics_store with a pipe" {
  local fake_image=$'P4\n#Created with The GIMP\n\n303 325\ndata'
  run bash -c "$imports printf '%s' '$fake_image' | escpos_graphics_store | xxd -p"
  assert_output '1d284c0e003070300101312f01450164617461'
}

@test "test escpos_graphics_store with a file" {
  local filename
  filename="$(mktemp)"
  printf "%s" $'P4\n#Created with The GIMP\n\n303 325\ndata' > "$filename"
  run bash -c "$imports escpos_graphics_store '$filename' | xxd -p"
  assert_output '1d284c0e003070300101312f01450164617461'
  rm "$filename"
}

@test "test escpos_graphics_print" {
  run -0 escpos_graphics_print
  run -0 bash -c "$imports escpos_graphics_print | xxd -p"
  assert_output '1d284c02003032'
}

@test "test _escpos_isspace" {
  run -0 _escpos_isspace " "
  run -0 _escpos_isspace $'\n'
  run -0 _escpos_isspace $'\t'
  run -0 _escpos_isspace $'\v'
  run -0 _escpos_isspace $'\f'
  run -0 _escpos_isspace $'\r'
  run -1 _escpos_isspace "a"
  run -1 _escpos_isspace ""
}

@test "test _escpos_p4_parse with a bad image" {
  run -1 _escpos_p4_parse $'P1\n\n303 325\ndata'
  assert_output "Usage error: escpos_image requires a P4 PBM image"
}

@test "test _escpos_p4_parse with a simple image" {
  run -0 _escpos_p4_parse $'P4 303 325\ndata'
  assert_output $'303\n325\n11'
}

@test "test _escpos_p4_parse with a comment" {
  run -0 _escpos_p4_parse $'P4\n#Created with The GIMP\n\n303 325\ndata'
  assert_output $'303\n325\n35'
}
