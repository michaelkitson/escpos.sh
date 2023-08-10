#!/usr/bin/env bash

escpos_line_spacing() {
  if [ $# -eq 0 ] || [ "$1" == "--default" ] ; then
    printf "%s" "${ESCPOS_ESC}2"
  else
    printf "%s" "${ESCPOS_ESC}3"
    _escpos_chr "$1"
  fi
}
