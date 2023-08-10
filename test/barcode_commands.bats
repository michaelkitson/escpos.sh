#!/usr/bin/env bats

bats_require_minimum_version 1.5.0

source "./src/utils.sh"
source "./src/barcode_commands.sh"

function setup() {
    load 'test_helper/common_setup'
    _common_setup
}

@test "test barcode HRI position" {
  run -0 escpos_barcode_hri_position
  assert_output $'\x1DH0'
  run -0 escpos_barcode_hri_position --none
  assert_output $'\x1DH0'
  run -0 escpos_barcode_hri_position --above
  assert_output $'\x1DH1'
  run -0 escpos_barcode_hri_position --below
  assert_output $'\x1DH2'
  run -0 escpos_barcode_hri_position --both
  assert_output $'\x1DH3'
}

@test "test barcode HRI font" {
  run -0 escpos_barcode_hri_font
  assert_output $'\x1Df0'
  run -0 escpos_barcode_hri_font -a
  assert_output $'\x1Df0'
  run -0 escpos_barcode_hri_font -b
  assert_output $'\x1Df1'
  run -0 escpos_barcode_hri_font -c
  assert_output $'\x1Df2'
  run -0 escpos_barcode_hri_font -d
  assert_output $'\x1Df3'
  run -0 escpos_barcode_hri_font -e
  assert_output $'\x1Df4'
}

@test "test barcode height" {
  run -0 escpos_barcode_height
  assert_output $'\x1Dh\xA2'
  run -0 escpos_barcode_height 31
  assert_output $'\x1Dh\x1F'
}

@test "test barcode width" {
  run -0 escpos_barcode_width
  assert_output $'\x1Dw\x03'
  run -0 escpos_barcode_width 6
  assert_output $'\x1Dw\x06'
}

@test "test barcodes" {
  run -1 escpos_barcode 12345678901
  run -1 escpos_barcode --UPC-A
  run -0 escpos_barcode --UPC-A 12345678901
  assert_output $'\x1DkA\x0B12345678901'
  run -0 escpos_barcode --JAN8 1234567
  assert_output $'\x1DkD\x071234567'
}