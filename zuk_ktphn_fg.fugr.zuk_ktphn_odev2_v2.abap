FUNCTION ZUK_KTPHN_ODEV2_V2.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IV_TABLE_VALUES_V2) TYPE  ZUK_KTPHN_OGR
*"     REFERENCE(IV_TABLE_VALUES2_V2) TYPE  ZUK_KTPHN_ISLEM
*"     REFERENCE(IV_TABLE_VALUES3_V2) TYPE  ZUK_KTPHN_KITAP
*"     REFERENCE(IV_TABLE_VALUES4_V2) TYPE  ZUK_KTPHN_YAZAR
*"----------------------------------------------------------------------



*
*  IF iv_table_values IS NOT INITIAL  .
*      MODIFY zuk_ktphn_ogr FROM iv_table_values.
*  ENDIF.
*
*  IF iv_table_values2 IS NOT INITIAL.
*  MODIFY zuk_ktphn_islem FROM iv_table_values2.
*  ENDIF.
*
*  IF iv_table_values3 IS NOT INITIAL.
*    MODIFY zuk_ktphn_kitap FROM iv_table_values3.
*  ENDIF.
*
*  IF iv_table_values4 IS NOT INITIAL.
*    MODIFY zuk_ktphn_yazar FROM iv_table_values4.
*  ENDIF.
*



ENDFUNCTION.
