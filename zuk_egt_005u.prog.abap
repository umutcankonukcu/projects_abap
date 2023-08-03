*&---------------------------------------------------------------------*
*& Report ZUK_EGT_005
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zuk_egt_005u.
**** g global , l local   gv_num1 , lv_num1

*PARAMETERS: p_num TYPE int4.
*INITIALIZATION.
*p_num = 12.
*AT SELECTION-SCREEN.
* p_num = p_num + 2.
*START-OF-SELECTION.
*  WRITE 'START-OF-SELECTİON'.
*END-OF-SELECTION.
*  WRITE 'END-OF-SELECTİON'.


**DATA: gv_num1 TYPE int4,
**      gv_num2 TYPE int4,
**      gv_num3 TYPE int4.
**
**INITIALIZATION.
**
**AT SELECTION-SCREEN.
**
**START-OF-SELECTION.
**  PERFORM sayiya_bir_ekle.
**  PERFORM sayiya_bir_ekle.
**  PERFORM sayiya_bir_ekle.
**  PERFORM sayiya_bir_ekle.
**  PERFORM sayiya_bir_ekle.
**  PERFORM sayiya_bir_ekle.
**  PERFORM sayiya_bir_ekle.
**
**  WRITE gv_num1.
**  PERFORM iki_sayinin_carpimi USING 10
**                                    5.
**  gv_num2 = 15.
**  gv_num3 = 6.
**  PERFORM iki_sayinin_farki USING gv_num2
**                                  gv_num3.
**END-OF-SELECTION.
**FORM sayiya_bir_ekle.
**  gv_num1 = gv_num1 + 1.
**ENDFORM.
**
**FORM iki_sayinin_carpimi USING p_num1
**                               p_num2.
**  DATA: lv_sonuc TYPE int4.
**  lv_sonuc = p_num1 * p_num2.
**  WRITE: 'Sonuç' , lv_sonuc.
**ENDFORM.
***&---------------------------------------------------------------------*
***& Form IKI_SAYININ_FARKI
***&---------------------------------------------------------------------*
***& text
***&---------------------------------------------------------------------*
***&      --> GV_NUM2
***&      --> GV_NUM3
***&---------------------------------------------------------------------*
**FORM iki_sayinin_farki  USING    p_num2
**                                 p_num3.
**  DATA: lv_sonuc TYPE int4.
**  lv_sonuc = p_num2 - p_num3.
**  WRITE: 'Farkı = ',lv_sonuc.
**ENDFORM.

INCLUDE ZUK_EGT_005U_TOP.
*INCLUDE zuk_egt_005_top.
INCLUDE ZUK_EGT_005U_FRM.
*INCLUDE ZUK_EGT_005_frm.
*zuk_egt_005_top dosyasının içinde gv_num1 değişkenini tuttum ve include ile bağladım

START-OF-SELECTION.

  PERFORM form1.
  PERFORM form2.
