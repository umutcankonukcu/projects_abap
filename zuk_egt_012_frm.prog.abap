*&---------------------------------------------------------------------*
*& Include          ZUK_EGT_012_FRM
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
  SELECT
      ekko~ebeln
      ekpo~ebelp
      ekko~bstyp
      ekko~bsart
      ekpo~matnr
      ekpo~menge
      ekpo~meins
     FROM ekko
     INNER JOIN ekpo ON ekpo~ebeln EQ ekko~ebeln
      INTO CORRESPONDING FIELDS OF TABLE gt_list.
** LINE COLOR
*    LOOP AT gt_list INTO gs_list.
*      IF gs_list-menge > 10.
*         gs_list-line_color = 'C500'.
*        ELSEIF gs_list-menge > 5 .
*          gs_list-line_color = 'C310'.
*          ELSE.
*            gs_list-line_color = 'C610'.
*      ENDIF.
*      MODIFY gt_list FROM gs_list.
*    ENDLOOP.

*** CELL COLOR
  LOOP AT gt_list INTO gs_list.
    IF gs_list-ebeln MOD 2 EQ 0.
      CLEAR: gs_cell_color.
      gs_cell_color-fieldname = 'EBELN'.
      gs_cell_color-color-col = 4.
      gs_cell_color-color-int = 1.
      gs_cell_color-color-inv = 0.
    ELSE.
      gs_cell_color-fieldname = 'EBELN'.
      gs_cell_color-color-col = 7.
      gs_cell_color-color-int = 1.
      gs_cell_color-color-inv = 0.

    ENDIF.
    APPEND gs_cell_color TO gs_list-cell_color.
    MODIFY gt_list FROM gs_list.
  ENDLOOP.

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
*
*  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
*    EXPORTING
*      i_program_name   = sy-repid
**     I_INTERNAL_TABNAME           = 'GT_LIST'
*      i_structure_name = 'ZUK_EGT_012_S'
*      i_inclname       = sy-repid
*    CHANGING
*      ct_fieldcat      = gt_fieldcat.



  PERFORM: set_fc_sub USING 'EBELN' 'SAS NO' 'SAS Numarası' 'SAS Numarası'  abap_true '0' '' 'X',
           set_fc_sub USING 'EBELP' 'Kalem' 'Kalem' 'Kalem' 'X' '1' '' '',
           set_fc_sub USING 'BSTYP' 'Belge tipi' 'Belge tipi' 'Belge tipi' '' '2' '' '',
           set_fc_sub USING 'BSART' 'Belge türü' 'Belge türü' 'Belge türü' '' '3' '' '',
           set_fc_sub USING 'MATNR' 'Malzeme' 'Malzeme' 'Malzeme' '' '4' '' 'X',
           set_fc_sub USING 'MENGE' 'Miktar' 'Miktar' 'Miktar' '' '5' 'X' '',
           set_fc_sub USING 'MEINS' 'ÖB' 'Ölçü birimi' 'Ölçü birimi' '' '6' '' ''.


ENDFORM.

FORM set_fc_sub USING p_fieldname
                      p_seltext_s
                      p_seltext_m
                      p_seltext_l
                      p_key
                      p_col_pos
                      p_do_sum
                      p_hotspot.
  CLEAR: gs_fieldcat.
  gs_fieldcat-fieldname = p_fieldname.
  gs_fieldcat-seltext_s = p_seltext_s.
  gs_fieldcat-seltext_m = p_seltext_m.
  gs_fieldcat-seltext_l = p_seltext_l.
  gs_fieldcat-key = p_key.
  gs_fieldcat-col_pos = p_col_pos.
  gs_fieldcat-do_sum = p_do_sum.
  gs_fieldcat-hotspot = p_hotspot.
  APPEND gs_fieldcat TO gt_fieldcat.
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

  gs_layout-window_titlebar = 'REUSE ALV ALISTIRMA'.
  gs_layout-zebra = abap_true.
  gs_layout-colwidth_optimize = abap_true.
  gs_layout-box_fieldname = 'SELKZ'.
*  gs_layout-info_fieldname = 'LINE_COLOR'.
  gs_layout-coltab_fieldname = 'CELL_COLOR'.
*  gs_layout-edit = abap_true
*  edit tabloların editlenebilmesini sağlar
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
  gs_event-name = slis_ev_top_of_page.
  gs_event-form = 'TOP_OF_PAGE'.
  APPEND gs_event TO gt_events.
  gs_event-name = slis_ev_end_of_list.
  gs_event-form = 'END_OF_LIST'.
  APPEND gs_event TO gt_events.
  gs_event-name = slis_ev_pf_status_set.
  gs_event-form = 'PF_STATUS_SET'.
  APPEND gs_event TO gt_events.

  gs_exclude-fcode = '&UMC'.  "toplama butonunu kaldırdık   " PF_STATUS_sET İLE BERABER ÇALIŞMIYOR.
  APPEND gs_exclude TO gt_exclude.
  gs_exclude-fcode = '&INFO'.  "info butonunu kaldırdık
  APPEND gs_exclude TO gt_exclude.

  gs_sort-spos      = 1.
  gs_sort-tabname   = 'GT_LIST'. "tırnak içindeki ifadeleri büyük harfle yaz.
  gs_sort-fieldname = 'EBELN'.
  gs_sort-down      = abap_true.
  APPEND gs_sort TO gt_sort.

  gs_sort-spos      = 2.
  gs_sort-tabname   = 'GT_LIST'. "tırnak içindeki ifadeleri büyük harfle yaz.
  gs_sort-fieldname = 'MENGE'.
  gs_sort-up      = abap_true.
  APPEND gs_sort TO gt_sort.

  gs_filter-tabname   = 'GT_LIST'.
  gs_filter-fieldname = 'MENGE'.
  gs_filter-sign0     = 'I'.
  gs_filter-optio     = 'EQ'.
  gs_filter-valuf_int = 10.         "MENGE -> miktarı 10 olanları getirir.
  APPEND gs_filter TO gt_filter.


