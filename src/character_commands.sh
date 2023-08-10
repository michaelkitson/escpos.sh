#!/usr/bin/env bash

# CAN
# ESC SP
# ESC !
# ESC -
escpos_underline() {
  local underlines=1
    # parse options starting with -
  while [[ $# -gt 0 ]] && [[ $1 == -* ]]; do
    case "$1" in
    --off)    underlines=0;;
    --single) underlines=1;;
    --double) underlines=2;;
    --)
      shift # eat the -- before breaking away
      break;;
    *)
      printf "Usage error: unknown flag '%s'" "$1" >&2
      return 1;;
    esac
    shift
  done

  printf "%s" "${ESCPOS_ESC}-"
  _escpos_chr "$underlines"
}

# ESC E
escpos_emphasis() {
  _escpos_boolean "${ESCPOS_ESC}E" "$@"
}

# ESC G
escpos_double_strike() {
  _escpos_boolean "${ESCPOS_ESC}G" "$@"
}

# ESC M
escpos_font() {
  local font=0
  case "${1:-}" in
  "") ;;
  -a) ;;
  -b) font=1;;
  -c) font=2;;
  -d) font=3;;
  -e) font=4;;
  *)
    printf "Usage error: unknown flag '%s'" "$1" >&2
    return 1;;
  esac

  printf "%s" "${ESCPOS_ESC}M"
  _escpos_chr "$font"
}
# ESC R
# ESC V
# ESC r
# ESC t
# ESC {
escpos_upside_down() {
  _escpos_boolean "${ESCPOS_ESC}{" "$@"
}

# GS !
escpos_text_size() {
  local w=0
  local h=0
  if [ $# -eq 1 ]; then
    w=$(($1 - 1))
    h=$w
  elif [ $# -gt 1 ]; then
    w=$(($1 - 1))
    h=$(($2 - 1))
  fi
  local value=$((16 * w + h))
  printf "%s" "${ESCPOS_GS}!"
  _escpos_chr "$value"
}

# GS B
escpos_reverse_colors() {
  _escpos_boolean "${ESCPOS_GS}B" "$@"
}

# GS b
escpos_smoothing() {
  _escpos_boolean "${ESCPOS_GS}b" "$@"
}
