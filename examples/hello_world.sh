#! /bin/bash

set -euo pipefail
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source "$SCRIPT_DIR/../escpos.sh"

(
  escpos_reset
  echo "Hello from bash"
  escpos_feed
  escpos_emphasis
  echo "This is bold"
  escpos_feed
  escpos_emphasis --off
  escpos_underline
  echo "Single underline"
  escpos_underline --double
  echo "Double underline"
  escpos_underline --off
  escpos_reverse_colors
  echo "Inversed"
  escpos_reverse_colors --off
  escpos_upside_down
  echo "Upside down"
  escpos_upside_down --off
  escpos_double_strike
  echo "Double strike"
  escpos_double_strike --off
  escpos_justify --center
  echo "Center"
  escpos_justify --right
  echo "Right"
  escpos_justify
  escpos_text_size 5
  echo "Size 5"
  escpos_smoothing
  echo "Size 5 smoothed"
  escpos_smoothing --off
  escpos_text_size
  escpos_font -b
  echo "Font B"
  escpos_font
  echo "Normal"
  escpos_cut 3
) |
nc 192.168.1.10 9100
# hexdump -C
