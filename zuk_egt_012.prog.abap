*&---------------------------------------------------------------------*
*& Report ZUK_EGT_012
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*


REPORT zuk_egt_012.

* ekko ve ekpo tablolarını çekerek ortak keyleri kullan.
INCLUDE zuk_egt_012_top.
INCLUDE zuk_egt_012_frm.


INITIALIZATION.

gs_variant_get-report = sy-repid.

  CALL FUNCTION 'REUSE_ALV_VARIANT_DEFAULT_GET'

    CHANGING
      cs_variant          = gs_variant_get
   EXCEPTIONS
     WRONG_INPUT         = 1
     NOT_FOUND           = 2
     PROGRAM_ERROR       = 3
     OTHERS              = 4
            .
  IF sy-subrc EQ 0.
      p_vari = gs_variant_get-variant.
  ENDIF.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_vari.  "value'ye search help ekliyor ve basınca bu event çalışıyor.
  gs_variant_get-report = sy-repid.
  CALL FUNCTION 'REUSE_ALV_VARIANT_F4'
    EXPORTING
      is_variant                = gs_variant_get
   IMPORTING
     E_EXIT                    = gv_exit
     ES_VARIANT                = gs_variant_get
   EXCEPTIONS
     NOT_FOUND                 = 1
     PROGRAM_ERROR             = 2
     OTHERS                    = 3
            .
  IF sy-subrc IS INITIAL.
      p_vari = gs_variant_get-variant.
  ENDIF.


START-OF-SELECTION.
  PERFORM get_data.
  PERFORM set_fc.
  PERFORM set_layout.
  PERFORM display_alv.
