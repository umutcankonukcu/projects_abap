*&---------------------------------------------------------------------*
*& Include          ZUK_ODEV4_PAI
*&---------------------------------------------------------------------*

FORM user_command USING p_ucomm TYPE sy-ucomm
                        p_self TYPE slis_selfield..

*  DATA:ls_grid_settings TYPE lvc_s_glay.

  DATA:  lv_ind TYPE numc2.

  CASE p_ucomm.
    WHEN '&IC1'.

      IF p_self-fieldname = 'BELNR'.
        READ TABLE gt_list INTO gs_list INDEX p_self-tabindex.
        IF sy-subrc IS INITIAL.
          SET PARAMETER ID 'BLN' FIELD gs_list-belnr.
          SET PARAMETER ID 'BUK' FIELD gs_list-bukrs.
          SET PARAMETER ID 'GJR' FIELD gs_list-gjahr.
          CALL TRANSACTION 'FB03' AND SKIP FIRST SCREEN.
        ENDIF.
      ENDIF.

      LOOP AT gt_list INTO gs_list.
        gs_list-iwrbtr = gs_list-wrbtr  - ( gs_list-wrbtr * gs_list-iskonto / 100 ).
        IF gs_list-iskonto < 0.
          MESSAGE 'İskonto 0 dan Küçük olamaz' TYPE 'I'.
        ELSEIF gs_list-iskonto > 100.
          MESSAGE 'İskonto 100 den büyük olamaz'  TYPE 'I'.
        ELSE.
          MODIFY gt_list FROM gs_list.
          p_self-refresh = 'X'.
        ENDIF.
      ENDLOOP.

    WHEN '&DTY'.

      CLEAR gs_listpop.
      CLEAR gt_listpop.

      LOOP AT gt_list INTO gs_list WHERE selkz = 'X'.
        lv_ind = lv_ind + 1.
      ENDLOOP.

      IF lv_ind = 0.
        MESSAGE 'Bir satır seçin' TYPE 'I'.
      ELSEIF lv_ind = 1.

        SELECT *
                FROM bkpf
                INNER JOIN bseg ON
                   bseg~bukrs EQ bkpf~bukrs
                   AND bseg~gjahr EQ bkpf~gjahr
                   AND bseg~belnr EQ bkpf~belnr
              INTO CORRESPONDING FIELDS OF TABLE gt_listpop
              WHERE bkpf~belnr = gs_list-belnr.


        CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
          EXPORTING
            is_layout   = gs_layout2
            it_fieldcat = gt_fc2
          TABLES
            t_outtab    = gt_listpop.
        IF sy-subrc <> 0.

        ENDIF.
      ELSEIF lv_ind > 1.
        MESSAGE 'Birden fazla satır seçtiniz' TYPE 'I'.
      ENDIF.
  ENDCASE.

ENDFORM.
