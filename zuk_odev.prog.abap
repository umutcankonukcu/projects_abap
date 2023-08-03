*&---------------------------------------------------------------------*
*& Report ZUK_ODEV1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zuk_odev.



SELECTION-SCREEN BEGIN OF BLOCK b4 WITH FRAME.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME.

PARAMETERS : p_check1 AS CHECKBOX DEFAULT abap_false USER-COMMAND usr1,
             p_check2 AS CHECKBOX DEFAULT abap_false USER-COMMAND usr2,
             p_check3 AS CHECKBOX DEFAULT abap_false USER-COMMAND usr3.



SELECTION-SCREEN END OF BLOCK b1.





SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME.

PARAMETERS : p_rad1 RADIOBUTTON GROUP rd1,
             p_rad2 RADIOBUTTON GROUP rd1.



SELECTION-SCREEN END OF BLOCK b2.

SELECTION-SCREEN BEGIN OF BLOCK b3 WITH FRAME.

PARAMETERS: p_kenar  TYPE i MODIF ID gr1,
            p_kkenar TYPE i MODIF ID gr2,
            p_ukenar TYPE i MODIF ID gr3,
            p_kenar1 TYPE i MODIF ID gr4,
            p_kenar2 TYPE i MODIF ID gr5,
            p_kenar3 TYPE i MODIF ID gr6.
SELECTION-SCREEN END OF BLOCK b3.
SELECTION-SCREEN END OF BLOCK b4.
DATA: kare_alan TYPE int4,
      kare_cevre TYPE int4,
      dkdrt_alan TYPE int4,
      dkdrt_cevre TYPE int4,
      ucgen_alan TYPE p DECIMALS 2,
      ucgen_cevre TYPE p DECIMALS 2,
      ucgen_u TYPE int4,
      u_sonuc TYPE p DECIMALS 2.





INITIALIZATION.


AT SELECTION-SCREEN OUTPUT.
  LOOP AT SCREEN.
    IF p_check1 EQ abap_true.
      p_check2 = abap_false.
      p_check3 = abap_false.
      IF screen-group1 EQ 'GR1'.
        screen-active = 1.
        MODIFY SCREEN.
      ENDIF.
      IF screen-group1 EQ 'GR2'.
        screen-active = 0.
        MODIFY SCREEN.
      ENDIF.
      IF screen-group1 EQ 'GR3'.
        screen-active = 0.
        MODIFY SCREEN.
      ENDIF.
      IF screen-group1 EQ 'GR4'.
        screen-active = 0.
        MODIFY SCREEN.
      ENDIF.
      IF screen-group1 EQ 'GR5'.
        screen-active = 0.
        MODIFY SCREEN.
      ENDIF.
      IF screen-group1 EQ 'GR6'.
        screen-active = 0.
        MODIFY SCREEN.
      ENDIF.
    ENDIF.
    IF p_check2 EQ abap_true.
      p_check1 = abap_false.
      p_check3 = abap_false.
      IF screen-group1 EQ 'GR1'.
        screen-active = 0.
        MODIFY SCREEN.
      ENDIF.
      IF screen-group1 EQ 'GR2'.
        screen-active = 1.
        MODIFY SCREEN.
      ENDIF.
      IF screen-group1 EQ 'GR3'.
        screen-active = 1.
        MODIFY SCREEN.
      ENDIF.
      IF screen-group1 EQ 'GR4'.
        screen-active = 0.
        MODIFY SCREEN.
      ENDIF.
      IF screen-group1 EQ 'GR5'.
        screen-active = 0.
        MODIFY SCREEN.
      ENDIF.
      IF screen-group1 EQ 'GR6'.
        screen-active = 0.
        MODIFY SCREEN.
      ENDIF.
    ENDIF.
    IF p_check3 EQ abap_true.
      p_check1 = abap_false.
      p_check2 =   abap_false.
      IF screen-group1 EQ 'GR1'.
        screen-active = 0.
        MODIFY SCREEN.
      ENDIF.
      IF screen-group1 EQ 'GR2'.
        screen-active = 0.
        MODIFY SCREEN.
      ENDIF.
      IF screen-group1 EQ 'GR3'.
        screen-active = 0.
        MODIFY SCREEN.
      ENDIF.
      IF screen-group1 EQ 'GR4'.
        screen-active = 1.
        MODIFY SCREEN.
      ENDIF.
      IF screen-group1 EQ 'GR5'.
        screen-active = 1.
        MODIFY SCREEN.
      ENDIF.
      IF screen-group1 EQ 'GR6'.
        screen-active = 1.
        MODIFY SCREEN.
      ENDIF.
    ENDIF.
  ENDLOOP.

START-OF-SELECTION.
kare_alan = p_kenar * p_kenar.
      kare_cevre = p_kenar * 4.
      dkdrt_alan = p_kkenar * p_ukenar.
      dkdrt_cevre = p_kkenar + p_kkenar + p_ukenar + p_ukenar.
      ucgen_cevre = p_kenar1 + p_kenar2 + p_kenar3.
      ucgen_u = ucgen_cevre / 2.
      u_sonuc = ucgen_u * ( ucgen_u - p_kenar1 ) * ( ucgen_u - p_kenar2 ) * ( ucgen_u - p_kenar3 ).
      ucgen_alan = sqrt( u_sonuc ).
IF p_rad1 EQ 'X'.
    IF p_check1 EQ abap_true.
       WRITE 'şekil alan'.
       ULINE.
       WRITE  kare_alan.
  ENDIF.
  IF p_check2 EQ abap_true.
       WRITE 'şekil alan'.
       ULINE.
       WRITE  dkdrt_alan.
  ENDIF.
  IF p_check3 EQ abap_true.
       WRITE 'şekil alan'.
       ULINE.
       WRITE  ucgen_alan.
  ENDIF.

ENDIF.
IF p_rad2 EQ 'X'.
    IF p_check1 EQ abap_true.
       WRITE 'şekil cevre'.
       ULINE.
       WRITE  kare_cevre.
  ENDIF.
  IF p_check2 EQ abap_true.
       WRITE 'şekil cevre'.
       ULINE.
       WRITE  dkdrt_cevre.
  ENDIF.
  IF p_check3 EQ abap_true.
       WRITE 'şekil cevre'.
       ULINE.
       WRITE  ucgen_cevre.
  ENDIF.

ENDIF.
END-OF-SELECTION.
