*&---------------------------------------------------------------------*
*& Include          ZUK_ODEV3_TOP
*&---------------------------------------------------------------------*

TYPE-POOLS icon.

TYPES: BEGIN OF gty_list,
         ogr_no      TYPE zuk_ogrno_de,
         ogr_ad      TYPE zuk_ograd_de,
         ogr_soyad   TYPE zuk_ogrsoyad_de,
         kitap_ad    TYPE zuk_kitapad_de,
         yazar_ad    TYPE zuk_yazarad_de,
         yazar_soyad TYPE zuk_yazarsoyad_de,
         atarih      TYPE zuk_islematarih_de,
         vtarih      TYPE zuk_islemvtarih_de,
         ogr_puan    TYPE zuk_ogrpuan_de,
         line_color  TYPE char4,
         traffic(4)  TYPE c,
         yesil(4),
         sari(4),
         kirmizi(4),
       END OF gty_list.


DATA: gt_list TYPE TABLE OF gty_list,
      gs_list TYPE gty_list.





DATA: gt_fieldcat TYPE slis_t_fieldcat_alv,
      gs_fieldcat TYPE slis_fieldcat_alv,
      gs_layout   TYPE slis_layout_alv.
