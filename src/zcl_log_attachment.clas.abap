CLASS zcl_log_attachment DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE .

  PUBLIC SECTION.

    TYPES:
      BEGIN OF mts_exception,
        text         TYPE wbobjtext,
        longtext     TYPE fcc_longtext,
        exception    TYPE iaom_exception,
        program_name TYPE sy-cprog,
        include_name TYPE tpda_include,
        source_line  TYPE sca_src_code_line_number,
      END OF mts_exception .
    TYPES:
      mtt_exception TYPE TABLE OF mts_exception WITH DEFAULT KEY .

    CONSTANTS mc_bal_param_guid TYPE spar-param VALUE 'GUID_22' ##NO_TEXT.

    CLASS-METHODS from_exception
      IMPORTING
        !io_exception    TYPE REF TO cx_root
        !iv_log_handle   TYPE balloghndl
      RETURNING
        VALUE(rs_params) TYPE bal_s_parm .
    CLASS-METHODS from_any
      IMPORTING
        !i_attachment    TYPE any
        !iv_log_handle   TYPE balloghndl
      RETURNING
        VALUE(rs_params) TYPE bal_s_parm .
    CLASS-METHODS export
      IMPORTING
        !i_data        TYPE any
        !iv_log_handle TYPE balloghndl
      RETURNING
        VALUE(rv_guid) TYPE guid_22 .
    CLASS-METHODS import
      IMPORTING
        !iv_guid TYPE guid_22
      EXPORTING
        !et_fcat TYPE lvc_t_fcat
        !ed_data TYPE REF TO data .
  PROTECTED SECTION.
  PRIVATE SECTION.

    TYPES:
      BEGIN OF mts_elemdescr,
        type     TYPE c LENGTH 1,
        length   TYPE i,
        decimals TYPE i,
      END OF mts_elemdescr .
    TYPES:
      BEGIN OF mts_structdescr,
        struct_kind TYPE abap_structkind,
        fieldcat    TYPE lvc_t_fcat,
      END OF mts_structdescr .
    TYPES:
      BEGIN OF mts_tabledescr,
        key            TYPE abap_keydescr_tab,
        key_defkind    TYPE abap_keydefkind,
        has_unique_key TYPE abap_bool,
        table_kind     TYPE abap_tablekind,
      END OF mts_tabledescr .
    TYPES:
      BEGIN OF mts_attach_data,
        elemdescr   TYPE mts_elemdescr,
        structdescr TYPE mts_structdescr,
        tabledescr  TYPE mts_tabledescr,
        xml_data    TYPE xstring,
      END OF mts_attach_data .

    DATA ms_elemdescr TYPE mts_elemdescr .
    DATA ms_structdescr TYPE mts_structdescr .
    DATA ms_tabledescr TYPE mts_tabledescr .
    DATA mo_data TYPE REF TO data .

    METHODS constructor .
    METHODS create_elem
      RETURNING
        VALUE(ro_data) TYPE REF TO data .
    METHODS create_struct
      RETURNING
        VALUE(ro_data) TYPE REF TO data .
    METHODS create_table
      RETURNING
        VALUE(ro_data) TYPE REF TO data .
    METHODS import_from_db
      IMPORTING
        !iv_guid TYPE guid_22
      EXPORTING
        !et_fcat TYPE lvc_t_fcat
        !ed_data TYPE REF TO data .
    METHODS export_to_db
      IMPORTING
        !iv_log_handle TYPE balloghndl
      RETURNING
        VALUE(rv_guid) TYPE guid_22 .
    METHODS set_data
      IMPORTING
        !i_data TYPE any .
    METHODS compute_elemdescr .
    METHODS compute_tabledescr .
    METHODS compute_structdescr .
ENDCLASS.



