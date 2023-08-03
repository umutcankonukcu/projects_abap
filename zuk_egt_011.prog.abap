*&---------------------------------------------------------------------*
*& Report ZUK_EGT_011
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zuk_egt_011.

DATA: gt_sbook TYPE TABLE OF sbook,
      go_salv  TYPE REF TO cl_salv_table.

START-OF-SELECTION.

  SELECT * UP TO 20 ROWS FROM sbook
    INTO TABLE gt_sbook.

  cl_salv_table=>factory(

    IMPORTING
      r_salv_table   = go_salv
    CHANGING
      t_table        = gt_sbook
   ).




  DATA: lo_display TYPE REF TO cl_salv_display_settings.

  lo_display = go_salv->get_display_settings( ).
*  tablonun başlığınının metnini değiştirir.
  lo_display->set_list_header( value = 'SALV Eğitim' ).
  lo_display->set_striped_pattern( value = 'X' ).



  DATA: lo_cols TYPE REF TO cl_salv_columns.

  lo_cols = go_salv->get_columns( ).
*  set_optimize kolonların genişliklerini olabildiği kadar azaltarak düzenler.
  lo_cols->set_optimize( value = 'X' ).


  DATA: lo_col TYPE REF TO cl_salv_column.
  TRY.
*  tablodan fatura kolonun ismininin invoice olduğunu öğrendik
      lo_col = lo_cols->get_column( columnname = 'INVOICE' ).
      lo_col->set_long_text( value = ' YENİ fatura Düzenleyici' ).
      lo_col->set_medium_text( value = 'YENİ FATURA D.' ).
      lo_col->set_short_text( value = 'Yeni F. D.' ).
    CATCH cx_salv_not_found.
  ENDTRY.


  TRY.
      lo_col = lo_cols->get_column( columnname = 'MANDT' ).
      lo_col->set_visible(
*    tablodan MANDT kolonunun görünürlüğünü kapattık
          value = if_salv_c_bool_sap=>false
      ).


    CATCH cx_salv_not_found.
  ENDTRY.

  DATA: lo_func TYPE REF TO cl_salv_functions.

  lo_func = go_salv->get_functions( ).
  lo_func->set_all( abap_true ).


DATA: lo_header TYPE REF TO cl_salv_form_layout_grid,
      lo_h_label TYPE REF TO cl_salv_form_label,
      lo_h_flow TYPE REF TO cl_salv_form_layout_flow.

CREATE OBJECT lo_header.

lo_h_label = lo_header->create_label( row         = 1  column      = 1 ).
  lo_h_label->set_text( value = 'Başlık İlk Satır' ).
  lo_h_flow = lo_header->create_flow( row = 2  column  = 1 ).
  lo_h_flow->create_text( text = 'Başlık İkinci Satır' ).
  go_salv->set_top_of_list( value = lo_header ).
  go_salv->display( ).
