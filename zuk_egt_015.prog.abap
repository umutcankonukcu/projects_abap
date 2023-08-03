*&---------------------------------------------------------------------*
*& Report ZUK_EGT_015
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZUK_EGT_015.

*DATA: gt_scarr TYPE TABLE OF scarr.
*      gt_scarr2 TYPE TABLE  OF scarr.
*START-OF-SELECTION.
*
*SELECT carrid carrname FROM scarr
*   INTO TABLE gt_scarr.
*
*  SELECT carrid carrname FROM scarr          "aynı sayıda kolon olmazsa bile corresponding yapısı ile istenilen yerlere veri girişi olur.
*    INTO CORRESPONDING FIELDS OF gt_scarr2.
*
*
   TYPES: BEGIN OF gty_type1,
            col1 TYPE char10,
            col2 TYPE char10,
            col3 TYPE char10,
            col4 TYPE char10,
          END OF gty_type1.

   TYPES: BEGIN OF gty_type2,
            col2 TYPE char10,
            col3 TYPE char10,
          END OF gty_type2.


   DATA: gs_st1 TYPE gty_type1,
         gs_st2 TYPE gty_type2,
         gs_st3 TYPE gty_type2.


    START-OF-SELECTION.

     gs_st1-col1 = 'aaaa'.
     gs_st1-col2 = 'bbbb'.
     gs_st1-col3 = 'cccc'.
     gs_st1-col4 = 'dddd'.


     MOVE-CORRESPONDING gs_st1 TO gs_st2.
     MOVE gs_st1 TO gs_st3.
