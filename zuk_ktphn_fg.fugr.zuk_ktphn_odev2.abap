FUNCTION zuk_ktphn_odev2.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IV_TABLE_VALUES) TYPE  ZUK_KTPHN_OGR OPTIONAL
*"     REFERENCE(IV_TABLE_VALUES2) TYPE  ZUK_KTPHN_ISLEM OPTIONAL
*"     REFERENCE(IV_TABLE_VALUES3) TYPE  ZUK_KTPHN_KITAP OPTIONAL
*"     REFERENCE(IV_TABLE_VALUES4) TYPE  ZUK_KTPHN_YAZAR OPTIONAL
*"----------------------------------------------------------------------


  IF iv_table_values IS NOT INITIAL  .
      MODIFY zuk_ktphn_ogr FROM iv_table_values.
  ENDIF.

  IF iv_table_values2 IS NOT INITIAL.
  MODIFY zuk_ktphn_islem FROM iv_table_values2.
  ENDIF.

  IF iv_table_values3 IS NOT INITIAL.
    MODIFY zuk_ktphn_kitap FROM iv_table_values3.
  ENDIF.

  IF iv_table_values4 IS NOT INITIAL.
    MODIFY zuk_ktphn_yazar FROM iv_table_values4.
  ENDIF.


ENDFUNCTION.
