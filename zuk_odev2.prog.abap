*&---------------------------------------------------------------------*
*& Report ZUK_ODEV2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zuk_odev2.

TABLES: zuk_ktphn_ogr, zuk_ktphn_islem, zuk_ktphn_kitap, zuk_ktphn_yazar.

DATA: gs_ktphn_ogr   TYPE zuk_ktphn_ogr,
      gs_ktphn_islem TYPE zuk_ktphn_islem,
      gs_ktphn_kitap TYPE zuk_ktphn_kitap,
      gs_ktphn_yazar TYPE zuk_ktphn_yazar.

DATA: gt_ogr    TYPE  zuk_ktphn_ogr OCCURS 0 WITH HEADER LINE,
      gt_islem  TYPE  zuk_ktphn_islem OCCURS 0 WITH HEADER LINE,
      gt_islem2 TYPE TABLE OF  zuk_ktphn_islem,
      gt_kitap  TYPE  zuk_ktphn_kitap OCCURS 0 WITH HEADER LINE,
      gt_yazar  TYPE  zuk_ktphn_yazar OCCURS 0 WITH HEADER LINE.

DATA: gt_deneme1  TYPE TABLE OF zuk_ktphn_ogr.
DATA: gs_deneme1  TYPE zuk_ktphn_ogr.
DATA: gt_deneme2 TYPE TABLE OF zuk_ktphn_islem.
DATA: gs_deneme2 TYPE zuk_ktphn_islem.
*DATA: gt_deneme3 TYPE TABLE OF zuk_ktphn_kitap.
*DATA: gt_deneme4 TYPE TABLE OF zuk_ktphn_yazar.

DATA: _kitapno TYPE zuk_ktphn_islem-kitap_no.


SELECTION-SCREEN BEGIN OF BLOCK b1.

PARAMETERS: p_ogr   AS CHECKBOX DEFAULT abap_false USER-COMMAND id1,
            p_islem AS CHECKBOX DEFAULT abap_false USER-COMMAND id2,
            p_kitap AS CHECKBOX DEFAULT abap_false USER-COMMAND id3,
            p_yazar AS CHECKBOX DEFAULT abap_false USER-COMMAND id4.

SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-001.

PARAMETERS: p_no    TYPE zuk_ktphn_ogr-ogr_no MODIF ID id1,
            p_ad    TYPE zuk_ktphn_ogr-ogr_ad MODIF ID id1,
            p_sad   TYPE zuk_ktphn_ogr-ogr_soyad MODIF ID id1,
            p_cins  TYPE zuk_ktphn_ogr-ogr_cinsiyet MODIF ID id1,
            p_tarih TYPE zuk_ktphn_ogr-ogr_tarih MODIF ID id1,
            p_sinif TYPE zuk_ktphn_ogr-ogr_sinif MODIF ID id1,
            p_puan  TYPE zuk_ktphn_ogr-ogr_puan MODIF ID id1.


SELECTION-SCREEN:

      PUSHBUTTON /2(10) TEXT-bt1 USER-COMMAND bt1 MODIF ID id1,
      PUSHBUTTON /2(10) TEXT-bt2 USER-COMMAND bt2 MODIF ID id1.



SELECTION-SCREEN END OF BLOCK b2.


SELECTION-SCREEN BEGIN OF BLOCK b3 WITH FRAME TITLE TEXT-002.
PARAMETERS: p_islmno TYPE zuk_ktphn_islem-islem_no MODIF ID id2,
            p_ogrno  TYPE zuk_ktphn_islem-ogr_no MODIF ID id2,
*            p_ktpno  TYPE zuk_ktphn_islem-kitap_no MODIF ID id2 MATCHCODE OBJECT ZUK_SRCH2,
            p_ktpno  LIKE _kitapno MODIF ID id2,
            p_atarih TYPE zuk_ktphn_islem-atarih MODIF ID id2,
            p_vtarih TYPE zuk_ktphn_islem-vtarih MODIF ID id2,
            trh_fark type i MODIF ID id2.

