#!/usr/bin/env bash

ESCPOS_ESC=$'\x1B'
ESCPOS_GS=$'\x1D'

_escpos_chr() {
  [ "$1" -lt 256 ] || return 1
  # shellcheck disable=SC2059
  printf "\\$(printf '%03o' "$1")"
}

_escpos_boolean() {
  local prefix="$1"
  shift
  local on=1
  while [[ $# -gt 0 ]] && [[ $1 == -* ]]; do
    case "$1" in
    --on)  on=1;;
    --off) on=0;;
    --)
      shift # eat the -- before breaking away
      break;;
    *)
      printf "Usage error: unknown flag '%s'" "$1" >&2
      return 1;;
    esac
    shift
  done

  printf "%s" "$prefix"
  _escpos_chr "$on"
}

_escpos_usage() {
  local help=0
  local msg="$1"
  shift
  while [[ $# -gt 0 ]] && [[ $1 == -* ]]; do
    case "$1" in
    -h)     help=1; break;;
    --help) help=1; break;;
    --)
      return 0;;
    *) ;;
    esac
    shift
  done

  if [ "$help" -eq 1 ]; then
    echo "$msg" 1>&2
    return 1
  fi
}
