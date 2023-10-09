FUNCTION z_bc_log_exception_view.
*"----------------------------------------------------------------------
*"*"Локальный интерфейс:
*"  TABLES
*"      I_T_PARAMS TYPE  BAL_T_PAR
*"----------------------------------------------------------------------
  DATA ld_data TYPE REF TO data.
  DATA lv_hash TYPE hash160.
  DATA lv_guid TYPE guid_22.
  DATA lv_logn TYPE balognr.
  DATA lt_fcat TYPE lvc_t_fcat.
  DATA ls_layout TYPE lvc_s_layo.
  DATA ls_variant TYPE disvariant.
  FIELD-SYMBOLS <ls_fcat> TYPE lvc_s_fcat.
  FIELD-SYMBOLS <lt_data> TYPE zcl_log_attachment=>mtt_exception.

  PERFORM clear_stack.

  lv_guid = i_t_params[ parname = zcl_log_attachment=>mc_bal_param_guid ]-parvalue.
  lv_logn = i_t_params[ parname = bal_param_lognumber ]-parvalue.

  CHECK lv_guid IS NOT INITIAL.
  CHECK lv_logn IS NOT INITIAL.

  CALL METHOD zcl_log_attachment=>import
    EXPORTING
      iv_guid = lv_guid
    IMPORTING
      et_fcat = lt_fcat
      ed_data = ld_data.
  CHECK ld_data IS NOT INITIAL.
  ASSIGN ld_data->* TO <lt_data>.
  ASSERT sy-subrc EQ 0.

  PERFORM push_data USING <lt_data>.

  CALL FUNCTION 'Z_BC_LOG_GET_TAB_HASH'
    EXPORTING
      iv_logn = lv_logn
      it_fcat = lt_fcat
    IMPORTING
      ev_hash = lv_hash.

  LOOP AT lt_fcat ASSIGNING <ls_fcat>.
    <ls_fcat>-reptext = <ls_fcat>-fieldname.
    <ls_fcat>-colddictxt = 'R'.  " Поле заголовка: (R)eptext_ddic, (S)hort, (M)iddle, (L)ong
  ENDLOOP.

  ls_variant-report = |ZBC_LOG_{ lv_hash }|.

  ls_layout-sel_mode = 'A'.
  ls_layout-col_opt = 'X'.
  ls_layout-cwidth_opt = 'X'.
  ls_layout-zebra = 'X'.

  PERFORM push_data_alv USING <lt_data>.
  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY_LVC'
    EXPORTING
      i_save                  = 'A'
      is_variant              = ls_variant
      is_layout_lvc           = ls_layout
      it_fieldcat_lvc         = lt_fcat
      i_callback_program      = sy-repid
      i_callback_user_command = 'USER_COMMAND_EXC'
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
