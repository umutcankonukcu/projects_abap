*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZUK_KTPHN_TUR...................................*
DATA:  BEGIN OF STATUS_ZUK_KTPHN_TUR                 .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZUK_KTPHN_TUR                 .
CONTROLS: TCTRL_ZUK_KTPHN_TUR
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZUK_KTPHN_TUR                 .
TABLES: ZUK_KTPHN_TUR                  .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
