#!/usr/bin/env bash

ESCPOS_HELP="escpos.sh $ESCPOS_VERSION -- A Bash ESCPOS library
To get help with a specific command, run '<command> --help'

Simple Example:
(
  source ./escpos.sh
  escpos_reset
  escpos_justify --center
  escpos_text_size 2
  echo 'A centered line of text'
  ...
  escpos_cut
) > /dev/usb/lp0

Command List:
escpos_barcode -- Print a barcode.
escpos_barcode_height -- Set barcode height, in dots.
escpos_barcode_hri_font -- Set the font of a barcode's human readable interpretation.
escpos_barcode_hri_position -- Set the position of (or turn off) a barcode's human readable interpretation.
escpos_barcode_width -- Set barcode width, in printer specific units.
escpos_cut -- Execute a full or partial paper cut, and optionally feed paper forward by a number of units.
escpos_double_strike -- Toggle text double-strike mode.
escpos_emphasis -- Toggle bond text.
escpos_feed -- Feeds paper forward by a number of lines or units.
escpos_font -- Set text font.
escpos_graphics_store -- Store a PBM image into the print buffer. Specify a filename or pipe in a PBM bitmap image.
escpos_graphics_print -- Print the image stored in the print buffer.
escpos_justify -- Set text alignment.
escpos_line_spacing -- Set text line spacing, in units.
escpos_maxicode_data -- Send Maxicode data to store in printer memory.
escpos_maxicode_mode -- Select Maxicode mode to use to print the data (2-6).
escpos_maxicode_print -- Print the Maxicode data that is currently stored.
escpos_pdf417_columns -- Specify a specific number of columns in the data region or set to automatic processing.
escpos_pdf417_data -- Send PDF417 data to store in printer memory.
escpos_pdf417_error_correction -- Set the error correction level, by 'level' or 'ratio'.
escpos_pdf417_height -- Set PDF417 height, as a ratio of n-times the width.
escpos_pdf417_options -- Toggle the 'standard' or 'truncated' PDF417 variant.
escpos_pdf417_print -- Print the PDF417 data that is currently stored.
escpos_pdf417_rows -- Specify a specific number of rows in the data region or set to automatic processing.
escpos_pdf417_width -- Set PDF417 width, in dots.
escpos_qr_data -- Send QR data to store in printer memory.
escpos_qr_error_correction -- Set the error correction level for the QR Code.
escpos_qr_model -- Select the QR model to use to print the data (1, 2, or micro)
escpos_qr_print -- Print the QR data that is currently stored.
escpos_qr_size -- Set QR size, in dots.
escpos_reset -- Clear data in the print buffer and reset modes to their defaults.
escpos_reverse_colors -- Toggle inversed color for printed text (white text, black background).
escpos_smoothing -- Set text/font smoothing (ony applies at for text sizes >= 4).
escpos_text_size -- Set text/font size.
escpos_underline -- Toggle underlined text.
escpos_upside_down -- Toggle inverted text."

if [ $# -gt 0 ]; then
  if [ "$1" == "-v" ] || [ "$1"  == "--version" ]; then
    echo "escpos.sh $ESCPOS_VERSION"
    exit 1
  elif [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
    echo "$ESCPOS_HELP"
    exit 1
  fi
fi
