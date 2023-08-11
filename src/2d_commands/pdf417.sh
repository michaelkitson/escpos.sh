#!/usr/bin/env bash

escpos_pdf417_options() {
  _escpos_usage "Usage: escpos_pdf417_options [--normal | --truncated]" "$@" || return $?
  local value=0
  case "${1:-}" in
  "") ;;
  --normal) ;;
  --truncated) value=1;;
  *)
    printf "Usage error: unknown flag '%s'\n" "$1" >&2
    return 1;;
  esac

  printf "%s" "${ESCPOS_GS}(k"
  _escpos_2d_plph 0
  printf "%s" "0F"
  _escpos_chr $value
}

escpos_pdf417_data() {
  _escpos_usage "Usage: escpos_pdf417_data <data>" "$@" || return $?
  _escpos_2d_header 0 P 0 ${#1}
  printf "%s" "$1"
}

escpos_pdf417_print() {
  _escpos_usage "Usage: escpos_pdf417_print" "$@" || return $?
  _escpos_2d_header 0 Q 0 0
}