SELECTION-SCREEN:

      PUSHBUTTON /2(10) TEXT-bt3 USER-COMMAND bt3 MODIF ID id2,
      PUSHBUTTON /2(10) TEXT-bt4 USER-COMMAND bt4 MODIF ID id2.


SELECTION-SCREEN END OF BLOCK b3.

SELECTION-SCREEN BEGIN OF BLOCK b4 WITH FRAME TITLE TEXT-003.
PARAMETERS: p_kitpno TYPE  zuk_ktphn_kitap-kitap_no MODIF ID id3,
            p_isbno  TYPE zuk_ktphn_kitap-kitap_isb_no MODIF ID id3,
            p_ktpad  TYPE zuk_ktphn_kitap-kitap_ad MODIF ID id3,
            p_yzrno  TYPE zuk_ktphn_kitap-kitap_yazar_no MODIF ID id3 MATCHCODE OBJECT zuk_srch_yazar,
            p_turno  TYPE zuk_ktphn_kitap-tur_no MODIF ID id3 MATCHCODE OBJECT zuk_srch_tur,
            p_syfa   TYPE zuk_ktphn_kitap-sayfa_sayisi MODIF ID id3,
            p_kipuan TYPE zuk_ktphn_kitap-puan MODIF ID id3.

SELECTION-SCREEN:

      PUSHBUTTON /2(10) TEXT-bt5 USER-COMMAND bt5 MODIF ID id3,
      PUSHBUTTON /2(10) TEXT-bt6 USER-COMMAND bt6 MODIF ID id3.


SELECTION-SCREEN END OF BLOCK b4.


SELECTION-SCREEN BEGIN OF BLOCK b5 WITH FRAME TITLE TEXT-004.
PARAMETERS: p_yazrno TYPE  zuk_ktphn_yazar-yazar_no MODIF ID id4,
            p_yzrad  TYPE zuk_ktphn_yazar-yazar_ad MODIF ID id4,
            p_yzrsad TYPE zuk_ktphn_yazar-yazar_soyad MODIF ID id4.
SELECTION-SCREEN:
PUSHBUTTON /2(10) TEXT-bt7 USER-COMMAND bt7 MODIF ID id4,
PUSHBUTTON /2(10) TEXT-bt8 USER-COMMAND bt8 MODIF ID id4.

SELECTION-SCREEN END OF BLOCK b5.

AT SELECTION-SCREEN ON p_ogrno.
  IF p_islem IS NOT INITIAL AND p_ogrno IS NOT INITIAL.
    SELECT SINGLE ogr_no
      FROM zuk_ktphn_ogr
      INTO @DATA(_ogr_no)
      WHERE ogr_no EQ @p_ogrno.
    IF sy-subrc IS NOT INITIAL.
      MESSAGE 'Bu öğrenci kayıtlı değil!' TYPE 'E' DISPLAY LIKE 'I'.
    ENDIF.

  ENDIF.
*AT SELECTION-SCREEN ON p_kitpno.
AT SELECTION-SCREEN ON p_ktpno.
  IF p_islem IS NOT INITIAL AND p_ktpno IS NOT INITIAL.
    SELECT SINGLE kitap_no
       FROM zuk_ktphn_kitap
       INTO @DATA(_kitap_no)
*   WHERE kitap_no EQ @p_kitpno.
       WHERE kitap_no EQ @p_ktpno.
    IF sy-subrc IS NOT INITIAL.
      MESSAGE 'Bu kitap kayıtlı değil!' TYPE 'E'  DISPLAY LIKE 'I'.
    ENDIF.
  ENDIF.




AT SELECTION-SCREEN OUTPUT.

  PERFORM screen-select USING: p_ogr
                               p_islem
                               p_kitap
                               p_yazar.

