*&---------------------------------------------------------------------*
*& Include          ZUK_EGT_016_FRM
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form DISPLAY_ALV
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM display_alv .
  IF go_alv IS INITIAL.

CREATE OBJECT go_cust
  EXPORTING
    container_name = 'CC_ALV'.

CREATE OBJECT go_alv
  EXPORTING

    i_parent                = go_cust   .



*CREATE OBJECT go_cust2
*  EXPORTING
*    container_name = 'CC_ALV2'.

****CREATE OBJECT go_spli
****  EXPORTING
****    parent                  =         go_cust           " Parent Container
****    rows                    =            2        " Number of Rows to be displayed
****    columns                 =            1        " Number of Columns to be Displayed
****.
****
****call method go_spli->get_container
****  EXPORTING
****    row       =      1            " Row
****    column    =     1             " Column
****  RECEIVING
****    container =      go_sub1            " Container
****  .
****
****call method go_spli->get_container
****  EXPORTING
****    row       =      2          " Row
****    column    =     1             " Column
****  RECEIVING
****    container =      go_sub2            " Container
****  .
****
****CREATE OBJECT go_alv
****    EXPORTING
****      i_parent = go_sub2.
****
****
****CREATE OBJECT go_event_receiver.
****    SET HANDLER go_event_receiver->handle_top_of_page FOR go_alv.

****    CREATE OBJECT go_alv
****      EXPORTING
****        i_parent = go_sub2.         " en geniş olacak şekilde container i basar.

    CALL METHOD go_alv->set_table_for_first_display
      EXPORTING
        is_layout       = gs_layout               " Layout
      CHANGING
        it_outtab       = gt_scarr            " Output Table
        it_fieldcatalog = gt_fcat.         " Field Catalog
*
*    CALL METHOD go_alv2->set_table_for_first_display
*      EXPORTING
*        is_layout       = gs_layout               " Layout
*      CHANGING
*        it_outtab       = gt_scarr            " Output Table
*        it_fieldcatalog = gt_fcat.         " Field Catalog
*




    PERFORM set_dropdown.

    CALL METHOD go_alv->set_table_for_first_display
      EXPORTING
*       i_buffer_active =
*       i_bypassing_buffer            =
*       i_consistency_check           =
*       i_structure_name             = 'ZUK_EGT_016_S'
*       is_variant      =
*       i_save          =
*       i_default       = 'X'
        is_layout       = gs_layout
*       is_print        =
*       it_special_groups             =
*       it_toolbar_excluding          =
*       it_hyperlink    =
*       it_alv_graphics =
*       it_except_qinfo =
*       ir_salv_adapter =
      CHANGING
        it_outtab       = gt_scarr
        it_fieldcatalog = gt_fcat.
*    it_sort                       =
*    it_filter                     =
*  EXCEPTIONS
*    invalid_parameter_combination = 1
*    program_error                 = 2
*    too_many_lines                = 3
*    others                        = 4

    CALL METHOD go_alv->register_edit_event  "ENTERE BASTIKÇA VERİYİ ARKAPLANDA İŞLER
      EXPORTING
        i_event_id = cl_gui_alv_grid=>mc_evt_enter.

*    CALL METHOD go_grid->register_edit_event "VERİYİ GİRİNCE İŞLER.
*      EXPORTING
*        i_event_id = cl_gui_alv_grid=>mc_evt_modified.
  ELSE.
    CALL METHOD go_alv->refresh_table_display.
  ENDIF.








  IF sy-subrc <> 0.
*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*     WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
  ENDIF.


ENDFORM.
*&---------------------------------------------------------------------*
*& Form GET_DATA
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_data .
  SELECT * FROM scarr
INTO CORRESPONDING FIELDS OF TABLE gt_scarr.

*      SELECT * FROM sflight
*INTO CORRESPONDING FIELDS OF TABLE gt_sflight.

