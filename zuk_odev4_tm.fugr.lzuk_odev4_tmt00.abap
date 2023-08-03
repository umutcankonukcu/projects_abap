*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZUK_T_ISKONTO...................................*
DATA:  BEGIN OF STATUS_ZUK_T_ISKONTO                 .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZUK_T_ISKONTO                 .
CONTROLS: TCTRL_ZUK_T_ISKONTO
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZUK_T_ISKONTO                 .
TABLES: ZUK_T_ISKONTO                  .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