AT SELECTION-SCREEN.
  IF sy-ucomm EQ 'BT1'.
    PERFORM btn_ogr USING: gs_ktphn_ogr.
  ENDIF.

  IF sy-ucomm EQ 'BT2'.
    PERFORM btn_ogr_ara USING: gs_ktphn_ogr.
  ENDIF.

  IF sy-ucomm EQ 'BT3'.
    PERFORM btn_islem USING: gs_ktphn_islem.
  ENDIF.

  IF sy-ucomm EQ 'BT4'.
    PERFORM btn_islem_ara USING: gs_ktphn_islem.
  ENDIF.

  IF sy-ucomm EQ 'BT5'.
    PERFORM btn_kitap USING: gs_ktphn_kitap.
  ENDIF.

  IF sy-ucomm EQ 'BT6'.
    PERFORM btn_kitap_ara USING: gs_ktphn_kitap.
  ENDIF.


  IF sy-ucomm EQ 'BT7'.
    PERFORM btn_yazar USING: gs_ktphn_yazar.
  ENDIF.

  IF sy-ucomm EQ 'BT8'.
    PERFORM btn_yazar_ara USING: gs_ktphn_yazar.
  ENDIF.




START-OF-SELECTION.
  CLEAR : gt_islem, gt_kitap, gt_ogr, gt_yazar.


FORM screen-select USING p_ogr
                         p_islem
                         p_kitap
                         p_yazar.
  LOOP AT SCREEN.

    CASE screen-group1.
      WHEN 'ID1'.
        IF p_ogr IS INITIAL.

          SELECT COUNT( * )
            FROM zuk_ktphn_ogr
            INTO @DATA(ogr_sayısı).
          IF sy-dbcnt IS NOT INITIAL.
            p_no = sy-dbcnt + 1.
          ENDIF.

          screen-invisible = 1.
          screen-active = 0.
          MODIFY SCREEN.
        ENDIF.
      WHEN 'ID2'.
        IF p_islem IS INITIAL.
          screen-invisible = 1.
          screen-active = 0.
          MODIFY SCREEN.
        ENDIF.
      WHEN 'ID3'.
        IF p_kitap IS INITIAL.
          screen-invisible = 1.
          screen-active = 0.
          MODIFY SCREEN.
        ENDIF.
      WHEN 'ID4'.
        IF p_yazar IS INITIAL.
          screen-invisible = 1.
          screen-active = 0.
          MODIFY SCREEN.
        ENDIF.



    ENDCASE.
  ENDLOOP.

ENDFORM.
*              p_no = ZUK_KTPHN_OGR-ogr_no.
*              p_ad =  ZUK_KTPHN_OGR-ogr_ad .
*              p_sad = ZUK_KTPHN_OGR-ogr_soyad.
*              p_cins = ZUK_KTPHN_OGR-ogr_cinsiyet.
*              p_tarih = ZUK_KTPHN_OGR-ogr_tarih .
*              p_sinif = ZUK_KTPHN_OGR-ogr_sinif .
*              p_puan = ZUK_KTPHN_OGR-ogr_puan .
*&---------------------------------------------------------------------*
*& Form BTN_OGR
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> P_NO
*&      --> P_AD
*&      --> P_SAD
*&      --> P_CINS
*&      --> P_TARIH
*&      --> P_SINIF
*&      --> P_PUAN
*&---------------------------------------------------------------------*
FORM btn_ogr USING gs_ktphn_ogr TYPE zuk_ktphn_ogr.

  gs_ktphn_ogr-ogr_no = p_no.
  gs_ktphn_ogr-ogr_ad = p_ad.
  gs_ktphn_ogr-ogr_soyad = p_sad.
  gs_ktphn_ogr-ogr_cinsiyet = p_cins.
  gs_ktphn_ogr-ogr_tarih = p_tarih.
  gs_ktphn_ogr-ogr_sinif = p_sinif.
  gs_ktphn_ogr-ogr_puan = p_puan.


  IF p_puan > 100.

    MESSAGE 'Öğrenci Puanı 100 den Büyük Olamaz.' TYPE 'I'.
    LEAVE SCREEN.
  ELSEIF p_puan < 0.

    MESSAGE 'Öğrenci Puanı 0 dan Küçük Olamaz' TYPE 'I'.

  ENDIF.


  IF p_sinif > 4.

    MESSAGE 'Öğrencinin sınıfı 4 den büyük olamaz' TYPE 'I'.
    LEAVE SCREEN.
  ENDIF.

  IF gs_ktphn_ogr IS NOT INITIAL.

    CALL FUNCTION 'ZUK_KTPHN_ODEV2'
      EXPORTING
        iv_table_values = gs_ktphn_ogr.

  ENDIF.








