FUNCTION z_bc_log_table_view.
*"----------------------------------------------------------------------
*"*"Локальный интерфейс:
*"  IMPORTING
*"     REFERENCE(IV_HASH) TYPE  HASH160
*"     REFERENCE(IT_DATA) TYPE  STANDARD TABLE
*"     REFERENCE(IT_FCAT) TYPE  LVC_T_FCAT
*"----------------------------------------------------------------------
  DATA lt_fcat TYPE lvc_t_fcat.
  DATA ls_layout TYPE lvc_s_layo.
  DATA ls_variant TYPE disvariant.
  DATA lv_save TYPE c VALUE space.
  DATA lo_data TYPE REF TO data.
  FIELD-SYMBOLS <ls_fcat> TYPE lvc_s_fcat.
  FIELD-SYMBOLS <lt_data> TYPE STANDARD TABLE.

  CHECK it_fcat IS NOT INITIAL.

  CREATE DATA lo_data LIKE it_data.
  ASSIGN lo_data->* TO <lt_data>.

  <lt_data> = it_data.
  lt_fcat = it_fcat.
  DELETE lt_fcat WHERE inttype CA 'uv/h'. " Structure / Internal table

  LOOP AT lt_fcat ASSIGNING <ls_fcat>.
    IF <ls_fcat>-fieldname EQ '_TABLE_LINE_'.
      <ls_fcat>-reptext = 'TABLE_LINE'.
    ELSE.
      <ls_fcat>-reptext = <ls_fcat>-fieldname.
    ENDIF.
    <ls_fcat>-colddictxt = 'R'.  " Поле заголовка: (R)eptext_ddic, (S)hort, (M)iddle, (L)ong
  ENDLOOP.

  IF iv_hash IS NOT INITIAL.
    lv_save = 'A'.
    ls_variant-report = |ZBC_LOG_{ iv_hash }|.
  ENDIF.

  ls_layout-sel_mode = 'A'.
  ls_layout-col_opt = 'X'.
  ls_layout-cwidth_opt = 'X'.
  ls_layout-zebra = 'X'.

  PERFORM push_data_alv USING <lt_data>.
  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY_LVC'
    EXPORTING
      i_save                  = lv_save
      is_variant              = ls_variant
      is_layout_lvc           = ls_layout
      it_fieldcat_lvc         = lt_fcat
      i_callback_program      = sy-repid
      i_callback_user_command = 'USER_COMMAND'
    TABLES
      t_outtab                = <lt_data>
    EXCEPTIONS
      program_error           = 1
      OTHERS                  = 2.
  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
               WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.
  PERFORM pop_data_alv.
ENDFUNCTION.
