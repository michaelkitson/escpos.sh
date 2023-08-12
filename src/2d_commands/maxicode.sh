#!/usr/bin/env bash

escpos_maxicode_mode() {
  _escpos_usage "Usage: escpos_maxicode_mode <number (2-6)>" "$@" || return $?
  local mode="${1:-2}"
  _escpos_2d_header 2 A "$mode" 0
}

escpos_maxicode_data() {
  _escpos_usage "Usage: escpos_maxicode_data <data>" "$@" || return $?
  _escpos_2d_header 2 P 0 ${#1}
  printf "%s" "$1"
}

escpos_maxicode_print() {
  _escpos_usage "Usage: escpos_maxicode_print" "$@" || return $?
  _escpos_2d_header 2 Q 0 0
}
