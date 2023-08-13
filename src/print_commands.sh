#!/usr/bin/env bash

escpos_feed() {
  _escpos_usage "Usage: escpos_feed [--lines | --units] <num>
  --lines Use lines as the distance unit (default)
  --units Use vertical or horizontal motion units"  "$@" || return $?
  local mode="d"
  while [[ $# -gt 0 ]] && [[ $1 == -* ]]; do
    case "$1" in
    --lines) mode="d";;
    --units) mode="J";;
    --)
      shift # eat the -- before breaking away
      break;;
    *)
      printf "Usage error: unknown flag '%s'" "$1" >&2
      return 1;;
    esac
    shift
  done

  printf "%s" "${ESCPOS_ESC}${mode}"
  _escpos_chr "${1:-1}"
}
