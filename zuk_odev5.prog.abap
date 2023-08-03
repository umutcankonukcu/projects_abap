*&---------------------------------------------------------------------*
*& Report ZUK_ODEV5
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zuk_odev5.
""""assign component of structure yapısı
INCLUDE zuk_odev5_top_data.
INCLUDE zuk_odev5_form.
INCLUDE zuk_odev5_pbo.
INCLUDE zuk_odev5_pai.

START-OF-SELECTION.
  PERFORM get_data.
  PERFORM set_fcat.
  PERFORM set_layout.

  CALL SCREEN 0100.
