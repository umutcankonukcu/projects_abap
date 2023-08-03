*&---------------------------------------------------------------------*
*& Include          ZUK_ODEV4_TOP
*&---------------------------------------------------------------------*


TABLES: bkpf, bseg ,zuk_t_iskonto.

DATA: go_alv TYPE REF TO cl_gui_alv_grid.

DATA: gt_bkpf TYPE TABLE OF bkpf,
      gs_bkpf TYPE bkpf.

TYPES: BEGIN OF gty_list,
         selkz   TYPE char1,
         bukrs   TYPE bkpf-bukrs,
         gjahr   TYPE bkpf-gjahr,
         monat   TYPE bkpf-monat,
         belnr   TYPE bkpf-belnr,
         lifnr   TYPE bseg-lifnr,
         iskonto TYPE zuk_t_iskonto-iskonto,
         iwrbtr  TYPE wrbtr,
         wrbtr   TYPE bseg-wrbtr,
       END OF gty_list.

TYPES: BEGIN OF gty_list2,
         bukrs TYPE bkpf-bukrs,
         gjahr TYPE bkpf-gjahr,
         belnr TYPE bkpf-belnr,
         buzei TYPE bseg-buzei,
         sgtxt TYPE bseg-sgtxt,
         gsber TYPE bseg-gsber,
         shkzg TYPE bseg-shkzg,
         wrbtr TYPE bseg-wrbtr,
       END OF gty_list2.


DATA: gt_list TYPE TABLE OF gty_list,
      gs_list TYPE gty_list.

DATA: gt_fc     TYPE slis_t_fieldcat_alv,
      gs_fc     TYPE slis_fieldcat_alv,
      gs_layout TYPE slis_layout_alv.

DATA: gt_fc2     TYPE slis_t_fieldcat_alv,
      gs_fc2     TYPE slis_fieldcat_alv,
      gs_layout2 TYPE slis_layout_alv.

DATA: gt_listpop TYPE TABLE OF gty_list2,
      gs_listpop TYPE gty_list2.

DATA: gt_bakim TYPE TABLE OF zeg_t_stiskbakim,
      gs_bakim TYPE zeg_t_stiskbakim.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.

SELECT-OPTIONS:  s_bukrs FOR bkpf-bukrs,
                 s_gjahr FOR bkpf-gjahr,
                 s_monat FOR bkpf-monat,
                 s_lifnr FOR bseg-lifnr.
SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-002.

SELECTION-SCREEN:
PUSHBUTTON 1(20) TEXT-bt1 USER-COMMAND bt1 MODIF ID id1,
PUSHBUTTON 30(20) TEXT-bt2 USER-COMMAND bt2 MODIF ID id2.


SELECTION-SCREEN END OF BLOCK b2.
