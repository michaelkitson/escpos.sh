#!/usr/bin/env bats

bats_require_minimum_version 1.5.0

source "./src/utils.sh"
source "./src/print_position_commands.sh"

function setup() {
  load 'test_helper/common_setup'
  _common_setup
}

# TEST justify
