#!/usr/bin/env bash

escpos_cut() {
  _escpos_usage "Usage: escpos_cut [--full | --partial] [<feed_distance_units>]
  --full    Full cut (default)
  --partial Partial cut (one point left uncut)" "$@" || return $?
  local mode=0
  local units=0
  while [[ $# -gt 0 ]] && [[ $1 == -* ]]; do
    case "$1" in
    --full) mode=0;;
    --partial) mode=1;;
    --)
      shift # eat the -- before breaking away
      break;;
    *)
      printf "Usage error: unknown flag '%s'" "$1" >&2
      return 1;;
    esac
    shift
  done

  if [ $# -gt 0 ]; then
    if [ $mode -eq 0 ]; then mode=A; else mode=B; fi
    units="$1"
  fi

  printf "%s" "${ESCPOS_GS}V${mode}"
  _escpos_chr "$units"
}
