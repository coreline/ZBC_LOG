FUNCTION z_bc_log_struct_view.
*"----------------------------------------------------------------------
*"*"Локальный интерфейс:
*"  IMPORTING
*"     REFERENCE(IV_HASH) TYPE  HASH160
*"     REFERENCE(IS_DATA) TYPE  ANY
*"     REFERENCE(IT_FCAT) TYPE  LVC_T_FCAT
*"----------------------------------------------------------------------
  TYPES:
    BEGIN OF lts_alv,
      fieldname TYPE lvc_s_fcat-fieldname,
      raw_value TYPE crmt_attrib_value_internal,
      out_value TYPE fieldvalue,
      fieldtext TYPE lvc_s_fcat-coltext,
    END OF lts_alv.
  DATA lt_view TYPE STANDARD TABLE OF lts_alv WITH KEY fieldname.
  DATA ls_view TYPE lts_alv.
  DATA lt_fcat TYPE lvc_t_fcat.
  DATA lv_type TYPE c.

  LOOP AT it_fcat ASSIGNING FIELD-SYMBOL(<ls_fcat>).
    ASSIGN COMPONENT <ls_fcat>-fieldname OF STRUCTURE is_data TO FIELD-SYMBOL(<lv_val>).
    CHECK sy-subrc EQ 0.

    CLEAR ls_view.
    ls_view-fieldname = <ls_fcat>-fieldname.

    DESCRIBE FIELD <lv_val> TYPE lv_type.
    CASE lv_type.
      WHEN 'u'. ls_view-raw_value = '[Float structure]'.
      WHEN 'v'. ls_view-raw_value = '[Deep structure]'.
      WHEN 'h'. ls_view-raw_value = '[Internal table]'.
      WHEN OTHERS.
        MOVE <lv_val> TO ls_view-raw_value.
        WRITE <lv_val> TO ls_view-out_value.
    ENDCASE.

    IF <ls_fcat>-reptext IS NOT INITIAL.
      MOVE <ls_fcat>-reptext TO ls_view-fieldtext.
    ELSEIF <ls_fcat>-coltext IS NOT INITIAL.
      MOVE <ls_fcat>-coltext TO ls_view-fieldtext.
    ELSEIF <ls_fcat>-scrtext_l IS NOT INITIAL.
      MOVE <ls_fcat>-scrtext_l TO ls_view-fieldtext.
    ELSEIF <ls_fcat>-scrtext_m IS NOT INITIAL.
      MOVE <ls_fcat>-scrtext_m TO ls_view-fieldtext.
    ELSEIF <ls_fcat>-scrtext_s IS NOT INITIAL.
      MOVE <ls_fcat>-scrtext_s TO ls_view-fieldtext.
    ENDIF.
    APPEND ls_view TO lt_view.
  ENDLOOP.

  APPEND VALUE #( fieldname = 'FIELDNAME' coltext = 'Технич. имя поля' key = 'X' ) TO lt_fcat.
  APPEND VALUE #( fieldname = 'RAW_VALUE' coltext = 'Непреобразованное значение' ) TO lt_fcat.
  APPEND VALUE #( fieldname = 'FIELDTEXT' coltext = 'Имя поля' emphasize = 'C500' ) TO lt_fcat.
  APPEND VALUE #( fieldname = 'OUT_VALUE' coltext = 'Значение' ) TO lt_fcat.

  CALL FUNCTION 'Z_BC_LOG_TABLE_VIEW'
    EXPORTING
      iv_hash = iv_hash
      it_data = lt_view
      it_fcat = lt_fcat.
ENDFUNCTION.
