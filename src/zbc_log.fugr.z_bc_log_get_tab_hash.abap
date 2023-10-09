FUNCTION z_bc_log_get_tab_hash .
*"----------------------------------------------------------------------
*"*"Локальный интерфейс:
*"  IMPORTING
*"     REFERENCE(IV_LOGN) TYPE  BALOGNR
*"     REFERENCE(IT_FCAT) TYPE  LVC_T_FCAT
*"  EXPORTING
*"     REFERENCE(EV_HASH) TYPE  HASH160
*"----------------------------------------------------------------------
  DATA: lt_log_number TYPE bal_t_logn,
        lt_log_header TYPE balhdr_t,
        lv_log_header TYPE balhdr,
        ls_fcat       TYPE lvc_s_fcat,
        lt_key        TYPE TABLE OF string,
        lv_key        TYPE string.

  INSERT iv_logn INTO TABLE lt_log_number.

  CALL METHOD cl_bal_db_search=>get_header_by_key
    EXPORTING
      it_lognumber  = lt_log_number
    IMPORTING
      et_log_header = lt_log_header.

  READ TABLE lt_log_header INTO lv_log_header INDEX 1.
  CHECK sy-subrc EQ 0.

  lv_key = |LOG_HEADER:| &&
           |OBJECT={ lv_log_header-object };| &&
           |SUBOBJECT={ lv_log_header-subobject };|.
  APPEND lv_key TO lt_key.

  LOOP AT it_fcat INTO ls_fcat.
    lv_key = |FCAT[{ sy-tabix }]:| &&
             |FIELDNAME={ ls_fcat-fieldname };| &&
             |KEY={ ls_fcat-key };| &&
             |ROLLNAME={ ls_fcat-rollname };| &&
             |DATATYPE={ ls_fcat-datatype };| &&
             |INTTYPE={ ls_fcat-inttype };| &&
             |INTLEN={ ls_fcat-intlen };| &&
             |REF_FIELD={ ls_fcat-ref_field };| &&
             |REF_TABLE={ ls_fcat-ref_table };|.
    APPEND lv_key TO lt_key.
  ENDLOOP.

  CONCATENATE LINES OF lt_key INTO lv_key SEPARATED BY '|'.

  CALL FUNCTION 'CALCULATE_HASH_FOR_CHAR'
    EXPORTING
      alg            = 'MD5'
      data           = lv_key
    IMPORTING
      hash           = ev_hash
    EXCEPTIONS
      unknown_alg    = 1
      param_error    = 2
      internal_error = 3
      OTHERS         = 4.
ENDFUNCTION.
