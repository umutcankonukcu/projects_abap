*&---------------------------------------------------------------------*
*& Include          ZUK_EGT_016_TOP
*&---------------------------------------------------------------------*
TYPE-POOLS icon.


DATA: go_alv TYPE REF TO cl_gui_alv_grid,
      go_cust TYPE REF TO cl_gui_custom_container.

*DATA: go_alv2 TYPE REF TO cl_gui_alv_grid,
*      go_cust2 TYPE REF TO cl_gui_custom_container.

TYPES: BEGIN OF gty_scarr,
         durum      TYPE icon_d,
         carrid     TYPE s_carr_id,
         carrname   TYPE s_carrname,
         currcode   TYPE s_currcode,
         mess       TYPE char200,
         url        TYPE s_carrurl,
         line_color TYPE char4,
         cell_color TYPE lvc_t_scol,
         fiyat      TYPE int4,
         location   TYPE char20,
         seat1      TYPE char1,
         seatp      TYPE char10,
         dd_handle  TYPE int4,
       END OF gty_scarr.


DATA: gs_cell_color TYPE lvc_s_scol.

DATA: gt_scarr  TYPE TABLE OF gty_scarr,
      gs_scarr  TYPE gty_scarr,
      gt_sflight TYPE TABLE OF sflight,
      gs_sflight TYPE sflight,
      gt_fcat   TYPE  lvc_t_fcat,
      gs_fcat   TYPE  lvc_s_fcat,
      gt_fcat2   TYPE  lvc_t_fcat,
      gs_fcat2   TYPE  lvc_s_fcat,
      gs_layout TYPE lvc_s_layo.


FIELD-SYMBOLS: <gfs_fc>    TYPE lvc_s_fcat,
               <gfs_scarr> TYPE gty_scarr.


*CLASS cl_event_receiver DEFINITION DEFERRED.

*DATA: go_event_receiver TYPE REF TO cl_event_receiver.

DATA: go_spli TYPE REF TO cl_gui_splitter_container,
      go_sub1 TYPE REF TO cl_gui_container,
      go_sub2 TYPE REF TO cl_gui_container.
