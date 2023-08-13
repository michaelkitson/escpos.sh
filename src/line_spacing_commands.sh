#!/usr/bin/env bash

escpos_line_spacing() {
  _escpos_usage "Usage: escpos_line_spacing [--default | <units (0-255)>]
  --default Reset to default line spacing (default)" "$@" || return $?
  if [ $# -eq 0 ] || [ "$1" == "--default" ] ; then
    printf "%s" "${ESCPOS_ESC}2"
  else
    printf "%s" "${ESCPOS_ESC}3"
    _escpos_chr "$1"
  fi
}
