#!/usr/bin/env bash

escpos_justify() {
  local mode=0
    # parse options starting with -
  while [[ $# -gt 0 ]] && [[ $1 == -* ]]; do
    case "$1" in
    --left)   mode=0;;
    --center) mode=1;;
    --right)  mode=2;;
    --)
      shift # eat the -- before breaking away
      break;;
    *)
      printf "Usage error: unknown flag '%s'" "$1" >&2
      return 1;;
    esac
    shift
  done

  printf "%s" "${ESCPOS_ESC}a"
  _escpos_chr "$mode"
}
