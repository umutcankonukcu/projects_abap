*&---------------------------------------------------------------------*
*& Report ZUK_EGT_006
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zuk_egt_006u.

DATA: gv_num1  TYPE int4,
      gv_num2  TYPE int4,
      gv_sonuc TYPE int4,
      gv_mes   TYPE char20.

START-OF-SELECTION.

  gv_num1 = 20.
  gv_num2 = 5.
  gv_mes = 'Mesaj1'.

  CALL FUNCTION 'ZUK_EGITIM_FONKSIYONLARI'
    EXPORTING
      iv_num1         = gv_num1
      iv_num2         = gv_num2
    IMPORTING
      ev_sonuc        = gv_sonuc
    CHANGING
      cv_mes          = gv_mes
    EXCEPTIONS
      divided_by_zero = 1
      OTHERS          = 2.
  IF sy-subrc EQ 0.
* Implement suitable error handling here
    WRITE: / 'Sonuç: ' , gv_sonuc.
    WRITE: / 'Mesaj: ' , gv_mes.
  ELSEIF sy-subrc EQ 1.
    WRITE: / '0 a bölemezsiniz. '.
  ENDIF.
