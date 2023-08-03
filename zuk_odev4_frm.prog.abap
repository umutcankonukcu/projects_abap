*&---------------------------------------------------------------------*
*& Include          ZUK_ODEV4_FRM
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
  CLEAR gs_list.
  REFRESH gt_list.

  SELECT
    a~bukrs
    a~gjahr
    a~monat
    a~belnr
    b~lifnr
    c~iskonto
    b~wrbtr
    FROM bkpf AS a
   INNER JOIN bseg AS b
    ON b~bukrs EQ a~bukrs
   AND b~gjahr EQ a~gjahr
   AND b~belnr EQ a~belnr
   INNER JOIN zuk_t_iskonto
     AS c ON c~satici EQ b~lifnr
   INTO CORRESPONDING FIELDS OF TABLE gt_list
   WHERE a~bukrs IN s_bukrs
     AND a~gjahr IN s_gjahr
     AND a~monat IN s_monat
     AND b~lifnr IN s_lifnr.

  LOOP AT gt_list INTO gs_list.
    gs_list-iwrbtr = gs_list-wrbtr  - ( gs_list-wrbtr * gs_list-iskonto / 100 ).
    MODIFY gt_list FROM gs_list.
  ENDLOOP.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form SET_FCAT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_fcat .
  CLEAR : gs_fc.
  REFRESH : gt_fc.
  gs_fc-fieldname = 'BUKRS'.
  gs_fc-seltext_l = 'Şirket Kodu'.
  gs_fc-seltext_m = 'Şirket Kodu'.
  gs_fc-seltext_s = 'Şirket Kodu'.
  APPEND gs_fc TO gt_fc.

  CLEAR : gs_fc.
  gs_fc-fieldname = 'GJAHR'.
  gs_fc-seltext_l = 'Mali Yıl'.
  gs_fc-seltext_m = 'Mali Yıl'.
  gs_fc-seltext_s = 'Mali Yıl'.
  APPEND gs_fc TO gt_fc.

  CLEAR : gs_fc.
  gs_fc-fieldname = 'MONAT'.
  gs_fc-seltext_l = 'Dönem'.
  gs_fc-seltext_m = 'Dönem'.
  gs_fc-seltext_s = 'Dönem'.
  APPEND gs_fc TO gt_fc.

  CLEAR : gs_fc.
  gs_fc-fieldname = 'BELNR'.
  gs_fc-seltext_l = 'Belge Numarası'.
  gs_fc-seltext_m = 'Belge Numarası'.
  gs_fc-seltext_s = 'Belge Numarası'.
  gs_fc-hotspot = abap_true.
  APPEND gs_fc TO gt_fc.

  CLEAR : gs_fc.
  gs_fc-fieldname = 'LIFNR'.
  gs_fc-seltext_l = 'Satıcı'.
  gs_fc-seltext_m = 'Satıcı'.
  gs_fc-seltext_s = 'Satıcı'.
  APPEND gs_fc TO gt_fc.

  CLEAR : gs_fc.
  gs_fc-fieldname = 'ISKONTO'.
  gs_fc-seltext_l = 'iskonto '.
  gs_fc-seltext_m = 'iskonto'.
  gs_fc-seltext_s = 'iskonto'.
  gs_fc-edit = 'X'.
  APPEND gs_fc TO gt_fc.

  CLEAR : gs_fc.
  gs_fc-fieldname = 'IWRBTR'.
  gs_fc-seltext_l = 'İ. Tutar'.
  gs_fc-seltext_m = 'İndirim Tutar'.
  gs_fc-seltext_s = 'İndirimli Tutar'.
  APPEND gs_fc TO gt_fc.

  CLEAR : gs_fc.
  gs_fc-fieldname = 'WRBTR'.
  gs_fc-seltext_l = 'Tutar'.
  gs_fc-seltext_m = 'Tutar'.
  gs_fc-seltext_s = 'Tutar'.
  APPEND gs_fc TO gt_fc.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form SET_FCAT2
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*

