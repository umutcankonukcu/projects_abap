*&---------------------------------------------------------------------*
*& Report ZUK_EGT_014
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zuk_egt_014.

DATA: gt_scarr TYPE TABLE OF scarr,
      gs_scarr TYPE scarr.

START-OF-SELECTION.

  SELECT * FROM scarr
  INTO TABLE gt_scarr.

*  READ TABLE gt_scarr INTO gs_scarr WITH KEY carrid = 'AZ'.
  READ TABLE gt_scarr INTO gs_scarr WITH KEY currcode = 'EUR'
                                             carrname = 'Alitalia'.
  WRITE gs_scarr.
  ULINE.
  ULINE.

  LOOP AT gt_scarr INTO gs_scarr WHERE currcode = 'EUR'.   " euro olan bütün satırları yazdırmak için yazdırılır.
      WRITE gs_scarr.
  ENDLOOP.
