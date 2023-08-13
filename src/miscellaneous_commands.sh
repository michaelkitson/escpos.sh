#!/usr/bin/env bash

escpos_reset() {
  _escpos_usage "Usage: escpos_reset" "$@" || return $?
  printf "%s" "${ESCPOS_ESC}@"
}
