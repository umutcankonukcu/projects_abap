*&---------------------------------------------------------------------*
*& Include          ZUK_ODEV5_FORM
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form GET_DATA
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_data .
  CLEAR gs_list.
  REFRESH gt_list.

  SELECT
    t001~bukrs,
    t001~butxt,
    bnka~banka,
    t012~hbkid,
    t012k~hktid,
    t012t~text1,
    t012k~waers,
    t012k~hkont,
    skat~txt50
    FROM t001
      INNER JOIN t012
        ON t012~bukrs = t001~bukrs
      INNER JOIN bnka
        ON bnka~banks = t012~banks
       AND bnka~bankl = t012~bankl
      INNER JOIN t012k
        ON t012k~bukrs = t012~bukrs
       AND t012k~hbkid = t012~hbkid
      INNER JOIN skat
        ON skat~spras = 'T'
       AND skat~ktopl = t001~ktopl
       AND skat~saknr = t012k~hkont
      LEFT JOIN t012t
        ON t012t~bukrs = t012k~bukrs
       AND t012t~hbkid = t012k~hbkid
    INTO TABLE @DATA(gt_data)
    WHERE t001~bukrs  EQ @p_bukrs
      AND t012~hbkid  IN @s_hbkid
      AND t012k~waers IN @s_waers.


  LOOP AT gt_data INTO DATA(gs_data).
    MOVE-CORRESPONDING gs_data TO gs_list.
    APPEND gs_list TO gt_list.
  ENDLOOP.

  MOVE-CORRESPONDING gt_data TO gt_list.


  TYPES: BEGIN OF ty_tabname,
           col_name TYPE char20,
         END OF ty_tabname.

  DATA: t_tabname TYPE STANDARD TABLE OF fieldname,
        s_tabname TYPE fieldname,
        v_sayac   TYPE numc2.

  CLEAR:s_tabname.
  s_tabname = 'HSLVT'.
  APPEND s_tabname TO t_tabname.

  CLEAR:s_tabname.
  s_tabname = 'TSLVT'.
  APPEND s_tabname TO t_tabname.

  CLEAR:s_tabname.
  s_tabname = 'RBUKRS'.
  APPEND s_tabname TO t_tabname.

  CLEAR:s_tabname.
  s_tabname = 'RACCT'.
  APPEND s_tabname TO t_tabname.

  CLEAR:s_tabname.
  s_tabname = 'HBKID'.
  APPEND s_tabname TO t_tabname.

  CLEAR: v_sayac.
  DO p_donem TIMES.
    ADD 1 TO v_sayac.

    CONCATENATE 'HSL' v_sayac INTO s_tabname.
    APPEND s_tabname TO t_tabname.

    CONCATENATE 'TSL' v_sayac INTO s_tabname.
    APPEND s_tabname TO t_tabname.
  ENDDO.

  SELECT (t_tabname)
    FROM faglflext AS fagl
    INNER JOIN t012k ON t012k~hkont EQ fagl~racct
    INTO CORRESPONDING FIELDS OF TABLE t_faglflext
    WHERE ryear EQ p_yil
      AND rbukrs EQ p_bukrs
      AND rldnr EQ '0L'.


  LOOP AT gt_list ASSIGNING FIELD-SYMBOL(<list>).
    LOOP AT t_faglflext INTO s_faglflext WHERE hbkid = <list>-hbkid
                                           AND racct = <list>-hkont.

      s_banka_tutar-hbkid = s_faglflext-hbkid.

      <list>-hslxx = <list>-hslxx + s_faglflext-hslvt + s_faglflext-hsl01 + s_faglflext-hsl02 +
                     s_faglflext-hsl03 + s_faglflext-hsl04 + s_faglflext-hsl05 +
                     s_faglflext-hsl06 + s_faglflext-hsl07 + s_faglflext-hsl08 +
                     s_faglflext-hsl09 + s_faglflext-hsl10 + s_faglflext-hsl11 + s_faglflext-hsl12.

      <list>-tslxx =  <list>-tslxx + s_faglflext-tslvt + s_faglflext-tsl01 + s_faglflext-tsl02 +
                      s_faglflext-tsl03 + s_faglflext-tsl04 + s_faglflext-tsl05 +
                      s_faglflext-tsl06 + s_faglflext-tsl07 + s_faglflext-tsl08 +
                      s_faglflext-tsl09 + s_faglflext-tsl10 + s_faglflext-tsl11 + s_faglflext-tsl12.
    ENDLOOP.
    MODIFY gt_list FROM <list>.
  ENDLOOP.































*  LOOP AT gt_struc INTO gs_struc.
*
*    LOOP AT gt_list REFERENCE INTO DATA(gs_list) WHERE  hbkid = gs_struc-hbkid AND racct = gs_struc-hkont .
*
*      gs_struc-hslxx = gs_struc-hslxx + gs_list-hslvt + gs_list-hsl01 + gs_list-hsl02 +
*                       gs_list-hsl03 + gs_list-hsl04 + gs_list-hsl05 +
*                       gs_list-hsl06 + gs_list-hsl07 + gs_list-hsl08 +
*                       gs_list-hsl09 + gs_list-hsl10 + gs_list-hsl11 + gs_list-hsl12.
*
*      gs_struc-tslxx =  gs_struc-tslxx + gs_list-tslvt + gs_list-tsl01 + gs_list-tsl02 +
*                        gs_list-tsl03 + gs_list-tsl04 + gs_list-tsl05 +
*                        gs_list-tsl06 + gs_list-tsl07 + gs_list-tsl08 +
*                        gs_list-tsl09 + gs_list-tsl10 + gs_list-tsl11 + gs_list-tsl12.
*
*    ENDLOOP.
*
*    MODIFY gt_struc FROM gs_struc.
*
*  ENDLOOP.




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
  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
*     I_BUFFER_ACTIVE        =
      i_structure_name       = 'ZUK_S_ODEV5'
*     I_CLIENT_NEVER_DISPLAY = 'X'
*     I_BYPASSING_BUFFER     =
*     I_INTERNAL_TABNAME     =
    CHANGING
      ct_fieldcat            = gt_fcat
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.
  IF sy-subrc <> 0.
* Implement suitable error handling here
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
FORM set_layout .
  CLEAR: gs_layout.
  gs_layout-cwidth_opt = 'X'.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form DISPLAY_ALV
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM display_alv .

  CREATE OBJECT go_alv
    EXPORTING
      i_parent = cl_gui_container=>screen0.

  IF sy-subrc <> 0.
*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*     WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
  ENDIF.

  CALL METHOD go_alv->set_table_for_first_display
    EXPORTING
      is_layout                     = gs_layout
    CHANGING
      it_outtab                     = gt_list
      it_fieldcatalog               = gt_fcat[]
    EXCEPTIONS
      invalid_parameter_combination = 1
      program_error                 = 2
      too_many_lines                = 3
      OTHERS                        = 4.

ENDFORM.