*  I_SAVE = ' ' --> kaydedilemez
*  I_SAVE = 'X' --> standart
*  I_SAVE = 'U' --> user'a bağlı kaydetme metodu
*  I_SAVE = 'A' --> ister user istersek de standarta bağlı kaydetme

  gs_variant-variant = p_vari.       "ön ayarlı olan /DENEME2 yi ezerek önüne geçerek /DENEME 'yi çalıştırır.


  CALL FUNCTION 'REUSE_ALV_LIST_DISPLAY'
    EXPORTING
*     I_INTERFACE_CHECK       = ' '
*     I_BYPASSING_BUFFER      =
*     I_BUFFER_ACTIVE         = ' '
      i_callback_program      = sy-repid
*     I_CALLBACK_PF_STATUS_SET       = ' '
      i_callback_user_command = 'USER_COMMAND'
*     I_STRUCTURE_NAME        =
      is_layout               = gs_layout
      it_fieldcat             = gt_fieldcat
      it_excluding            = gt_exclude  " butonları kaldırmak için kullanabiliriz.
*     IT_SPECIAL_GROUPS       =
      it_sort                 = gt_sort    "listeyi düzenler örn büyükten küçüğe sıralamak gibi
      it_filter               = gt_filter   "verileri filtrelemek için kullanılır
*     IS_SEL_HIDE             =
*     I_DEFAULT               = 'X'
*     I_SAVE                  = ' '
*     IS_VARIANT              =
     IT_EVENTS               = gt_events
*     IT_EVENT_EXIT           =
*     IS_PRINT                =
*     IS_REPREP_ID            =
     I_SCREEN_START_COLUMN   = 40
     I_SCREEN_START_LINE     = 5
     I_SCREEN_END_COLUMN     = 100
     I_SCREEN_END_LINE       = 20
*     IR_SALV_LIST_ADAPTER    =
*     IT_EXCEPT_QINFO         =
*     I_SUPPRESS_EMPTY_DATA   = ABAP_FALSE
*   IMPORTING
*     E_EXIT_CAUSED_BY_CALLER =
*     ES_EXIT_CAUSED_BY_USER  =
    TABLES
      t_outtab                = gt_list
*   EXCEPTIONS
*     PROGRAM_ERROR           = 1
*     OTHERS                  = 2
    .
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.



*  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
*    EXPORTING
**     I_INTERFACE_CHECK       = ' '
**     I_BYPASSING_BUFFER      = ' '
**     I_BUFFER_ACTIVE         = ' '
*      i_callback_program      = sy-repid
*    sy-repid hangi programın içerisindeysen onu dinamik olarak yakalar.
*     i_callback_pf_status_set = 'PF_STATUS_SET'
*      i_callback_user_command = 'USER_COMMAND'
*     I_CALLBACK_TOP_OF_PAGE  = 'TOP_OF_PAGE'
**     I_CALLBACK_HTML_TOP_OF_PAGE       = ' '
**     I_CALLBACK_HTML_END_OF_LIST       = ' '
**     I_STRUCTURE_NAME        =
**     I_BACKGROUND_ID         = ' '
**     I_GRID_TITLE            =
**     I_GRID_SETTINGS         =
*      is_layout               = gs_layout
*      it_fieldcat             = gt_fieldcat
*      it_excluding            = gt_exclude  " butonları kaldırmak için kullanabiliriz.
**     IT_SPECIAL_GROUPS       =
*      it_sort                 = gt_sort    "listeyi düzenler örn büyükten küçüğe sıralamak gibi
*      it_filter               = gt_filter   "verileri filtrelemek için kullanılır
**     IS_SEL_HIDE             =
*     I_DEFAULT               = 'X'
*      i_save                  = 'A'
*      is_variant              = gs_variant
*      it_events               = gt_events
**     IT_EVENT_EXIT           =
**     IS_PRINT                =
**     IS_REPREP_ID            =
*      i_screen_start_column   = 40
*      i_screen_start_line     = 5
*      i_screen_end_column     = 100
*      i_screen_end_line       = 20
*     I_HTML_HEIGHT_TOP       = 0
*     I_HTML_HEIGHT_END       = 0
**     IT_ALV_GRAPHICS         =
**     IT_HYPERLINK            =
**     IT_ADD_FIELDCAT         =
**     IT_EXCEPT_QINFO         =
**     IR_SALV_FULLSCREEN_ADAPTER        =
**     O_PREVIOUS_SRAL_HANDLER =
**                   IMPORTING
**     E_EXIT_CAUSED_BY_CALLER =
**     ES_EXIT_CAUSED_BY_USER  =
*    TABLES
*      t_outtab                = gt_list
*                   EXCEPTIONS
*     PROGRAM_ERROR           = 1
*     OTHERS                  = 2
*    .

