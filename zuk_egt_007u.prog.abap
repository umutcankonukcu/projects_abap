*&---------------------------------------------------------------------*
*& Report ZUK_EGT_007
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZUK_EGT_007U.

DATA: go_egitim_class TYPE REF TO ZUK_EGITIM_CLASS.
DATA: gv_num1 TYPE int4,
      gv_num2 TYPE int4,
      gv_result TYPE int4.
START-OF-SELECTION.

CREATE OBJECT go_egitim_class.

gv_num1 = 12.
gv_num2 = 15.

go_egitim_class->sum_numbers(
  EXPORTING
    iv_num1   =  gv_num1                " Doğal sayı
    iv_num2   =  gv_num2                " Doğal sayı
  IMPORTING
    ev_result =  gv_result                " Doğal sayı
).

  WRITE: gv_result.

*  ZUK_EGITIM_CLASS=>sum_numbers_v2( ).