FORM set_fcat2 .
  CLEAR : gs_fc2.
  REFRESH : gt_fc2.
  gs_fc2-fieldname = 'BUKRS'.
  gs_fc2-seltext_l = 'Şirket Kodu'.
  gs_fc2-seltext_m = 'Şirket Kodu'.
  gs_fc2-seltext_s = 'Şirket Kodu'.
  APPEND gs_fc2 TO gt_fc2.

  CLEAR : gs_fc2.

  gs_fc2-fieldname = 'GJAHR'.
  gs_fc2-seltext_l = 'Mali Yıl'.
  gs_fc2-seltext_m = 'Mali Yıl'.
  gs_fc2-seltext_s = 'Mali Yıl'.
  APPEND gs_fc2 TO gt_fc2.

  CLEAR : gs_fc2.

  gs_fc2-fieldname = 'BELNR'.
  gs_fc2-seltext_l = 'Belge Numarası'.
  gs_fc2-seltext_m = 'Belge Numarası'.
  gs_fc2-seltext_s = 'Belge Numarası'.
  APPEND gs_fc2 TO gt_fc2.

  CLEAR : gs_fc2.

  gs_fc2-fieldname = 'BUZEI'.
  gs_fc2-seltext_l = 'Belge Kalemi'.
  gs_fc2-seltext_m = 'Belge Kalemi'.
  gs_fc2-seltext_s = 'Belge Kalemi'.
  APPEND gs_fc2 TO gt_fc2.

  CLEAR : gs_fc2.

  gs_fc2-fieldname = 'SGTXT'.
  gs_fc2-seltext_l = 'Kalem Metni'.
  gs_fc2-seltext_m = 'Kalem Metni'.
  gs_fc2-seltext_s = 'Kalem Metni'.
  APPEND gs_fc2 TO gt_fc2.

  CLEAR : gs_fc2.

  gs_fc2-fieldname = 'GSBER'.
  gs_fc2-seltext_l = 'İş Alanı'.
  gs_fc2-seltext_m = 'İş Alanı'.
  gs_fc2-seltext_s = 'İş Alanı'.
  APPEND gs_fc2 TO gt_fc2.

  CLEAR : gs_fc2.

  gs_fc2-fieldname = 'SHKZG'.
  gs_fc2-seltext_l = 'Borç Alacak Göstergesi'.
  gs_fc2-seltext_m = 'Borç Alacak Göstergesi'.
  gs_fc2-seltext_s = 'Borç Alacak Göstergesi'.
  APPEND gs_fc2 TO gt_fc2.

  CLEAR : gs_fc2.

  gs_fc2-fieldname = 'WRBTR'.
  gs_fc2-seltext_l = 'Tutarı'.
  gs_fc2-seltext_m = 'Tutarı'.
  gs_fc2-seltext_s = 'Tutarı'.
  APPEND gs_fc2 TO gt_fc2.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form SET_LAYOUT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_layout .
  gs_layout-box_fieldname = 'SELKZ'.
  gs_layout-zebra = 'X' .
ENDFORM.
*&---------------------------------------------------------------------*
*& Form TABLO
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*

FORM tablo .

  DATA: lt_fcb TYPE slis_t_fieldcat_alv,
        ls_fcb TYPE slis_fieldcat_alv.

  CASE sy-ucomm.
    WHEN 'BT1'.
      CALL FUNCTION 'VIEW_MAINTENANCE_CALL'
        EXPORTING
          action    = 'S'
          view_name = 'ZUK_T_ISKONTO'.

    WHEN 'BT2'.
      CALL FUNCTION 'VIEW_MAINTENANCE_CALL'
        EXPORTING
          action    = 'U'
          view_name = 'ZUK_T_ISKONTO'.
  ENDCASE.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form DISPLAY_ALV
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM display_alv .
  DATA: ls_grid_settings TYPE lvc_s_glay.

  ls_grid_settings-edt_cll_cb = 'X'.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_grid_settings          = ls_grid_settings
      i_callback_program       = sy-repid
      i_callback_pf_status_set = 'PF_STATUS_SET'
      i_callback_user_command  = 'USER_COMMAND'
      is_layout                = gs_layout
      it_fieldcat              = gt_fc
    TABLES
      t_outtab                 = gt_list.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.
ENDFORM.
