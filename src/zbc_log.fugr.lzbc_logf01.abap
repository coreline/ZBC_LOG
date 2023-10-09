*&---------------------------------------------------------------------*
*& Include          LZBC_LOGF01
*&---------------------------------------------------------------------*

FORM clear_stack.
  CLEAR: gt_data, gt_data_alv.
  UNASSIGN: <g_data>, <g_data_alv>.
ENDFORM.

FORM push_data USING i_data TYPE any.
  DATA lo_data TYPE REF TO data.
  DATA lv_count TYPE i.

  GET REFERENCE OF i_data INTO lo_data.
  APPEND lo_data TO gt_data.

  lv_count = lines( gt_data ).
  READ TABLE gt_data INTO lo_data INDEX lv_count.
  ASSIGN lo_data->* TO <g_data>.
ENDFORM.

FORM pop_data.
  DATA lo_data TYPE REF TO data.
  DATA lv_count TYPE i.

  lv_count = lines( gt_data ).
  DELETE gt_data INDEX lv_count.

  lv_count = lv_count - 1.
  IF lv_count GT 0.
    READ TABLE gt_data INTO lo_data INDEX lv_count.
    ASSIGN lo_data->* TO <g_data>.
  ENDIF.
ENDFORM.

FORM push_data_alv USING i_data TYPE any.
  DATA lo_data TYPE REF TO data.
  DATA lv_count TYPE i.

  GET REFERENCE OF i_data INTO lo_data.
  APPEND lo_data TO gt_data_alv.

  lv_count = lines( gt_data_alv ).
  READ TABLE gt_data_alv INTO lo_data INDEX lv_count.
  ASSIGN lo_data->* TO <g_data_alv>.
ENDFORM.

FORM pop_data_alv.
  DATA lo_data TYPE REF TO data.
  DATA lv_count TYPE i.

  lv_count = lines( gt_data_alv ).
  DELETE gt_data_alv INDEX lv_count.

  lv_count = lv_count - 1.
  IF lv_count GT 0.
    READ TABLE gt_data_alv INTO lo_data INDEX lv_count.
    ASSIGN lo_data->* TO <g_data_alv>.
  ENDIF.
ENDFORM.

FORM create_fcat USING i_data TYPE any
                 CHANGING et_fcat TYPE lvc_t_fcat.
  DATA ld_table TYPE REF TO data.
  DATA ld_struct TYPE REF TO data.
  DATA lo_structdescr TYPE REF TO cl_abap_structdescr.
  DATA lo_salv_table TYPE REF TO cl_salv_table.
  DATA lv_type TYPE c.
  FIELD-SYMBOLS <ls_data> TYPE any.
  FIELD-SYMBOLS <lt_data> TYPE ANY TABLE.

  CLEAR et_fcat.

  DESCRIBE FIELD i_data TYPE lv_type.
  CHECK lv_type CA 'h/uv'.

  IF lv_type EQ 'h'.
    CREATE DATA ld_table LIKE i_data.
    ASSIGN ld_table->* TO <lt_data>.
  ELSE.
    CREATE DATA ld_struct LIKE i_data.
    ASSIGN ld_struct->* TO <ls_data>.

    CREATE DATA ld_table LIKE STANDARD TABLE OF <ls_data>.
    ASSIGN ld_table->* TO <lt_data>.
  ENDIF.

  TRY.
      CALL METHOD cl_salv_table=>factory
        IMPORTING
          r_salv_table = lo_salv_table
        CHANGING
          t_table      = <lt_data>.

      et_fcat = cl_salv_controller_metadata=>get_lvc_fieldcatalog(
          r_columns      = lo_salv_table->get_columns( )
          r_aggregations = lo_salv_table->get_aggregations( ) ).
    CATCH cx_root.
  ENDTRY.
ENDFORM.

FORM user_command USING iv_ucomm TYPE sy-ucomm
                        is_field TYPE slis_selfield.
  DATA lo_data TYPE REF TO data.
  DATA lt_fcat TYPE lvc_t_fcat.
  FIELD-SYMBOLS <l_data> TYPE any.

  CHECK iv_ucomm EQ '&IC1'. "Double click

  PERFORM get_drilldown_ref USING is_field CHANGING lo_data.
  CHECK lo_data IS BOUND.

  ASSIGN lo_data->* TO <l_data>.
  PERFORM create_fcat USING <l_data> CHANGING lt_fcat.

  PERFORM push_data USING <l_data>.

  CALL FUNCTION 'Z_BC_LOG_ANY_VIEW'
    EXPORTING
      i_data  = <g_data>
      it_fcat = lt_fcat.

  PERFORM pop_data.
ENDFORM.

FORM user_command_exc USING iv_ucomm TYPE sy-ucomm
                            is_field TYPE slis_selfield.
  FIELD-SYMBOLS <lt_table> TYPE STANDARD TABLE.
  FIELD-SYMBOLS <ls_row> TYPE any.
  CHECK iv_ucomm EQ '&IC1'. "Double click

  ASSIGN <g_data_alv> TO <lt_table>.
  READ TABLE <lt_table> ASSIGNING <ls_row> INDEX is_field-tabindex.
  CHECK sy-subrc EQ 0.

  CASE is_field-fieldname.
    WHEN 'PROGRAM_NAME'
      OR 'INCLUDE_NAME'
      OR 'SOURCE_LINE'.
      PERFORM open_editor USING <ls_row>.
    WHEN OTHERS.
      PERFORM user_command USING iv_ucomm is_field.
  ENDCASE.
ENDFORM.

FORM open_editor USING is_row TYPE zcl_log_attachment=>mts_exception.
  CALL FUNCTION 'EDITOR_PROGRAM'
    EXPORTING
      program = is_row-include_name
      line    = is_row-source_line
      display = abap_true.
ENDFORM.

FORM get_drilldown_ref USING is_field TYPE slis_selfield
                       CHANGING eo_data TYPE REF TO data.
  DATA lv_type TYPE c.
  FIELD-SYMBOLS <lt_table> TYPE STANDARD TABLE.
  FIELD-SYMBOLS <ls_struc> TYPE any.
  FIELD-SYMBOLS <ls_row> TYPE any.
  FIELD-SYMBOLS <lv_val> TYPE any.

  DESCRIBE FIELD <g_data> TYPE lv_type.
  IF lv_type EQ 'h'.
    ASSIGN <g_data> TO <lt_table>.
    READ TABLE <lt_table> ASSIGNING <ls_row> INDEX is_field-tabindex.
    CHECK sy-subrc EQ 0.
    ASSIGN COMPONENT is_field-fieldname OF STRUCTURE <ls_row> TO <lv_val>.
  ELSEIF lv_type CA 'uv'.
    ASSIGN <g_data_alv> TO <lt_table>.
    READ TABLE <lt_table> ASSIGNING <ls_struc> INDEX is_field-tabindex.
    CHECK sy-subrc EQ 0.
    ASSIGN COMPONENT 'FIELDNAME' OF STRUCTURE <g_data> TO <lv_val>.
  ENDIF.
  CHECK sy-subrc EQ 0.
  GET REFERENCE OF <lv_val> INTO eo_data.
ENDFORM.
