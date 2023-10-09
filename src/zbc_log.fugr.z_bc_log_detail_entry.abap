FUNCTION z_bc_log_detail_entry .
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

  PERFORM clear_stack.

  READ TABLE i_t_params TRANSPORTING NO FIELDS
    WITH KEY parname = zcl_log_attachment=>mc_bal_param_guid.
  CHECK sy-subrc EQ 0.

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

  CALL FUNCTION 'Z_BC_LOG_GET_TAB_HASH'
    EXPORTING
      iv_logn = lv_logn
      it_fcat = lt_fcat
    IMPORTING
      ev_hash = lv_hash.

  ASSIGN ld_data->* TO FIELD-SYMBOL(<l_data>).
  PERFORM push_data USING <l_data>.

  CALL FUNCTION 'Z_BC_LOG_ANY_VIEW'
    EXPORTING
      i_data  = <g_data>
      iv_hash = lv_hash
      it_fcat = lt_fcat.

  PERFORM pop_data.
ENDFUNCTION.