CLASS ZCL_LOG_ATTACHMENT IMPLEMENTATION.


  METHOD compute_elemdescr.
    ASSIGN mo_data->* TO FIELD-SYMBOL(<m_data>).

    DESCRIBE FIELD <m_data> TYPE ms_elemdescr-type.
    CHECK ms_elemdescr-type CA 'IPF/CDNTg/Xy'.  " Element: Numeric/Clike/Xlike

    IF ms_elemdescr-type CA 'CN'.
      DESCRIBE FIELD <m_data> LENGTH ms_elemdescr-length IN CHARACTER MODE.
    ENDIF.
    IF ms_elemdescr-type CA 'PX'.
      DESCRIBE FIELD <m_data> LENGTH ms_elemdescr-length IN BYTE MODE.
    ENDIF.
    IF ms_elemdescr-type EQ 'P'.
      DESCRIBE FIELD <m_data> DECIMALS ms_elemdescr-decimals.
    ENDIF.
  ENDMETHOD.


  METHOD compute_structdescr.
    DATA lo_table TYPE REF TO data.
    DATA lo_struct TYPE REF TO data.
    DATA lo_structdescr TYPE REF TO cl_abap_structdescr.
    DATA lo_salv_table TYPE REF TO cl_salv_table.
    FIELD-SYMBOLS <ls_data> TYPE any.
    FIELD-SYMBOLS <lt_data> TYPE ANY TABLE.

    ASSIGN mo_data->* TO FIELD-SYMBOL(<m_data>).

    DESCRIBE FIELD <m_data> TYPE ms_elemdescr-type.
    CHECK ms_elemdescr-type CA 'uv/h'.  " Struct: Float/Deep or Internal table

    IF ms_elemdescr-type EQ 'h'.
      ASSIGN <m_data> TO <lt_data>.
      CREATE DATA lo_struct LIKE LINE OF <lt_data>.
    ELSE.
      CREATE DATA lo_struct LIKE <m_data>.
    ENDIF.
    ASSIGN lo_struct->* TO <ls_data>.

    CREATE DATA lo_table LIKE STANDARD TABLE OF <ls_data>.
    ASSIGN lo_table->* TO <lt_data>.

    lo_structdescr ?= cl_abap_structdescr=>describe_by_data( <ls_data> ).
    ms_structdescr-struct_kind = lo_structdescr->struct_kind.

    TRY.
        CALL METHOD cl_salv_table=>factory
          IMPORTING
            r_salv_table = lo_salv_table
          CHANGING
            t_table      = <lt_data>.

        ms_structdescr-fieldcat = cl_salv_controller_metadata=>get_lvc_fieldcatalog(
            r_columns      = lo_salv_table->get_columns( )
            r_aggregations = lo_salv_table->get_aggregations( ) ).
        " Нота 2970673
        LOOP AT ms_structdescr-fieldcat ASSIGNING FIELD-SYMBOL(<ls_fieldcat>)
          WHERE ref_table IS INITIAL
            AND ref_field IS NOT INITIAL.
          CLEAR <ls_fieldcat>-ref_field.
        ENDLOOP.
      CATCH cx_root.
    ENDTRY.
  ENDMETHOD.


  METHOD compute_tabledescr.
    DATA lo_tabdescr TYPE REF TO cl_abap_tabledescr.

    ASSIGN mo_data->* TO FIELD-SYMBOL(<m_data>).

    DESCRIBE FIELD <m_data> TYPE ms_elemdescr-type.
    CHECK ms_elemdescr-type EQ 'h'.  " Internal table

    lo_tabdescr ?= cl_abap_tabledescr=>describe_by_data( <m_data> ).
    ms_tabledescr-key            = lo_tabdescr->key.
    ms_tabledescr-key_defkind    = lo_tabdescr->key_defkind.
    ms_tabledescr-has_unique_key = lo_tabdescr->has_unique_key.
    ms_tabledescr-table_kind     = lo_tabdescr->table_kind.
  ENDMETHOD.


  METHOD constructor.
  ENDMETHOD.


  METHOD create_elem.
    DATA lo_elemdescr TYPE REF TO cl_abap_elemdescr.

    CASE ms_elemdescr-type.
      WHEN 'I'. lo_elemdescr ?= cl_abap_elemdescr=>get_i( ).
      WHEN 'P'. lo_elemdescr ?= cl_abap_elemdescr=>get_p( p_length = ms_elemdescr-length p_decimals = ms_elemdescr-decimals ).
      WHEN 'F'. lo_elemdescr ?= cl_abap_elemdescr=>get_f( ).
      WHEN 'C'. lo_elemdescr ?= cl_abap_elemdescr=>get_c( p_length = ms_elemdescr-length ).
      WHEN 'D'. lo_elemdescr ?= cl_abap_elemdescr=>get_d( ).
      WHEN 'N'. lo_elemdescr ?= cl_abap_elemdescr=>get_n( p_length = ms_elemdescr-length ).
      WHEN 'T'. lo_elemdescr ?= cl_abap_elemdescr=>get_t( ).
      WHEN 'g'. lo_elemdescr ?= cl_abap_elemdescr=>get_string( ).
      WHEN 'X'. lo_elemdescr ?= cl_abap_elemdescr=>get_x( p_length = ms_elemdescr-length ).
      WHEN 'y'. lo_elemdescr ?= cl_abap_elemdescr=>get_xstring( ).
    ENDCASE.

    CREATE DATA ro_data TYPE HANDLE lo_elemdescr.
  ENDMETHOD.


  METHOD create_struct.
    DATA lo_tabledescr TYPE REF TO cl_abap_tabledescr.
    DATA lo_structdescr TYPE REF TO cl_abap_structdescr.
    DATA lo_data TYPE REF TO data.

    CHECK ms_elemdescr-type CA 'uv'.

    CALL METHOD cl_alv_table_create=>create_dynamic_table
      EXPORTING
        it_fieldcatalog = ms_structdescr-fieldcat
      IMPORTING
        ep_table        = lo_data.

    lo_tabledescr ?= cl_abap_tabledescr=>describe_by_data_ref( lo_data ).
    lo_structdescr ?= lo_tabledescr->get_table_line_type( ).
    CREATE DATA ro_data TYPE HANDLE lo_structdescr.
  ENDMETHOD.


  METHOD create_table.
    DATA lo_tabledescr TYPE REF TO cl_abap_tabledescr.
    DATA lo_data TYPE REF TO data.

    CHECK ms_elemdescr-type EQ 'h'.

    CALL METHOD cl_alv_table_create=>create_dynamic_table
      EXPORTING
        it_fieldcatalog = ms_structdescr-fieldcat
      IMPORTING
        ep_table        = lo_data.

    lo_tabledescr ?= cl_abap_tabledescr=>describe_by_data_ref( lo_data ).
    CREATE DATA ro_data TYPE HANDLE lo_tabledescr.
  ENDMETHOD.


  METHOD export.
    DATA(lo_attachment) = NEW zcl_log_attachment( ).
    lo_attachment->set_data( i_data ).
    lo_attachment->compute_elemdescr( ).
    lo_attachment->compute_structdescr( ).
    lo_attachment->compute_tabledescr( ).
    rv_guid = lo_attachment->export_to_db( iv_log_handle = iv_log_handle ).
  ENDMETHOD.


  METHOD export_to_db.
    DATA ls_attach TYPE mts_attach_data.
    DATA ls_data TYPE ztbc_log_data.
    DATA ls_log_header TYPE bal_s_log.
    DATA lv_date_del TYPE sy-datum.
    DATA lv_xml TYPE xstring.
    DATA lv_zip TYPE xstring.

    ASSIGN mo_data->* TO FIELD-SYMBOL(<l_data>).
    ASSERT sy-subrc EQ 0.

    CALL FUNCTION 'GUID_CREATE'
      IMPORTING
        ev_guid_22 = rv_guid.

    ls_attach-elemdescr = ms_elemdescr.
    ls_attach-structdescr = ms_structdescr.
    ls_attach-tabledescr = ms_tabledescr.
    CALL TRANSFORMATION id
      SOURCE model = <l_data>
      RESULT XML ls_attach-xml_data.

    CALL FUNCTION 'BAL_LOG_HDR_READ'
      EXPORTING
        i_log_handle  = iv_log_handle
      IMPORTING
        e_s_log       = ls_log_header
      EXCEPTIONS
        log_not_found = 1
        OTHERS        = 2.
    IF sy-subrc EQ 0.
      lv_date_del = ls_log_header-aldate_del.
    ENDIF.
    IF lv_date_del IS INITIAL.
      lv_date_del = sy-datum + 7. " Если дата удаления не определена - храним неделю.
    ENDIF.

    CALL TRANSFORMATION id
      SOURCE model = ls_attach
      RESULT XML lv_xml.

    CALL METHOD cl_abap_gzip=>compress_binary
      EXPORTING
        raw_in   = lv_xml
      IMPORTING
        gzip_out = lv_zip.

    ls_data-guid = rv_guid.
    ls_data-zip = lv_zip.
    ls_data-begdt = sy-datum.
    ls_data-enddt = lv_date_del.
    ls_data-logid = iv_log_handle.

    CALL FUNCTION 'Z_BC_LOG_INSERT_ATTACHMENTS'
      EXPORTING
        iv_new_task = abap_true
        is_data     = ls_data.
  ENDMETHOD.


  METHOD from_any.
    DATA(lv_guid) = export( i_data = i_attachment iv_log_handle = iv_log_handle ).

    CLEAR rs_params.
    rs_params-t_par = VALUE #( ( parname = mc_bal_param_guid parvalue = lv_guid ) ).
    rs_params-callback = VALUE #( userexitf = 'Z_BC_LOG_DETAIL_ENTRY' userexitt = 'F' ).
  ENDMETHOD.


  METHOD from_exception.
    DATA lt_exc TYPE mtt_exception.
    DATA lo_exc TYPE REF TO cx_root.
    DATA lo_exc_desc TYPE REF TO cl_instance_description.
    FIELD-SYMBOLS <ls_exc> TYPE mts_exception.

    lo_exc = io_exception.
    WHILE lo_exc IS BOUND.
      lo_exc_desc = NEW #( the_subject = lo_exc ).

      APPEND INITIAL LINE TO lt_exc ASSIGNING <ls_exc>.
      <ls_exc>-text = lo_exc->get_text( ).
      <ls_exc>-longtext = lo_exc->get_longtext( ).
      <ls_exc>-exception = lo_exc_desc->class_name.
      CALL METHOD lo_exc->get_source_position
        IMPORTING
          program_name = <ls_exc>-program_name
          include_name = <ls_exc>-include_name
          source_line  = <ls_exc>-source_line.
      IF <ls_exc>-longtext EQ |{ <ls_exc>-text }| OR
         <ls_exc>-longtext EQ |{ <ls_exc>-text }.|.
        CLEAR <ls_exc>-longtext.
      ENDIF.
      lo_exc = lo_exc->previous.
    ENDWHILE.

    DATA(lv_guid) = export( i_data = lt_exc iv_log_handle = iv_log_handle ).

    CLEAR rs_params.
    rs_params-t_par = VALUE #( ( parname = mc_bal_param_guid parvalue = lv_guid ) ).
    rs_params-callback = VALUE #( userexitf = 'Z_BC_LOG_EXCEPTION_VIEW' userexitt = 'F' ).
  ENDMETHOD.


  METHOD import.
    DATA(lo_attachment) = NEW zcl_log_attachment( ).

    CALL METHOD lo_attachment->import_from_db
      EXPORTING
        iv_guid = iv_guid
      IMPORTING
        et_fcat = et_fcat
        ed_data = ed_data.
  ENDMETHOD.


  METHOD import_from_db.
    DATA lv_zip TYPE xstring.
    DATA lv_xml TYPE xstring.
    DATA ls_attach TYPE mts_attach_data.

    SELECT SINGLE zip
      INTO lv_zip
      FROM ztbc_log_data
      WHERE guid EQ iv_guid.
    CHECK sy-subrc EQ 0.
    CHECK lv_zip IS NOT INITIAL.

    CALL METHOD cl_abap_gzip=>decompress_binary
      EXPORTING
        gzip_in = lv_zip
      IMPORTING
        raw_out = lv_xml.

    CALL TRANSFORMATION id
      SOURCE XML lv_xml
      RESULT model = ls_attach.

    ms_elemdescr = ls_attach-elemdescr.
    ms_structdescr = ls_attach-structdescr.
    ms_tabledescr = ls_attach-tabledescr.

    IF ms_elemdescr-type CA 'IPF/CDNTg/Xy'.   " Element: Numeric/Clike/Xlike
      ed_data = create_elem( ).
    ENDIF.
    IF ms_elemdescr-type CA 'uv'.             " Struct: Float/Deep
      ed_data = create_struct( ).
    ENDIF.
    IF ms_elemdescr-type CA 'h'.              " Internal table
      ed_data = create_table( ).
    ENDIF.
    CHECK ed_data IS NOT INITIAL.

    ASSIGN ed_data->* TO FIELD-SYMBOL(<l_data>).
    CHECK sy-subrc EQ 0.

    CALL TRANSFORMATION id
      SOURCE XML ls_attach-xml_data
      RESULT model = <l_data>.

    et_fcat = ms_structdescr-fieldcat.
  ENDMETHOD.


  METHOD set_data.
    DATA lo_wa TYPE REF TO data.
    DATA lo_tab TYPE REF TO data.
    FIELD-SYMBOLS <lt> TYPE ANY TABLE.

    DESCRIBE FIELD i_data TYPE DATA(lv_type).
    IF lv_type CA 'lr'.
      ASSIGN i_data->* TO FIELD-SYMBOL(<l_data>).
      GET REFERENCE OF <l_data> INTO mo_data.
    ELSEIF lv_type EQ 'h'.
      ASSIGN i_data TO <lt>.
      CREATE DATA lo_wa LIKE LINE OF <lt>.
      ASSIGN lo_wa->* TO FIELD-SYMBOL(<ls>).
      DESCRIBE FIELD <ls> TYPE DATA(lv_type_row).
      IF lv_type_row CA 'uv'.
        GET REFERENCE OF i_data INTO mo_data.
      ELSE.
        DATA(lo_line_type) = cl_abap_structdescr=>create( VALUE #(
          ( name = '_TABLE_LINE_' type = CAST #( cl_abap_datadescr=>describe_by_data( <ls> ) ) )
        ) ).
        DATA(lo_table_type) = cl_abap_tabledescr=>create( lo_line_type ).
        CREATE DATA lo_tab TYPE HANDLE lo_table_type.
        ASSIGN lo_tab->* TO <lt>.
        MOVE i_data TO <lt>.
        GET REFERENCE OF <lt> INTO mo_data.
      ENDIF.
    ELSE.
      GET REFERENCE OF i_data INTO mo_data.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
