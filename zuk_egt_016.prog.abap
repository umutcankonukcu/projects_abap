*&---------------------------------------------------------------------*
*& Report ZUK_EGT_016
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZUK_EGT_016.

INCLUDE zuk_egt_016_top.
INCLUDE zuk_egt_016_cls.
INCLUDE zuk_egt_016_pbo.  " screenlerin açılmadan önceki modülleri topladığı yer
INCLUDE zuk_egt_016_pai.  " butonların olduğu yer
INCLUDE zuk_egt_016_frm.

START-OF-SELECTION.

    PERFORM get_data.
    PERFORM set_fcat.
    PERFORM set_layout.

CALL SCREEN 0100.
