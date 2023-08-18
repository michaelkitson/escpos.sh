#!/usr/bin/env bats

bats_require_minimum_version 1.5.0

source "./src/utils.sh"
source "./src/miscellaneous_commands.sh"

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

@test "test reset" {
  run -0 escpos_reset
  assert_output $'\x1B@'
}
