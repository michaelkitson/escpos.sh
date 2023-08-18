#! /bin/bash

# Pipe stdout from this example into your printer

set -euo pipefail
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source "$SCRIPT_DIR/../escpos.sh"

escpos_reset
escpos_justify --center
magick "$SCRIPT_DIR/resources/bash.svg" -rotate 90 -resize 400 -ordered-dither o2x2 pbm:- | escpos_graphics_store
escpos_graphics_print
escpos_rotate
printf "%s" $'\x1bV\x01'
escpos_text_size 5
escpos_smoothing
escpos_feed --lines 2
echo "escpos.sh" | sed -E 's/(.)/\1\n/g'
escpos_feed --lines 2
escpos_cut 3
