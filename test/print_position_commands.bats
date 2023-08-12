#!/usr/bin/env bats

bats_require_minimum_version 1.5.0

source "./src/utils.sh"
source "./src/print_position_commands.sh"

function setup() {
  load 'test_helper/bats-support/load'
  load 'test_helper/bats-assert/load'
}

# TEST justify
