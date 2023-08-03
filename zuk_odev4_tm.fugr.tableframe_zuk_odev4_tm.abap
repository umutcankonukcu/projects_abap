*---------------------------------------------------------------------*
*    program for:   TABLEFRAME_ZUK_ODEV4_TM
*   generation date: 24.07.2023 at 03:23:57
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
FUNCTION TABLEFRAME_ZUK_ODEV4_TM       .

  PERFORM TABLEFRAME TABLES X_HEADER X_NAMTAB DBA_SELLIST DPL_SELLIST
                            EXCL_CUA_FUNCT
                     USING  CORR_NUMBER VIEW_ACTION VIEW_NAME.

ENDFUNCTION.
