*&---------------------------------------------------------------------*
*& Report ZUK_EGT_013
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZUK_EGT_013.

DATA: gt_scarr TYPE TABLE OF scarr,
      gs_scarr TYPE scarr,
      gv_currcode TYPE s_currcode.
START-OF-SELECTION.

*SELECT * from scarr         " scarr tablosundaki CARRID stunu AC ye eşit olan satırın currcode stunundaki veriyi verir.
*      Into TABLE gt_scarr
*       WHERE CARRID EQ 'AC'.
*
*  READ TABLE gt_scarr INTO gs_scarr INDEX 1.
*
*  WRITE gs_scarr-currcode.

*
*SELECT SINGLE * FROM scarr
*  INTO gs_scarr
*  WHERE carrid EQ 'AC'.
*
*  WRITE: gs_scarr-currcode.

select SINGLE currcode FROM scarr
  INTO gv_currcode
  WHERE carrid EQ 'AC'.

  WRITE: gv_currcode.