ENDFORM.
*&---------------------------------------------------------------------*
*& Form TOP_OF_PAGE
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM top_of_page .
  DATA: lt_header TYPE slis_t_listheader,
        ls_header TYPE slis_listheader.

  DATA: lv_date TYPE char10.



  CLEAR: ls_header.
  ls_header-typ = 'H'.
  ls_header-info = 'Satınalma Sipariş Raporu'.
  APPEND ls_header TO lt_header.

  CLEAR: ls_header.
  ls_header-typ = 'S'.
  ls_header-key = 'Tarih:'.
*  ls_header-info = '17.07.2023'.
  CONCATENATE sy-datum+6(2)
              '.'
              sy-datum+4(2)
              '.'
              sy-datum+0(4)
              INTO lv_date.
  ls_header-info = lv_date.
* sy-datum = 20230717
*            01234567

  APPEND ls_header TO lt_header.





  CALL FUNCTION 'REUSE_ALV_COMMENTARY_WRITE'
    EXPORTING
      it_list_commentary = lt_header
*     I_LOGO             =
*     I_END_OF_LIST_GRID =
*     I_ALV_FORM         =
    .
ENDFORM.
*&---------------------------------------------------------------------*
*& Form END_OF_LIST
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM end_of_list .
  DATA: lt_header TYPE slis_t_listheader,
        ls_header TYPE slis_listheader.

*  DATA: lv_date TYPE char10.
  DATA: lv_lines   TYPE i,
        lv_lines_c TYPE char4.





  CLEAR: ls_header.
  DESCRIBE TABLE gt_list LINES lv_lines.
  lv_lines_c = lv_lines.


  ls_header-typ = 'A'.
*  ls_header-info = 'Raporda 50 adet kalem vardır.'.
  CONCATENATE 'Raporda'
              lv_lines_c
              'adet kalem vardır'
              INTO ls_header-info
  SEPARATED BY space.
*  aralara boşluk koyar.
  APPEND ls_header TO lt_header.



  CALL FUNCTION 'REUSE_ALV_COMMENTARY_WRITE'
    EXPORTING
      it_list_commentary = lt_header
*     I_LOGO             =
*     I_END_OF_LIST_GRID =
*     I_ALV_FORM         =
    .
ENDFORM.
*&---------------------------------------------------------------------*
*& Form PF_STATUS_SET
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM pf_status_set USING p_extab TYPE slis_t_extab .
  SET PF-STATUS '0200'.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form USER_COMMAND
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> T_OUTTAB
*&      --> =
*&      --> GT_LIST
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form USER_COMMAND
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM user_command USING p_ucomm     TYPE sy-ucomm
                        ps_selfield TYPE slis_selfield.
  DATA: lv_mes TYPE char200,
        lv_ind TYPE numc2.
  CASE p_ucomm.
*    WHEN '&MSG'.
*      LOOP AT gt_list INTO gs_list where selkz eq 'X'.
*        lv_ind = lv_ind + 1.
*        ENDLOOP.
*        IF lv_ind > 1.
*            CONCATENATE   lv_ind
*                      'birden fazla sayı seçtin'
*                      INTO lv_mes
*                      SEPARATED BY space.
*           MESSAGE lv_mes TYPE 'I'.
*           ELSE.
*              CONCATENATE   lv_ind
*                      'birden '
*                      INTO lv_mes
*                      SEPARATED BY space.
*           MESSAGE lv_mes TYPE 'I'.
*        ENDIF.

    WHEN '&MSG'.
      LOOP AT gt_list INTO gs_list WHERE selkz EQ 'X'.
        lv_ind = lv_ind + 1.
      ENDLOOP.
      CONCATENATE   lv_ind
                    'sayı kadar satır seçilmiştir.'
                    INTO lv_mes
                    SEPARATED BY space.
      MESSAGE lv_mes TYPE 'I'.
    WHEN '&IC1'.
      CASE ps_selfield-fieldname.
        WHEN 'EBELN'.
          CONCATENATE ps_selfield-value
                      'numaralı SAS tıklanmıştır.'
                      INTO lv_mes
                      SEPARATED BY space.
          MESSAGE lv_mes TYPE 'I'.
        WHEN 'MATNR'.
          CONCATENATE ps_selfield-value
                     'numaralı malzeme tıklanmıştır.'
                     INTO lv_mes
                     SEPARATED BY space.
          MESSAGE lv_mes TYPE 'I'.
      ENDCASE.
*      MESSAGE 'Çift tıklandı.' TYPE 'I'.

  ENDCASE.

ENDFORM.
