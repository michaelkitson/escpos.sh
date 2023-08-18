#!/usr/bin/env bash

escpos_graphics_store() {
  _escpos_usage "Usage: escpos_graphics_store [file]" "$@" || return $?
  local image_data image_header file_size parse_result
  image_data="$(base64 -i "${1:--}")" # Base64 the data because bash variables can't hold null bytes.
  image_header="$(base64 -d <<< "$image_data")" # But assume the header won't have any nulls.
  file_size="$(base64 -d <<< "$image_data" | wc -c)"
  read -d '' -ra parse_result < <(_escpos_p4_parse "$image_header") || true
  local image_width="${parse_result[0]}" image_height="${parse_result[1]}" image_bytes="$((file_size - parse_result[2]))"

  local m="0" fn="p" a="0" c="1"
  printf "%s" "${ESCPOS_GS}(L"
  _escpos_uint16 $((image_bytes + 10))
  printf "%s" "${m}${fn}${a}"
  _escpos_chr 1 1 # bx by
  printf "%s" "${c}"
  _escpos_uint16 "$image_width"
  _escpos_uint16 "$image_height"
  base64 -d <<< "$image_data" | tail --bytes="$image_bytes"
}

escpos_graphics_print() {
  _escpos_usage "Usage: escpos_graphics_print" "$@" || return $?
  printf "%s" "${ESCPOS_GS}(L"
  _escpos_uint16 2
  printf "%s" "02"
}

# Given a data string as the sole argument, outputs "<width>\n<height>\n<data_offset>\n"
_escpos_p4_parse() {
  local header="$1"
  if [[ "${1:0:2}" != P4 ]]; then
    echo "Usage error: escpos_image requires a P4 PBM image" >&2
    exit 1
  fi

  local i=2 field="" fields=0
  while [ $i -lt ${#header} ] && [ $fields -lt 2 ]
  do
    # At start of line/field.
    # if it is a comment, discard until newline.
    if [ "${header:i:1}" == "#" ]; then
      while [ $i -lt ${#header} ] && [ "${header:i:1}" != $'\n' ]; do
        ((i++))
      done
      continue
    fi
    # otherwise read into field until WS, then handle field.
    while [ "$i" -lt ${#header} ] && ! _escpos_isspace "${header:i:1}"; do
      field+="${header:i:1}"
      ((i++))
    done

    if [ -n "$field" ]; then
      printf "%s\n" "$field"
      field=""
      ((fields++))
    fi
    ((i++))
  done
  printf "%s\n" "$i"
  return 0
}

_escpos_isspace() {
  [[ -n $1 ]] && [[ $'\t\n\v\f\r ' == *$1* ]]
}
