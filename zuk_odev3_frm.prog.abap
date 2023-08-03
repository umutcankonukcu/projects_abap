*&---------------------------------------------------------------------*
*& Include          ZUK_ODEV3_FRM
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form GET_DATA
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_data .
  SELECT * FROM zuk_ktphn_ogr
     INNER JOIN zuk_ktphn_islem ON zuk_ktphn_islem~ogr_no EQ zuk_ktphn_ogr~ogr_no
     INNER JOIN zuk_ktphn_kitap ON zuk_ktphn_islem~kitap_no EQ zuk_ktphn_kitap~kitap_no
     INNER JOIN zuk_ktphn_yazar ON zuk_ktphn_kitap~kitap_yazar_no EQ zuk_ktphn_yazar~yazar_no
     INTO CORRESPONDING FIELDS OF TABLE gt_list.





ENDFORM.


FORM display_alv .


  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING

      is_layout   = gs_layout
      it_fieldcat = gt_fieldcat

    TABLES
      t_outtab    = gt_list.

ENDFORM.




*&---------------------------------------------------------------------*
*& Form SET_FC
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_fc .
  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = 'TRAFFIC'.
  gs_fieldcat-seltext_s = 'LIGHT'.
  gs_fieldcat-seltext_m = 'LIGHT'.
  gs_fieldcat-seltext_l = 'LIGHT'.
  APPEND gs_fieldcat TO gt_fieldcat.




  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = 'OGR_NO'.
  gs_fieldcat-seltext_s = 'OGR NO'.
  gs_fieldcat-seltext_m = 'OGRENCI NO'.
  gs_fieldcat-seltext_l = 'OGRENCI NO'.
  APPEND gs_fieldcat TO gt_fieldcat.

  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = 'OGR_AD'.
  gs_fieldcat-seltext_s = 'OGR AD'.
  gs_fieldcat-seltext_m = 'OGRENCI AD'.
  gs_fieldcat-seltext_l = 'OGRENCI AD'.
  APPEND gs_fieldcat TO gt_fieldcat.

  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = 'OGR_SOYAD'.
  gs_fieldcat-seltext_s = 'OGR SAD'.
  gs_fieldcat-seltext_m = 'OGRENCI SAD'.
  gs_fieldcat-seltext_l = 'OGRENCI SOYAD'.
  APPEND gs_fieldcat TO gt_fieldcat.

  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = 'KITAP_AD'.
  gs_fieldcat-seltext_s = 'KTP AD'.
  gs_fieldcat-seltext_m = 'KITAP AD'.
  gs_fieldcat-seltext_l = 'KITAP AD'.
  APPEND gs_fieldcat TO gt_fieldcat.

  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = 'YAZAR_AD'.
  gs_fieldcat-seltext_s = 'YZR AD'.
  gs_fieldcat-seltext_m = 'YAZAR AD'.
  gs_fieldcat-seltext_l = 'YAZAR AD'.
  APPEND gs_fieldcat TO gt_fieldcat.

  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = 'YAZAR_SOYAD'.
  gs_fieldcat-seltext_s = 'YZR_SAD'.
  gs_fieldcat-seltext_m = 'YZR_SOYAD'.
  gs_fieldcat-seltext_l = 'YAZAR SOYAD'.
  APPEND gs_fieldcat TO gt_fieldcat.

  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = 'ATARIH'.
  gs_fieldcat-seltext_s = 'ATARIH'.
  gs_fieldcat-seltext_m = 'ALıS TARIHI'.
  gs_fieldcat-seltext_l = 'ALıS TARIHI'.
  APPEND gs_fieldcat TO gt_fieldcat.

  CLEAR gs_fieldcat.
  gs_fieldcat-fieldname = 'VTARIH'.
  gs_fieldcat-seltext_s = 'VTARIH'.
  gs_fieldcat-seltext_m = 'VERILIS TARIHI'.
  gs_fieldcat-seltext_l = 'VERILIS TARIHI'.
  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR gs_fieldcat.

  gs_fieldcat-fieldname = 'OGR_PUAN'.
  gs_fieldcat-seltext_s = 'PUAN'.
  gs_fieldcat-seltext_m = 'OGR_PUAN'.
  gs_fieldcat-seltext_l = 'OGRENCI PUANI'.
  APPEND gs_fieldcat TO gt_fieldcat.


ENDFORM.
*&---------------------------------------------------------------------*
*& Form LAYOUT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM layout .


  gs_layout-colwidth_optimize = 'X'.
  gs_layout-info_fieldname = 'LINE_COLOR'.
  gs_layout-window_titlebar = 'Kütüphane otomasyon'.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form DISPLAY_ALV
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*



*&---------------------------------------------------------------------*
*& Form COLOR
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM color .
  LOOP AT gt_list INTO gs_list.
    IF gs_list-vtarih - gs_list-atarih > 3.

      gs_list-line_color = 'C500'.
      MODIFY gt_list FROM gs_list.
    ELSEIF gs_list-vtarih - gs_list-atarih = 3.

      gs_list-line_color = 'C300'.
      MODIFY gt_list FROM gs_list.
    ELSEIF 0 < gs_list-vtarih - gs_list-atarih AND gs_list-vtarih - gs_list-atarih < 3.
      gs_list-line_color = 'C300'.
      MODIFY gt_list FROM gs_list.
    ELSEIF gs_list-vtarih - gs_list-atarih = 0.

      gs_list-line_color = 'C300'.
      MODIFY gt_list FROM gs_list.
    ELSEIF gs_list-vtarih - gs_list-atarih < 0.

      gs_list-line_color = 'C600'.
      MODIFY gt_list FROM gs_list.

    ENDIF.
  ENDLOOP.


  LOOP AT gt_list INTO gs_list .
    IF 69 < gs_list-ogr_puan AND gs_list-ogr_puan < 101 .
      gs_list-traffic = '@08@'.
      MODIFY gt_list FROM gs_list.
    ELSEIF 49 < gs_list-ogr_puan AND gs_list-ogr_puan < 70.
      gs_list-traffic = '@09@'.
      MODIFY gt_list FROM gs_list.
    ELSEIF gs_list-ogr_puan < 50.
      gs_list-traffic = '@0A@'.
      MODIFY gt_list FROM gs_list.
    ENDIF.
  ENDLOOP.




ENDFORM.