*    LOOP AT gt_scarr ASSIGNING <gfs_scarr>.
*          <gfs_scarr>-durum = '@0D@'.
*    ENDLOOP.

  LOOP AT gt_scarr ASSIGNING <gfs_scarr>.
    CASE <gfs_scarr>-currcode.
      WHEN 'USD'.
        <gfs_scarr>-line_color = 'C710'.
      WHEN 'JPY'.
        <gfs_scarr>-line_color = 'C510'.
      WHEN 'EUR'.
        CLEAR: gs_cell_color.
        gs_cell_color-fname = 'URL'.
        gs_cell_color-color-col = '3' .
        gs_cell_color-color-int = '1'.
        gs_cell_color-color-inv = '0'.
        APPEND gs_cell_color TO <gfs_scarr>-cell_color.
        CLEAR: gs_cell_color.
        gs_cell_color-fname = 'CARRNAME'.
        gs_cell_color-color-col = '1' .
        gs_cell_color-color-int = '1'.
        gs_cell_color-color-inv = '0'.
        APPEND gs_cell_color TO <gfs_scarr>-cell_color.
    ENDCASE.
  ENDLOOP.

  LOOP AT gt_scarr ASSIGNING <gfs_scarr>.
    CASE <gfs_scarr>-currcode.
      WHEN 'EUR'.
        <gfs_scarr>-dd_handle = '3'.
      WHEN 'USD'.
        <gfs_scarr>-dd_handle = '4'.
      WHEN 'JPY'.
        <gfs_scarr>-dd_handle = '5'.
    ENDCASE.
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
*  CLEAR: gs_fcat.
*  gs_fcat-fieldname = 'CARRID'.
*  gs_fcat-scrtext_s = 'Havayolu T.'.
*  gs_fcat-scrtext_m = 'Havayolu Tanımı'.
*  gs_fcat-scrtext_l = 'Havayolu şirketinin kısa tanımı'.
*  gs_fcat-col_pos = 2.
*  gs_fcat-key = abap_true.  "stunu renklendiriyor.
*  APPEND gs_fcat TO gt_fcat.
*
*  CLEAR: gs_fcat.
*  gs_fcat-fieldname = 'CARRNAME'.
*  gs_fcat-scrtext_s = 'Havayolu ad'.
*  gs_fcat-scrtext_m = 'Havayolu adı'.
*  gs_fcat-scrtext_l = 'Havayolu adı'.
*  gs_fcat-col_pos = 3.
*  gs_fcat-edit = abap_true.  "kolonu editlenebilir yapıyor.
*  APPEND gs_fcat TO gt_fcat.
*
*  CLEAR: gs_fcat.
*  gs_fcat-fieldname = 'CURRCODE'.
*  gs_fcat-scrtext_s = 'Para B.'.
*  gs_fcat-scrtext_m = 'Para Birimi'.
*  gs_fcat-scrtext_l = 'Para Birimi'.
*  gs_fcat-col_pos = 4.
*  gs_fcat-hotspot = abap_true.  "tıklanabilir yapıyor.
*  APPEND gs_fcat TO gt_fcat.
*
*  CLEAR: gs_fcat.
*  gs_fcat-fieldname = 'URL'.
*  gs_fcat-scrtext_s = 'URL'.
*  gs_fcat-scrtext_m = 'URL'.
*  gs_fcat-scrtext_l = 'URL'.
*  gs_fcat-col_pos = 1.
*  gs_fcat-col_opt = abap_true.    "stun genişliğini veriler sığacak kadar genişletir.
**  gs_fcat-no_out  = abap_true.  " kolon ekrana gelmiyor
**  gs_fcat-outputlen = 100.        "kolon genişliğini belirler. !!!NOT : col_opt kolonu optimize ederek bu kodu engeller.
**  gs_fcat-ref_table = 'SCARR'. "bu tablodan referans alarak kolonu belirler.
*  gs_fcat-ref_field = 'URL'.
*  APPEND gs_fcat TO gt_fcat.


  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
*     I_STRUCTURE_NAME       = 'SCARR'
      i_structure_name       = 'ZUK_EGT_016_S'
    CHANGING
      ct_fieldcat            = gt_fcat
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

*   CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
*    EXPORTING
*
*      i_structure_name       = 'SFLIGHT'
*    CHANGING
*      ct_fieldcat            = gt_fcat2
*    EXCEPTIONS
*      inconsistent_interface = 1
*      program_error          = 2
*      OTHERS                 = 3.
*  IF sy-subrc <> 0.
** Implement suitable error handling here
*  ENDIF.

  READ TABLE gt_fcat ASSIGNING <gfs_fc> WITH KEY fieldname = 'FIYAT'.
  IF sy-subrc EQ 0.
    <gfs_fc>-edit = abap_true.
    <gfs_fc>-scrtext_s = 'FIYAT'.
    <gfs_fc>-scrtext_m = 'FIYAT'.
    <gfs_fc>-scrtext_l = 'FIYAT'.
  ENDIF.

  READ TABLE gt_fcat ASSIGNING <gfs_fc> WITH KEY fieldname = 'LOCATION'.
  IF sy-subrc EQ 0.
    <gfs_fc>-scrtext_s = 'Lokasyon'.
    <gfs_fc>-scrtext_m = 'Lokasyon'.
    <gfs_fc>-scrtext_l = 'Lokasyon'.
    <gfs_fc>-edit = abap_true.
    <gfs_fc>-drdn_hndl = 1.
    APPEND gs_fcat TO gt_fcat.
  ENDIF.

  READ TABLE gt_fcat ASSIGNING <gfs_fc> WITH KEY fieldname = 'SEAT1'.
  IF sy-subrc EQ 0.
    <gfs_fc>-scrtext_s = 'Koltuk no'.
    <gfs_fc>-scrtext_m = 'Koltuk no'.
    <gfs_fc>-scrtext_l = 'Koltuk no'.
    <gfs_fc>-edit = abap_true.
    <gfs_fc>-drdn_hndl = 2.
    APPEND gs_fcat TO gt_fcat.
  ENDIF.

  READ TABLE gt_fcat ASSIGNING <gfs_fc> WITH KEY fieldname = 'SEATP'.
  IF sy-subrc EQ 0.
    <gfs_fc>-scrtext_s = 'Koltuk pos'.
    <gfs_fc>-scrtext_m = 'Koltuk pos'.
    <gfs_fc>-scrtext_l = 'Koltuk pos'.
    <gfs_fc>-edit = abap_true.
