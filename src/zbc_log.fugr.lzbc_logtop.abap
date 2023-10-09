FUNCTION-POOL zbc_log.                      "MESSAGE-ID ..

* INCLUDE LZBC_LOGD...                       " Local class definition

INCLUDE sbal_constants.

TYPES lty_data TYPE REF TO data.
DATA:
  gt_data     TYPE TABLE OF lty_data,
  gt_data_alv TYPE TABLE OF lty_data.

FIELD-SYMBOLS:
  <g_data>     TYPE any,
  <g_data_alv> TYPE any.
