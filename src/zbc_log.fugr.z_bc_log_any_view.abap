FUNCTION z_bc_log_any_view.
*"----------------------------------------------------------------------
*"*"Локальный интерфейс:
*"  IMPORTING
*"     REFERENCE(I_DATA) TYPE  ANY
*"     REFERENCE(IV_HASH) TYPE  HASH160 OPTIONAL
*"     REFERENCE(IT_FCAT) TYPE  LVC_T_FCAT OPTIONAL
*"----------------------------------------------------------------------
  DATA(lt_fcat) = it_fcat.

  PERFORM push_data USING i_data.

  DESCRIBE FIELD i_data TYPE DATA(lv_type).
  DO 1 TIMES.
    CHECK lv_type CA 'uv/h'. " Struct/Internal table
    CHECK lt_fcat IS INITIAL.
    PERFORM create_fcat USING i_data CHANGING lt_fcat.
  ENDDO.

  IF lv_type CA 'IPF/CDNTg/Xy'.   " Element: Numeric/Clike/Xlike
    CALL FUNCTION 'Z_BC_LOG_ELEM_VIEW'
      EXPORTING
        iv_data = i_data.
  ENDIF.
  IF lv_type CA 'uv'.             " Struct: Float/Deep
    CALL FUNCTION 'Z_BC_LOG_STRUCT_VIEW'
      EXPORTING
        iv_hash = iv_hash
        it_fcat = lt_fcat
        is_data = i_data.
  ENDIF.
  IF lv_type EQ 'h'.              " Internal table
    CALL FUNCTION 'Z_BC_LOG_TABLE_VIEW'
      EXPORTING
        iv_hash = iv_hash
        it_fcat = lt_fcat
        it_data = i_data.
  ENDIF.

  PERFORM pop_data.
ENDFUNCTION.
