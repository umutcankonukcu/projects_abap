*&---------------------------------------------------------------------*
*& Report ZUK_ODEV4
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zuk_odev4.

INCLUDE zuk_odev4_top.
INCLUDE zuk_odev4_pbo.
INCLUDE zuk_odev4_pai.
INCLUDE zuk_odev4_frm.

AT SELECTION-SCREEN.
  PERFORM tablo.

START-OF-SELECTION.
  PERFORM get_data.
  PERFORM set_fcat.
  PERFORM set_layout.
  PERFORM set_fcat2.
  PERFORM display_alv.
