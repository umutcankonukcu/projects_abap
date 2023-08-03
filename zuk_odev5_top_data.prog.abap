*&---------------------------------------------------------------------*
*& Include          ZUK_ODEV5_TOP_DATA
*&---------------------------------------------------------------------*
TABLES: t001, bnka, t012, t012k, skat, faglflext.

DATA: go_alv TYPE REF TO cl_gui_alv_grid.

TYPES: BEGIN OF gty_list,
         bukrs TYPE t001-bukrs,
         butxt TYPE t001-butxt,
         banka TYPE bnka-banka,
         hbkid TYPE t012-hbkid,
         hktid TYPE t012k-hktid,
         text1 TYPE t012t-text1,
         waers TYPE t012k-waers,
         hkont TYPE t012k-hkont,
         txt50 TYPE skat-txt50,
         tslvt TYPE faglflext-tslvt,
         hslvt TYPE faglflext-hslvt,
       END OF gty_list.

TYPES: BEGIN OF ty_faglflext,
         rbukrs TYPE faglflext-rbukrs,
         hslvt  TYPE faglflext-hslvt,
         hsl01  TYPE faglflext-hsl01,
         hsl02  TYPE faglflext-hsl02,
         hsl03  TYPE faglflext-hsl03,
         hsl04  TYPE faglflext-hsl04,
         hsl05  TYPE faglflext-hsl05,
         hsl06  TYPE faglflext-hsl06,
         hsl07  TYPE faglflext-hsl07,
         hsl08  TYPE faglflext-hsl08,
         hsl09  TYPE faglflext-hsl09,
         hsl10  TYPE faglflext-hsl10,
         hsl11  TYPE faglflext-hsl11,
         hsl12  TYPE faglflext-hsl12,
         tslvt  TYPE faglflext-tslvt,
         tsl01  TYPE faglflext-tsl01,
         tsl02  TYPE faglflext-tsl02,
         tsl03  TYPE faglflext-tsl03,
         tsl04  TYPE faglflext-tsl04,
         tsl05  TYPE faglflext-tsl05,
         tsl06  TYPE faglflext-tsl06,
         tsl07  TYPE faglflext-tsl07,
         tsl08  TYPE faglflext-tsl08,
         tsl09  TYPE faglflext-tsl09,
         tsl10  TYPE faglflext-tsl10,
         tsl11  TYPE faglflext-tsl11,
         tsl12  TYPE faglflext-tsl12,
         hbkid  TYPE t012k-hbkid,
         racct  TYPE faglflext-racct,
       END OF ty_faglflext,

       BEGIN OF ty_banka_tutar,
         hbkid TYPE t012k-hbkid,
         tutar TYPE faglflext-hsl02,
       END OF  ty_banka_tutar.

DATA: t_faglflext   TYPE STANDARD TABLE OF ty_faglflext,
      s_faglflext   TYPE ty_faglflext,
      t_banka_tutar TYPE STANDARD TABLE OF ty_banka_tutar,
      s_banka_tutar TYPE ty_banka_tutar.

DATA: gt_struc TYPE TABLE OF zuk_s_odev5,
      gs_struc TYPE zuk_s_odev5.


DATA: gt_list TYPE TABLE OF zuk_s_odev5,
      gs_list TYPE zuk_s_odev5.

DATA: gt_fcat   TYPE lvc_t_fcat,
      gs_fcat   TYPE lvc_s_fcat,
      gs_layout TYPE lvc_s_layo.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
PARAMETERS: p_bukrs TYPE t001-bukrs OBLIGATORY DEFAULT 'MR01',
            p_donem TYPE poper DEFAULT sy-datum+4(2) OBLIGATORY,
            p_yıl   TYPE gjahr DEFAULT sy-datum(4) OBLIGATORY.

SELECT-OPTIONS: s_hbkid FOR t012-hbkid,
                s_waers FOR t012k-waers.
SELECTION-SCREEN END OF BLOCK b1.
