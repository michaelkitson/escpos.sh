#!/usr/bin/env bash

set -euo pipefail
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source "$SCRIPT_DIR/../escpos.sh"

# Example from https://www.epson-biz.com/modules/ref_escpos/index.php?content_id=269
(
  escpos_reset
  escpos_line_spacing 18
  escpos_justify --center
  escpos_text_size 2
  echo $'\xC9\xCD\xCD\xCD\xCD\xCD\xCD\xCD\xCD\xCD\xCD\xCD\xBB'
  echo $'\xBA   EPSON   \xBA'
  echo -n $'\xBA   '
  escpos_text_size 1
  echo -n 'Thank you '
  escpos_text_size 2
  echo $'   \xBA'
  echo $'\xC8\xCD\xCD\xCD\xCD\xCD\xCD\xCD\xCD\xCD\xCD\xCD\xBC'
  escpos_line_spacing

  escpos_text_size 1
  escpos_feed --units 4
  echo -n "NOVEMBER 1, 2012  10:30"
  escpos_feed --lines 3

  escpos_justify
  echo "TM-Uxxx                            6.75"
  echo "TM-Hxxx                            6.00"
  echo "PS-xxx                             1.70"
  echo

  escpos_text_size 1 2
  echo "TOTAL                             14.45"
  escpos_text_size
  echo "---------------------------------------"
  echo "PAID                              50.00"
  echo "CHANGE                            35.55"

  escpos_cut --partial 0
) | nc 192.168.1.10 9100