ENDFORM.

FORM btn_ogr_ara USING gs_ktphn_ogr TYPE zuk_ktphn_ogr.

  gs_ktphn_ogr-ogr_no = p_no.
  gs_ktphn_ogr-ogr_ad = p_ad.
  gs_ktphn_ogr-ogr_soyad = p_sad.
  gs_ktphn_ogr-ogr_cinsiyet = p_cins.
  gs_ktphn_ogr-ogr_tarih = p_tarih.
  gs_ktphn_ogr-ogr_sinif = p_sinif.
  gs_ktphn_ogr-ogr_puan = p_puan.

  SELECT SINGLE  * FROM zuk_ktphn_ogr INTO gt_ogr WHERE  ogr_no = p_no .

  IF  sy-subrc IS INITIAL .

    p_ad = gt_ogr-ogr_ad.
    p_sad = gt_ogr-ogr_soyad.
    p_cins = gt_ogr-ogr_cinsiyet.
    p_tarih = gt_ogr-ogr_tarih.
    p_sinif = gt_ogr-ogr_sinif.
    p_puan = gt_ogr-ogr_puan.

    MESSAGE 'Kayıt Bulunmuştur.' TYPE 'I'.

  ELSEIF sy-subrc IS NOT INITIAL .

    CLEAR : p_ad , p_sad , p_cins , p_tarih , p_sinif , p_puan.

    MESSAGE 'Kayıt Bulunamamıştır.' TYPE 'I'.
  ENDIF.












ENDFORM.


FORM btn_islem USING gs_ktphn_islem TYPE zuk_ktphn_islem.
  DATA: _sayac TYPE int4.

  gs_ktphn_islem-islem_no = p_islmno.
  gs_ktphn_islem-ogr_no = p_ogrno.
  gs_ktphn_islem-kitap_no = p_ktpno.
  gs_ktphn_islem-atarih = p_atarih.
  gs_ktphn_islem-vtarih = p_vtarih.




  SELECT * INTO TABLE gt_deneme1 FROM zuk_ktphn_ogr.
  SELECT * INTO TABLE gt_deneme2 FROM zuk_ktphn_islem.
