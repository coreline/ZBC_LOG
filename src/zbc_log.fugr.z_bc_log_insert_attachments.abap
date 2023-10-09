FUNCTION z_bc_log_insert_attachments.
*"----------------------------------------------------------------------
*"*"Локальный интерфейс:
*"  IMPORTING
*"     VALUE(IV_NEW_TASK) TYPE  FLAG DEFAULT SPACE
*"     VALUE(IS_DATA) TYPE  ZTBC_LOG_DATA
*"----------------------------------------------------------------------
  CONSTANTS lc_task TYPE string VALUE 'Z_BC_LOG_INSERT_ATTACHMENTS'.
  DATA ls_data TYPE ztbc_log_data.

  IF iv_new_task EQ abap_true. " Сохраняем вложения в aRFC (или sRFC)
    CALL FUNCTION 'Z_BC_LOG_INSERT_ATTACHMENTS' STARTING NEW TASK lc_task
      EXPORTING
        is_data          = is_data
      EXCEPTIONS
        resource_failure = 1.
    IF sy-subrc EQ 1.
      CALL FUNCTION 'Z_BC_LOG_INSERT_ATTACHMENTS' DESTINATION 'NONE'
        EXPORTING
          is_data = is_data.
    ENDIF.
  ELSE.
    INSERT ztbc_log_data FROM is_data.
    COMMIT WORK AND WAIT.
  ENDIF.
ENDFUNCTION.