*    <gfs_fc>-drdn_hndl = 3. " drdn_hndl sabit dropdown verir biz koşullu dropdown yapacağımız için kullanmıyoruz
    <gfs_fc>-drdn_field = 'DD_HANDLE'.
    APPEND gs_fcat TO gt_fcat.
  ENDIF.

  READ TABLE gt_fcat ASSIGNING <gfs_fc> WITH KEY fieldname = 'CARRNAME'.
  IF sy-subrc EQ 0.
    <gfs_fc>-hotspot = abap_true.
    APPEND gs_fcat TO gt_fcat.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form SET_LAYOUT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_layout . " layout da verilen kararlar bütün alv yi etkiler
  CLEAR: gs_layout.
  gs_layout-cwidth_opt = abap_true.
**  gs_layout-edit = abap_true.
  gs_layout-no_toolbar = abap_true.  "toolbar ı kaldırır.
**  <gs_layout-zebra = abap_true.  "editlenebilir ve renklendirilen satıra etki etmez.
  gs_layout-info_fname = 'LINE_COLOR'.
  gs_layout-ctab_fname = 'CELL_COLOR'.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form GET_TOTAL_SUM
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_total_sum .   "tek başına işe yaramaz arkaplandaki işlemleri de yapmamız lazım
  DATA: lv_ttl_sum TYPE int4,
        lv_lines   TYPE int4,
        lv_avr     TYPE int4.

  LOOP AT gt_scarr INTO gs_scarr.
    lv_ttl_sum = lv_ttl_sum + gs_scarr-fiyat.
  ENDLOOP.

  DESCRIBE TABLE gt_scarr LINES lv_lines.  " kaç satır olduğunu tutar

  lv_avr = lv_ttl_sum / lv_lines.

  LOOP AT gt_scarr ASSIGNING <gfs_scarr>.
    IF <gfs_scarr>-fiyat > lv_avr.
      <gfs_scarr>-durum = '@08@'.
    ELSEIF <gfs_scarr>-fiyat = lv_avr.
      <gfs_scarr>-durum = '@09@'.
    ELSE .
      <gfs_scarr>-durum = '@0A@'.
    ENDIF.
  ENDLOOP.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form SET_DROPDOWN
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_dropdown .
  DATA: lt_dropdown TYPE lvc_t_drop,
        ls_dropdown TYPE lvc_s_drop.

  CLEAR: ls_dropdown.
  ls_dropdown-handle = 1.
  ls_dropdown-value = 'Yurtiçi'.
  APPEND ls_dropdown TO lt_dropdown.

  CLEAR: ls_dropdown.
  ls_dropdown-handle = 1.
  ls_dropdown-value = 'Yurtdışı'.
  APPEND ls_dropdown TO lt_dropdown.

  CLEAR: ls_dropdown.
  ls_dropdown-handle = 2.
  ls_dropdown-value = 'A'.
  APPEND ls_dropdown TO lt_dropdown.

  CLEAR: ls_dropdown.
  ls_dropdown-handle = 2.
  ls_dropdown-value = 'B'.
  APPEND ls_dropdown TO lt_dropdown.

  CLEAR: ls_dropdown.
  ls_dropdown-handle = 2.
  ls_dropdown-value = 'C'.
  APPEND ls_dropdown TO lt_dropdown.

  CLEAR: ls_dropdown.
  ls_dropdown-handle = 2.
  ls_dropdown-value = 'D'.
  APPEND ls_dropdown TO lt_dropdown.

  CLEAR: ls_dropdown.
  ls_dropdown-handle = 2.
  ls_dropdown-value = 'E'.
  APPEND ls_dropdown TO lt_dropdown.

  CLEAR: ls_dropdown.
  ls_dropdown-handle = 3.
  ls_dropdown-value = 'Ön'.
  APPEND ls_dropdown TO lt_dropdown.

  CLEAR: ls_dropdown.
  ls_dropdown-handle = 3.
  ls_dropdown-value = 'Kanat'.
  APPEND ls_dropdown TO lt_dropdown.

  CLEAR: ls_dropdown.
  ls_dropdown-handle = 3.
  ls_dropdown-value = 'Arka'.
  APPEND ls_dropdown TO lt_dropdown.

  CLEAR: ls_dropdown.
  ls_dropdown-handle = 4.
  ls_dropdown-value = 'Ön'.
  APPEND ls_dropdown TO lt_dropdown.

  CLEAR: ls_dropdown.
  ls_dropdown-handle = 4.
  ls_dropdown-value = 'Arka'.
  APPEND ls_dropdown TO lt_dropdown.

  CLEAR: ls_dropdown.
  ls_dropdown-handle = 5.
  ls_dropdown-value = 'Kanat'.
  APPEND ls_dropdown TO lt_dropdown.

  go_alv->set_drop_down_table(
    EXPORTING
      it_drop_down       =  lt_dropdown
      ).

ENDFORM.