*SELECT * INTO TABLE gt_deneme3 FROM zuk_ktphn_kitap.


  READ TABLE gt_deneme1 INTO gs_deneme1 WITH KEY ogr_no = p_ogrno.
  IF sy-subrc IS INITIAL.
    IF gs_deneme1-ogr_puan LE 50.
      LOOP AT gt_deneme2 TRANSPORTING NO FIELDS WHERE ogr_no = p_ogrno.
        _sayac = _sayac + 1.
        IF _sayac GT 1.
          MESSAGE 'Öğrenci puanı düşük olduğundan dolayı ikinci kitabı alamaz.' TYPE 'I'.
          LEAVE SCREEN.
        ENDIF.
      ENDLOOP.
    ENDIF.
  ENDIF.


  IF gs_ktphn_islem IS NOT INITIAL.
    IF gs_ktphn_islem-ogr_no EQ p_ogrno.
      IF gs_ktphn_islem-kitap_no EQ p_ktpno.
        CALL FUNCTION 'ZUK_KTPHN_ODEV2'
          EXPORTING
            iv_table_values2 = gs_ktphn_islem.
        IF sy-subrc IS INITIAL.
          CALL FUNCTION 'NUMBER_GET_NEXT'
            EXPORTING
              nr_range_nr = '01'
              object      = 'ZUK_SNRO'
            IMPORTING
              number      = gs_ktphn_islem-islem_no.
        ENDIF.

      ELSE.
        MESSAGE 'Kitap bulunamamıştır.' TYPE 'I'.
      ENDIF.
    ELSE.
      MESSAGE 'ogrenci no bulunamamıştır.'  TYPE 'I'.
    ENDIF.

  ENDIF.



    call function 'DAYS_BETWEEN_TWO_DATES'
exporting
i_datum_bis             = p_vtarih
i_datum_von             = p_atarih
*i_stgmeth               = 2
importing
e_tage                  = trh_fark.
*exceptions
*days_method_not_defined = 1
*others                  = 2

*  IF gs_ktphn_islem IS NOT INITIAL.
*    IF gs_ktphn_islem-ogr_no EQ p_ogrno.
*      CALL FUNCTION 'ZUK_KTPHN_ODEV2'
*        EXPORTING
*          iv_table_values2 = gs_ktphn_islem.
*    ELSE.
*      MESSAGE 'ogrenci no bulunamamıştır.'  TYPE 'I'.
*
*    ENDIF.
*
*
*    IF gs_ktphn_islem-kitap_no EQ p_ktpno.
*      CALL FUNCTION 'ZUK_KTPHN_ODEV2'
*        EXPORTING
*          iv_table_values2 = gs_ktphn_islem.
*    ELSE.
*      MESSAGE 'kitap bulunamamıştır.'  TYPE 'I'.
*
*    ENDIF.
*
*  ENDIF.
*
* SELECT SINGLE  * FROM zo_t_ogrenci INTO gt_ogri WHERE  ogr_no = iv_key .
*
*      IF  sy-subrc IS INITIAL .
*
*        ev_kontrol = 0.
*
*      ELSEIF sy-subrc IS NOT INITIAL .
*
*        ev_kontrol = 1.
*
*



ENDFORM.

FORM btn_islem_ara USING gs_ktphn_islem TYPE zuk_ktphn_islem.

  gs_ktphn_islem-islem_no = p_islmno.
  gs_ktphn_islem-ogr_no = p_ogrno.
  gs_ktphn_islem-kitap_no = p_ktpno.
  gs_ktphn_islem-atarih = p_atarih.
  gs_ktphn_islem-vtarih = p_vtarih.



  SELECT   * FROM zuk_ktphn_islem INTO TABLE gt_islem2 WHERE  islem_no = p_islmno.

  IF  sy-subrc IS INITIAL .

**      p_ogrno = gt_islem-ogr_no.
**      p_ktpno = gt_islem-kitap_no.
**      p_atarih = gt_islem-atarih.
**      p_vtarih = gt_islem-vtarih.


    MESSAGE 'Kayıt Bulunmuştur.' TYPE 'I'.

    "Instantiation
    cl_salv_table=>factory(
      IMPORTING
        r_salv_table = DATA(lo_alv)
      CHANGING
        t_table      = gt_islem2 ).
    " pop up salv liste şeklinde kaydet.
    "Do stuff
    "...

    "Display the ALV Grid
    lo_alv->display( ).

  ELSEIF sy-subrc IS NOT INITIAL .

    CLEAR : p_ogrno , p_ktpno , p_atarih , p_vtarih.

    MESSAGE 'Kayıt Bulunamamıştır.' TYPE 'I'.
  ENDIF.






ENDFORM.


