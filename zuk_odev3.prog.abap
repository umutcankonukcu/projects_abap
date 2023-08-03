*&---------------------------------------------------------------------*
*& Report ZUK_ODEV3
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZUK_ODEV3.

INCLUDE zuk_odev3_top.
INCLUDE zuk_odev3_frm.


START-OF-SELECTION.




perform get_data.
PERFORM color.
PERFORM set_fc.
PERFORM layout.
PERFORM display_alv.
