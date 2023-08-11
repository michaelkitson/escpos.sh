#!/usr/bin/env bash

escpos_qr_model() {
  _escpos_usage "Usage: escpos_qr_model [-1 | -2 | --micro]" "$@" || return $?
  local model=2
  case "${1:-}" in
  -1) model=1;;
  "") ;;
  -2) ;;
  --micro) model=3;;
  *)
    printf "Usage error: unknown flag '%s'" "$1" >&2
    return 1;;
  esac
  _escpos_2d_header 1 A $model 1
  _escpos_chr 0
}

escpos_qr_size() {
  _escpos_usage "Usage: escpos_qr_size <size (1-16)>" "$@" || return $?
  local size="${1:-3}"
  _escpos_2d_header 1 C "$(_escpos_chr "$size")" 0
}

escpos_qr_error_correction() {
  _escpos_usage "Usage: escpos_qr_error_correction [--low | --medium | --quartile | --high]" "$@" || return $?
  local level=0
  case "${1:-}" in
  "")    ;;
  --low) ;;
  --medium)   level=1;;
  --quartile) level=2;;
  --high)     level=3;;
  *)
    printf "Usage error: unknown flag '%s'" "$1" >&2
    return 1;;
  esac

  _escpos_2d_header 1 E $level 0
}

escpos_qr_data() {
  _escpos_usage "Usage: escpos_qr_data <data>" "$@" || return $?
  _escpos_2d_header 1 P 0 ${#1}
  printf "%s" "$1"
}

escpos_qr_print() {
  _escpos_usage "Usage: escpos_qr_print" "$@" || return $?
  _escpos_2d_header 1 Q 0 0
}

_escpos_2d_header() {
  local type=$1
  local fn=$2
  local m=$3
  local len=$4
  printf "%s" "${ESCPOS_GS}(k"
  _escpos_2d_plph "$len"
  printf "%s" "${type}${fn}${m}"
}

_escpos_2d_plph() {
  local p=$(($1 + 3))
  local ph=$((p / 256))
  local pl=$((p % 256))
  _escpos_chr $pl
  _escpos_chr $ph
}
