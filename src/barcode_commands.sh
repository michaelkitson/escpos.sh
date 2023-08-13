#!/usr/bin/env bash

# GS H 
escpos_barcode_hri_position() {
  _escpos_usage "Usage: escpos_barcode_hri_position [--none | --above | --below | --both]
  --none  Turn off barcode HRI printing
  --above Print HRI above barcodes
  --below Print HRI below barcodes
  --both  Print HRI both above and below barcodes" "$@" || return $?
  local position=0
  case "${1:-}" in
  "") ;;
  --none) ;;
  --above) position=1;;
  --below) position=2;;
  --both)  position=3;;
  *)
    printf "Usage error: unknown flag '%s'" "$1" >&2
    return 1;;
  esac

  printf "%s" "${ESCPOS_GS}H${position}"
}

# GS f
escpos_barcode_hri_font() {
  _escpos_usage "Usage: escpos_barcode_hri_font [-a | -b | -c | -d | -e]
  -a Select font A (default)
  -b Select font B
  -c Select font C
  -d Select font D
  -e Select font E" "$@" || return $?
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

  printf "%s" "${ESCPOS_GS}f${font}"
}

# GS h
escpos_barcode_height() {
  _escpos_usage "Usage: escpos_barcode_height <height (1-255)>" "$@" || return $?
  local dots="${1:-162}"
  printf "%s" "${ESCPOS_GS}h"
  _escpos_chr "$dots"
}

# GS w
escpos_barcode_width() {
  _escpos_usage "Usage: escpos_barcode_width <height (2-6)>" "$@" || return $?
  local units="${1:-3}"
  printf "%s" "${ESCPOS_GS}w"
  _escpos_chr "$units"
}

# GS k
escpos_barcode() {
  _escpos_usage "Usage: escpos_barcode <TYPE_OPTION> <number/data>
  --UPC-A
  --UPC-E
  --JAN13
  --EAN13
  --JAN8
  --EAN8
  --CODE39
  --ITF
  --CODABAR
  --NW-7
  --CODE93
  --CODE128
  --GS1-128" "$@" || return $?
  local type="unspecified"
  while [[ $# -gt 0 ]] && [[ $1 == -* ]]; do
    case "$1" in
    --UPC-A)   type=A;;
    --UPC-E)   type=B;;
    --JAN13)   type=C;;
    --EAN13)   type=C;;
    --JAN8)    type=D;;
    --EAN8)    type=D;;
    --CODE39)  type=E;;
    --ITF)     type=F;;
    --CODABAR) type=G;;
    --NW-7)    type=G;;
    --CODE93)  type=H;;
    --CODE128) type=I;;
    --GS1-128) type=J;;
    --)
      shift # eat the -- before breaking away
      break;;
    *)
      printf "Usage error: unknown flag '%s'" "$1" >&2
      return 1;;
    esac
    shift
  done

  if [ "$type" == "unspecified" ] || [ $# -ne 1 ]; then
    printf "Usage: escpos_barcode --<TYPE> <NUMBER/DATA>"
    return 1
  fi

  printf "%s" "${ESCPOS_GS}k${type}"
  _escpos_chr "${#1}"
  printf "%s" "$1"
}
