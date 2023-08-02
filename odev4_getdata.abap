FORM get_data .
  CLEAR gs_list.
  REFRESH gt_list.

  SELECT
    a~bukrs
    a~gjahr
    a~monat
    a~belnr
    b~lifnr
    c~iskonto
    b~wrbtr
    FROM bkpf AS a
   INNER JOIN bseg AS b
    ON b~bukrs EQ a~bukrs
   AND b~gjahr EQ a~gjahr
   AND b~belnr EQ a~belnr
   INNER JOIN zuk_t_iskonto
     AS c ON c~satici EQ b~lifnr
   INTO CORRESPONDING FIELDS OF TABLE gt_list
   WHERE a~bukrs IN s_bukrs
     AND a~gjahr IN s_gjahr
     AND a~monat IN s_monat
     AND b~lifnr IN s_lifnr.

  LOOP AT gt_list INTO gs_list.
    gs_list-iwrbtr = gs_list-wrbtr  - ( gs_list-wrbtr * gs_list-iskonto / 100 ).
    MODIFY gt_list FROM gs_list.
  ENDLOOP.

ENDFORM.