FORM btn_kitap USING gs_ktphn_kitap TYPE zuk_ktphn_kitap.

  gs_ktphn_kitap-kitap_no = p_kitpno.
  gs_ktphn_kitap-kitap_isb_no = p_isbno.
  gs_ktphn_kitap-kitap_ad = p_ktpad.
  gs_ktphn_kitap-kitap_yazar_no = p_yzrno.
  gs_ktphn_kitap-tur_no = p_turno.
  gs_ktphn_kitap-sayfa_sayisi = p_syfa.
  gs_ktphn_kitap-puan = p_syfa.

  IF gs_ktphn_kitap IS NOT INITIAL.

    CALL FUNCTION 'ZUK_KTPHN_ODEV2'
      EXPORTING
        iv_table_values3 = gs_ktphn_kitap.
  ENDIF.

ENDFORM.


FORM btn_kitap_ara USING gs_ktphn_kitap TYPE zuk_ktphn_kitap.

  gs_ktphn_kitap-kitap_no = p_kitpno.
  gs_ktphn_kitap-kitap_isb_no = p_isbno.
  gs_ktphn_kitap-kitap_ad = p_ktpad.
  gs_ktphn_kitap-kitap_yazar_no = p_yzrno.
  gs_ktphn_kitap-tur_no = p_turno.
  gs_ktphn_kitap-sayfa_sayisi = p_syfa.
  gs_ktphn_kitap-puan = p_puan.



  SELECT SINGLE  * FROM zuk_ktphn_kitap INTO gt_kitap WHERE  kitap_no = p_kitpno.

  IF  sy-subrc IS INITIAL .

    p_isbno = gt_kitap-kitap_isb_no.
    p_ktpad = gt_kitap-kitap_ad.
    p_yzrno = gt_kitap-kitap_yazar_no.
    p_turno = gt_kitap-tur_no.
    p_syfa = gt_kitap-sayfa_sayisi.
    p_puan = gt_kitap-puan.




    MESSAGE 'Kayıt Bulunmuştur.' TYPE 'I'.

  ELSEIF sy-subrc IS NOT INITIAL .

    CLEAR : p_isbno , p_ktpad , p_yzrno , p_turno , p_syfa , p_puan.

    MESSAGE 'Kayıt Bulunamamıştır.' TYPE 'I'.
  ENDIF.




ENDFORM.



FORM btn_yazar USING gs_ktphn_yazar TYPE zuk_ktphn_yazar.
  gs_ktphn_yazar-yazar_no = p_yazrno.
  gs_ktphn_yazar-yazar_ad = p_yzrad.
  gs_ktphn_yazar-yazar_soyad = p_yzrsad.

  IF gs_ktphn_yazar IS NOT INITIAL.
    CALL FUNCTION 'ZUK_KTPHN_ODEV2'
      EXPORTING
        iv_table_values4 = gs_ktphn_yazar.
  ENDIF.

ENDFORM.


FORM btn_yazar_ara USING gs_ktphn_yazar TYPE zuk_ktphn_yazar.
  gs_ktphn_yazar-yazar_no = p_yazrno.
  gs_ktphn_yazar-yazar_ad = p_yzrad.
  gs_ktphn_yazar-yazar_soyad = p_yzrsad.



  SELECT SINGLE  * FROM zuk_ktphn_yazar INTO gt_yazar WHERE  yazar_no = p_yazrno.

  IF  sy-subrc IS INITIAL .

    p_yzrad = gt_yazar-yazar_ad.
    p_yzrsad = gt_yazar-yazar_soyad.


    MESSAGE 'Kayıt Bulunmuştur.' TYPE 'I'.

  ELSEIF sy-subrc IS NOT INITIAL .

    CLEAR : p_yzrad , p_yzrsad.

    MESSAGE 'Kayıt Bulunamamıştır.' TYPE 'I'.
  ENDIF.




ENDFORM.
