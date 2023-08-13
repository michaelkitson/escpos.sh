#!/usr/bin/env bash

escpos_pdf417_columns() {
  _escpos_usage "Usage: escpos_pdf417_columns [--auto | <count (1-30)>]
  --auto Auto-select (default)" "$@" || return $?
  local value=0
  if [ $# -gt 0 ] && [ "$1" != "--auto" ]; then
    value="$1"
  fi
  printf "%s" "${ESCPOS_GS}(k"
  _escpos_2d_plph 0
  printf "%s" "0A"
  _escpos_chr "$value"
}

escpos_pdf417_rows() {
  _escpos_usage "Usage: escpos_pdf417_rows [--auto | <count (3-90)>]
  --auto Auto-select (default)" "$@" || return $?
  local value=0
  if [ $# -gt 0 ] && [ "$1" != "--auto" ]; then
    value="$1"
  fi
  printf "%s" "${ESCPOS_GS}(k"
  _escpos_2d_plph 0
  printf "%s" "0B"
  _escpos_chr "$value"
}

escpos_pdf417_width() {
  _escpos_usage "Usage: escpos_pdf417_width [<dots (2-8)>]" "$@" || return $?
  _escpos_2d_header 0 C "$(_escpos_chr "${1:-3}")" 0
}

escpos_pdf417_height() {
  _escpos_usage "Usage: escpos_pdf417_height [<scale (2-8)>]" "$@" || return $?
  _escpos_2d_header 0 D "$(_escpos_chr "${1:-3}")" 0
}

escpos_pdf417_error_correction() {
  _escpos_usage "Usage: escpos_pdf417_error_correction [--level <n (0-8)> | --ratio <n (1-40)>]
  --level Uses a fixed amount of error correction codewords.
  --ratio Uses a variable amount of error correction codewords that scales with the data size (default, at 10%)." "$@" || return $?
  local mode=1
  local value=1
  if [ $# -gt 0 ] && [ "$1" == "--level" ]; then
    mode=0
    value=$(( 48 + $2 ))
  elif [ $# -gt 0 ] && [ "$1" == "--ratio" ]; then
    value="$2"
  fi
  _escpos_2d_header 0 E $mode 1
  _escpos_chr "$value"
}

escpos_pdf417_options() {
  _escpos_usage "Usage: escpos_pdf417_options [--normal | --truncated]
  --normal    Standard PDF417 (default)
  --truncated Truncated PDF417" "$@" || return $?
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
