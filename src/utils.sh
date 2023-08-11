#!/usr/bin/env bash

ESCPOS_VERSION="0.1.0"
ESCPOS_ESC=$'\x1B'
ESCPOS_GS=$'\x1D'

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
      printf "Usage error: unknown flag '%s'\n" "$1" >&2
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

_escpos_help() {
  for fn in $(compgen -A function | grep "^escpos_"); do
    $fn -h
  done
}
