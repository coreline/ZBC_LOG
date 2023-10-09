FUNCTION z_bc_log_details_view.
*"----------------------------------------------------------------------
*"*"Локальный интерфейс:
*"  TABLES
*"      I_T_PARAMS TYPE  BAL_T_PAR
*"----------------------------------------------------------------------
  CONSTANTS lc_block_length TYPE i VALUE 75.
  DATA lo_instance TYPE REF TO zif_log_details.
  DATA lt_values TYPE TABLE OF bal_s_par-parvalue.
  DATA(lv_class) = VALUE string( ).
  DATA(lv_length) = VALUE i( i_t_params[ parname = |LENGTH| ]-parvalue OPTIONAL ).
  DATA(lv_left) = lv_length.
  DATA(lv_parname) = VALUE bal_s_par-parname( ).
  DATA(lv_context) = ||.

  DO 3 TIMES.
    lv_parname = |CLASS{ condense( |{ sy-index }| ) }|.
    lv_class &&= |{ VALUE #( i_t_params[ parname = lv_parname ]-parvalue OPTIONAL ) }|.
  ENDDO.

  WHILE lv_left GT 0.
    lv_parname = condense( |{ sy-index }| ).
    lv_left -= lc_block_length.
    lt_values = VALUE #( BASE lt_values ( i_t_params[ parname = lv_parname ]-parvalue ) ).
  ENDWHILE.
  CONCATENATE LINES OF lt_values
    INTO lv_context RESPECTING BLANKS.
  lv_context = lv_context(lv_length).

  CALL METHOD (lv_class)=>zif_log_details~create
    EXPORTING
      iv_key      = CONV xstring( lv_context )
    RECEIVING
      ro_instance = lo_instance.

  lo_instance->show( ).
ENDFUNCTION.
