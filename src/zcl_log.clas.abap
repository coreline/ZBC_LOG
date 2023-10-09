CLASS zcl_log DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    DATA mv_log_handle TYPE balloghndl READ-ONLY .
    DATA mv_msg_count TYPE i READ-ONLY .
    DATA mv_type_class TYPE sy-msgty READ-ONLY .
    DATA mv_type_class3 TYPE sy-msgty READ-ONLY .

    METHODS constructor
      IMPORTING
        !iv_log_handle TYPE balloghndl OPTIONAL
        !iv_extnumber  TYPE balnrext OPTIONAL
        !iv_object     TYPE balobj_d OPTIONAL
        !iv_subobject  TYPE balsubobj OPTIONAL
        !iv_aldate     TYPE baldate OPTIONAL
        !iv_altime     TYPE baltime OPTIONAL
        !iv_aluser     TYPE baluser OPTIONAL
        !iv_altcode    TYPE baltcode OPTIONAL
        !iv_alprog     TYPE balprog OPTIONAL
        !iv_almode     TYPE balmode OPTIONAL
        !iv_alchdate   TYPE balchdate OPTIONAL
        !iv_alchtime   TYPE balchtime OPTIONAL
        !iv_alchuser   TYPE balchuser OPTIONAL
        !iv_aldate_del TYPE aldate_del OPTIONAL
        !iv_del_before TYPE del_before OPTIONAL
        !iv_alstate    TYPE alstate OPTIONAL
        !is_context    TYPE bal_s_cont OPTIONAL
        !is_params     TYPE bal_s_parm OPTIONAL
      RAISING
        zcx_log .
    CLASS-METHODS search
      IMPORTING
        !is_filter    TYPE bal_s_lfil
        !iv_cumulate  TYPE flag DEFAULT space
      RETURNING
        VALUE(ro_log) TYPE REF TO zcl_log .
    METHODS add
      IMPORTING
        !iv_msgty             TYPE symsgty OPTIONAL
        !iv_msgid             TYPE symsgid OPTIONAL
        !iv_msgno             TYPE symsgno OPTIONAL
        !iv_msgv1             TYPE symsgv OPTIONAL
        !iv_msgv2             TYPE symsgv OPTIONAL
        !iv_msgv3             TYPE symsgv OPTIONAL
        !iv_msgv4             TYPE symsgv OPTIONAL
        !iv_msgv1_src         TYPE balmsgvsrc OPTIONAL
        !iv_msgv2_src         TYPE balmsgvsrc OPTIONAL
        !iv_msgv3_src         TYPE balmsgvsrc OPTIONAL
        !iv_msgv4_src         TYPE balmsgvsrc OPTIONAL
        !iv_detlevel          TYPE ballevel OPTIONAL
        !iv_probclass         TYPE balprobcl OPTIONAL
        !iv_alsort            TYPE balsort OPTIONAL
        !iv_time_stmp         TYPE baltimstmp OPTIONAL
        !iv_msg_count         TYPE balcntcum OPTIONAL
        !is_context           TYPE bal_s_cont OPTIONAL
        !is_params            TYPE bal_s_parm OPTIONAL
        !iv_cumulate          TYPE flag OPTIONAL
        !i_attachment         TYPE any OPTIONAL
        !io_details           TYPE REF TO zif_log_details OPTIONAL
      EXPORTING
        !es_msg_handle        TYPE balmsghndl
        !ev_msg_was_logged    TYPE boolean
        !ev_msg_was_displayed TYPE boolean
      RETURNING
        VALUE(ro_log)         TYPE REF TO zcl_log
      RAISING
        zcx_log .
    METHODS add_exc
      IMPORTING
        !iv_msgty             TYPE symsgty DEFAULT 'E'
        !io_exception         TYPE REF TO cx_root
        !iv_msgv1_src         TYPE balmsgvsrc OPTIONAL
        !iv_msgv2_src         TYPE balmsgvsrc OPTIONAL
        !iv_msgv3_src         TYPE balmsgvsrc OPTIONAL
        !iv_msgv4_src         TYPE balmsgvsrc OPTIONAL
        !iv_detlevel          TYPE ballevel OPTIONAL
        !iv_probclass         TYPE balprobcl OPTIONAL
        !iv_alsort            TYPE balsort OPTIONAL
        !iv_time_stmp         TYPE baltimstmp OPTIONAL
        !iv_msg_count         TYPE balcntcum OPTIONAL
        !is_context           TYPE bal_s_cont OPTIONAL
        !is_params            TYPE bal_s_parm OPTIONAL
        !iv_text_only         TYPE flag DEFAULT space
        !iv_cumulate          TYPE flag DEFAULT space
        !i_attachment         TYPE any OPTIONAL
        !io_details           TYPE REF TO zif_log_details OPTIONAL
      EXPORTING
        !es_msg_handle        TYPE balmsghndl
        !ev_msg_was_logged    TYPE boolean
        !ev_msg_was_displayed TYPE boolean
      RETURNING
        VALUE(ro_log)         TYPE REF TO zcl_log
      RAISING
        zcx_log .
    METHODS add_exception
      IMPORTING
        !iv_msgty             TYPE symsgty DEFAULT 'E'
        !io_exception         TYPE REF TO cx_root
        !iv_detlevel          TYPE ballevel OPTIONAL
        !iv_probclass         TYPE balprobcl OPTIONAL
        !iv_alsort            TYPE balsort OPTIONAL
        !iv_time_stmp         TYPE baltimstmp OPTIONAL
        !iv_msg_count         TYPE balcntcum OPTIONAL
      EXPORTING
        !es_msg_handle        TYPE balmsghndl
        !ev_msg_was_logged    TYPE boolean
        !ev_msg_was_displayed TYPE boolean
      RETURNING
        VALUE(ro_log)         TYPE REF TO zcl_log
      RAISING
        zcx_log .
    METHODS add_free_text
      IMPORTING
        !iv_msgty             TYPE symsgty
        !iv_text              TYPE clike
        !iv_msgv1_src         TYPE balmsgvsrc OPTIONAL
        !iv_msgv2_src         TYPE balmsgvsrc OPTIONAL
        !iv_msgv3_src         TYPE balmsgvsrc OPTIONAL
        !iv_msgv4_src         TYPE balmsgvsrc OPTIONAL
        !iv_detlevel          TYPE ballevel OPTIONAL
        !iv_probclass         TYPE balprobcl OPTIONAL
        !iv_alsort            TYPE balsort OPTIONAL
        !iv_time_stmp         TYPE baltimstmp OPTIONAL
        !iv_msg_count         TYPE balcntcum OPTIONAL
        !is_context           TYPE bal_s_cont OPTIONAL
        !is_params            TYPE bal_s_parm OPTIONAL
        !iv_cumulate          TYPE flag DEFAULT space
        !i_attachment         TYPE any OPTIONAL
        !io_details           TYPE REF TO zif_log_details OPTIONAL
      EXPORTING
        !es_msg_handle        TYPE balmsghndl
        !ev_msg_was_logged    TYPE boolean
        !ev_msg_was_displayed TYPE boolean
      RETURNING
        VALUE(ro_log)         TYPE REF TO zcl_log
      RAISING
        zcx_log .
    METHODS add_log
      IMPORTING
        !io_log       TYPE REF TO zcl_log
      RETURNING
        VALUE(ro_log) TYPE REF TO zcl_log
      RAISING
        zcx_log .
    METHODS add_struct
      IMPORTING
        !is_data              TYPE any
        !iv_msgv1_src         TYPE balmsgvsrc OPTIONAL
        !iv_msgv2_src         TYPE balmsgvsrc OPTIONAL
        !iv_msgv3_src         TYPE balmsgvsrc OPTIONAL
        !iv_msgv4_src         TYPE balmsgvsrc OPTIONAL
        !iv_detlevel          TYPE ballevel OPTIONAL
        !iv_probclass         TYPE balprobcl OPTIONAL
        !iv_alsort            TYPE balsort OPTIONAL
        !iv_time_stmp         TYPE baltimstmp OPTIONAL
        !iv_msg_count         TYPE balcntcum OPTIONAL
        !is_context           TYPE bal_s_cont OPTIONAL
        !is_params            TYPE bal_s_parm OPTIONAL
        !iv_cumulate          TYPE flag DEFAULT space
        !i_attachment         TYPE any OPTIONAL
        !io_details           TYPE REF TO zif_log_details OPTIONAL
      EXPORTING
        !es_msg_handle        TYPE balmsghndl
        !ev_msg_was_logged    TYPE boolean
        !ev_msg_was_displayed TYPE boolean
      RETURNING
        VALUE(ro_log)         TYPE REF TO zcl_log
      RAISING
        zcx_log .
    METHODS add_syst
      IMPORTING
        !is_data              TYPE syst DEFAULT sy
        !iv_msgv1_src         TYPE balmsgvsrc OPTIONAL
        !iv_msgv2_src         TYPE balmsgvsrc OPTIONAL
        !iv_msgv3_src         TYPE balmsgvsrc OPTIONAL
        !iv_msgv4_src         TYPE balmsgvsrc OPTIONAL
        !iv_detlevel          TYPE ballevel OPTIONAL
        !iv_probclass         TYPE balprobcl OPTIONAL
        !iv_alsort            TYPE balsort OPTIONAL
        !iv_time_stmp         TYPE baltimstmp OPTIONAL
        !iv_msg_count         TYPE balcntcum OPTIONAL
        !is_context           TYPE bal_s_cont OPTIONAL
        !is_params            TYPE bal_s_parm OPTIONAL
        !iv_cumulate          TYPE flag DEFAULT space
        !i_attachment         TYPE any OPTIONAL
        !io_details           TYPE REF TO zif_log_details OPTIONAL
      EXPORTING
        !es_msg_handle        TYPE balmsghndl
        !ev_msg_was_logged    TYPE boolean
        !ev_msg_was_displayed TYPE boolean
      RETURNING
        VALUE(ro_log)         TYPE REF TO zcl_log
      RAISING
        zcx_log .
    METHODS add_table
      IMPORTING
        !it_data              TYPE INDEX TABLE
        !iv_msgv1_src         TYPE balmsgvsrc OPTIONAL
        !iv_msgv2_src         TYPE balmsgvsrc OPTIONAL
        !iv_msgv3_src         TYPE balmsgvsrc OPTIONAL
        !iv_msgv4_src         TYPE balmsgvsrc OPTIONAL
        !iv_detlevel          TYPE ballevel OPTIONAL
        !iv_probclass         TYPE balprobcl OPTIONAL
        !iv_alsort            TYPE balsort OPTIONAL
        !iv_time_stmp         TYPE baltimstmp OPTIONAL
        !iv_msg_count         TYPE balcntcum OPTIONAL
        !is_context           TYPE bal_s_cont OPTIONAL
        !is_params            TYPE bal_s_parm OPTIONAL
        !iv_cumulate          TYPE flag DEFAULT space
        !i_attachment         TYPE any OPTIONAL
        !io_details           TYPE REF TO zif_log_details OPTIONAL
      EXPORTING
        !es_msg_handle        TYPE balmsghndl
        !ev_msg_was_logged    TYPE boolean
        !ev_msg_was_displayed TYPE boolean
      RETURNING
        VALUE(ro_log)         TYPE REF TO zcl_log
      RAISING
        zcx_log .
    METHODS change
      IMPORTING
        !is_msg_handle TYPE balmsghndl
        !iv_msgty      TYPE symsgty OPTIONAL
        !iv_msgid      TYPE symsgid OPTIONAL
        !iv_msgno      TYPE symsgno OPTIONAL
        !iv_msgv1      TYPE symsgv OPTIONAL
        !iv_msgv2      TYPE symsgv OPTIONAL
        !iv_msgv3      TYPE symsgv OPTIONAL
        !iv_msgv4      TYPE symsgv OPTIONAL
        !iv_msgv1_src  TYPE balmsgvsrc OPTIONAL
        !iv_msgv2_src  TYPE balmsgvsrc OPTIONAL
        !iv_msgv3_src  TYPE balmsgvsrc OPTIONAL
        !iv_msgv4_src  TYPE balmsgvsrc OPTIONAL
        !iv_detlevel   TYPE ballevel OPTIONAL
        !iv_probclass  TYPE balprobcl OPTIONAL
        !iv_alsort     TYPE balsort OPTIONAL
        !iv_time_stmp  TYPE baltimstmp OPTIONAL
        !iv_msg_count  TYPE balcntcum OPTIONAL
        !is_context    TYPE bal_s_cont OPTIONAL
        !is_params     TYPE bal_s_parm OPTIONAL
        !i_attachment  TYPE any OPTIONAL
        !io_details    TYPE REF TO zif_log_details OPTIONAL
      RETURNING
        VALUE(ro_log)  TYPE REF TO zcl_log
      RAISING
        zcx_log .
    METHODS change_from_syst
      IMPORTING
        !is_msg_handle        TYPE balmsghndl
        !is_data              TYPE syst DEFAULT sy
        !iv_msgv1_src         TYPE balmsgvsrc OPTIONAL
        !iv_msgv2_src         TYPE balmsgvsrc OPTIONAL
        !iv_msgv3_src         TYPE balmsgvsrc OPTIONAL
        !iv_msgv4_src         TYPE balmsgvsrc OPTIONAL
        !iv_detlevel          TYPE ballevel OPTIONAL
        !iv_probclass         TYPE balprobcl OPTIONAL
        !iv_alsort            TYPE balsort OPTIONAL
        !iv_time_stmp         TYPE baltimstmp OPTIONAL
        !iv_msg_count         TYPE balcntcum OPTIONAL
        !is_context           TYPE bal_s_cont OPTIONAL
        !is_params            TYPE bal_s_parm OPTIONAL
        !i_attachment         TYPE any OPTIONAL
        !io_details           TYPE REF TO zif_log_details OPTIONAL
      EXPORTING
        !es_msg_handle        TYPE balmsghndl
        !ev_msg_was_logged    TYPE boolean
        !ev_msg_was_displayed TYPE boolean
      RETURNING
        VALUE(ro_log)         TYPE REF TO zcl_log
      RAISING
        zcx_log .
    METHODS clear
      RETURNING
        VALUE(ro_log) TYPE REF TO zcl_log
      RAISING
        zcx_log .
    METHODS commit
      IMPORTING
        !iv_in_update_task TYPE abap_bool DEFAULT space
      RETURNING
        VALUE(ro_log)      TYPE REF TO zcl_log .
    METHODS del
      IMPORTING
        !is_msg_handle TYPE balmsghndl
      RETURNING
        VALUE(ro_log)  TYPE REF TO zcl_log
      RAISING
        zcx_log .
*      !IV_PROFILE type ZEBC_LOG_DSP_PROFILE optional
    METHODS display
      IMPORTING
        !iv_profile            TYPE csequence DEFAULT 'STANDARD'
        !is_display_profile    TYPE bal_s_prof OPTIONAL
        !is_variant            TYPE disvariant OPTIONAL
        !it_msg_handle         TYPE bal_t_msgh OPTIONAL
        !is_log_filter         TYPE bal_s_lfil OPTIONAL
        !is_msg_filter         TYPE bal_s_mfil OPTIONAL
        !it_log_context_filter TYPE bal_t_cfil OPTIONAL
        !it_msg_context_filter TYPE bal_t_cfil OPTIONAL
        !iv_amodal             TYPE boolean DEFAULT space
        !iv_srt_by_timstmp     TYPE boolean DEFAULT space
      RETURNING
        VALUE(rs_exit_command) TYPE bal_s_excm
      RAISING
        zcx_log .
    METHODS show
      RETURNING
        VALUE(ro_log) TYPE REF TO zcl_log .
    METHODS has_errors
      RETURNING
        VALUE(rv_value) TYPE abap_bool .
    METHODS has_messages
      RETURNING
        VALUE(rv_value) TYPE abap_bool .
    METHODS modal
      EXPORTING
        !ev_corrections_wanted TYPE abap_bool
        !es_msg_selected       TYPE smesg
        !es_exit_command       TYPE bal_s_excm
      RETURNING
        VALUE(rs_exit_command) TYPE bal_s_excm .
    METHODS popup
      RETURNING
        VALUE(rs_exit_command) TYPE bal_s_excm .
    METHODS notify
      RETURNING
        VALUE(ro_log) TYPE REF TO zcl_log .
    METHODS read
      IMPORTING
        !iv_read_texts TYPE boolean DEFAULT space
        !iv_langu      TYPE sylangu DEFAULT sy-langu
      EXPORTING
        !es_log        TYPE bal_s_log
        !es_statistics TYPE bal_s_scnt
        !et_msg        TYPE bal_t_msgr
        !et_exc        TYPE bal_t_excr_mass
        !et_bapiret1   TYPE bapiret1_tab
        !et_bapiret2   TYPE bapiret2_tab
        !et_bdcmsgcoll TYPE tab_bdcmsgcoll
        !et_fimsg      TYPE ty_fimsg
      RETURNING
        VALUE(ro_log)  TYPE REF TO zcl_log
      RAISING
        zcx_log .
    METHODS read_msg
      IMPORTING
        !iv_read_texts TYPE boolean DEFAULT space
        !iv_langu      TYPE sylangu DEFAULT sy-langu
      RETURNING
        VALUE(rt_msg)  TYPE bal_t_msgr
      RAISING
        zcx_log .
    METHODS read_bapiret2
      IMPORTING
        !iv_read_texts     TYPE boolean DEFAULT space
        !iv_langu          TYPE sylangu DEFAULT sy-langu
      RETURNING
        VALUE(rt_bapiret2) TYPE bapiret2_tab
      RAISING
        zcx_log .
    METHODS save
      IMPORTING
        !iv_2th_connection     TYPE boolean DEFAULT space
        !iv_2th_connect_commit TYPE boolean DEFAULT space
        !iv_in_update_task     TYPE boolean DEFAULT space
        !iv_link2job           TYPE boolean DEFAULT 'X'
        !iv_save_all           TYPE boolean DEFAULT space
      RETURNING
        VALUE(ro_log)          TYPE REF TO zcl_log
      RAISING
        zcx_log .
    METHODS check_errors
      RAISING
        zcx_log_errors .
  PROTECTED SECTION.
  PRIVATE SECTION.

    CONSTANTS mc_freetext_msgid TYPE symsgid VALUE 'BL' ##NO_TEXT.
    CONSTANTS mc_freetext_msgno TYPE symsgno VALUE '001' ##NO_TEXT.

    METHODS add_bal_msg
      IMPORTING
        !is_msg               TYPE bal_s_msg
        !iv_cumulate          TYPE flag OPTIONAL
      EXPORTING
        !es_msg_handle        TYPE balmsghndl
        !ev_msg_was_logged    TYPE boolean
        !ev_msg_was_displayed TYPE boolean
      RETURNING
        VALUE(ro_log)         TYPE REF TO zcl_log
      RAISING
        zcx_log .
    METHODS add_bal_s_msg
      IMPORTING
        !is_data              TYPE bal_s_msg OPTIONAL
        !iv_msgv1_src         TYPE balmsgvsrc OPTIONAL
        !iv_msgv2_src         TYPE balmsgvsrc OPTIONAL
        !iv_msgv3_src         TYPE balmsgvsrc OPTIONAL
        !iv_msgv4_src         TYPE balmsgvsrc OPTIONAL
        !iv_detlevel          TYPE ballevel OPTIONAL
        !iv_probclass         TYPE balprobcl OPTIONAL
        !iv_alsort            TYPE balsort OPTIONAL
        !iv_time_stmp         TYPE baltimstmp OPTIONAL
        !iv_msg_count         TYPE balcntcum OPTIONAL
        !is_context           TYPE bal_s_cont OPTIONAL
        !is_params            TYPE bal_s_parm OPTIONAL
        !iv_cumulate          TYPE flag DEFAULT space
        !i_attachment         TYPE any OPTIONAL
        !io_details           TYPE REF TO zif_log_details OPTIONAL
      EXPORTING
        !es_msg_handle        TYPE balmsghndl
        !ev_msg_was_logged    TYPE boolean
        !ev_msg_was_displayed TYPE boolean
      RAISING
        zcx_log .
    METHODS add_bal_s_msgr
      IMPORTING
        !is_data              TYPE bal_s_msgr OPTIONAL
        !iv_msgv1_src         TYPE balmsgvsrc OPTIONAL
        !iv_msgv2_src         TYPE balmsgvsrc OPTIONAL
        !iv_msgv3_src         TYPE balmsgvsrc OPTIONAL
        !iv_msgv4_src         TYPE balmsgvsrc OPTIONAL
        !iv_detlevel          TYPE ballevel OPTIONAL
        !iv_probclass         TYPE balprobcl OPTIONAL
        !iv_alsort            TYPE balsort OPTIONAL
        !iv_time_stmp         TYPE baltimstmp OPTIONAL
        !iv_msg_count         TYPE balcntcum OPTIONAL
        !is_context           TYPE bal_s_cont OPTIONAL
        !is_params            TYPE bal_s_parm OPTIONAL
        !iv_cumulate          TYPE flag DEFAULT space
        !i_attachment         TYPE any OPTIONAL
        !io_details           TYPE REF TO zif_log_details OPTIONAL
      EXPORTING
        !es_msg_handle        TYPE balmsghndl
        !ev_msg_was_logged    TYPE boolean
        !ev_msg_was_displayed TYPE boolean
      RAISING
        zcx_log .
    METHODS add_bapiret1
      IMPORTING
        !is_data              TYPE bapiret1
        !iv_msgv1_src         TYPE balmsgvsrc OPTIONAL
        !iv_msgv2_src         TYPE balmsgvsrc OPTIONAL
        !iv_msgv3_src         TYPE balmsgvsrc OPTIONAL
        !iv_msgv4_src         TYPE balmsgvsrc OPTIONAL
        !iv_detlevel          TYPE ballevel OPTIONAL
        !iv_probclass         TYPE balprobcl OPTIONAL
        !iv_alsort            TYPE balsort OPTIONAL
        !iv_time_stmp         TYPE baltimstmp OPTIONAL
        !iv_msg_count         TYPE balcntcum OPTIONAL
        !is_context           TYPE bal_s_cont OPTIONAL
        !is_params            TYPE bal_s_parm OPTIONAL
        !iv_cumulate          TYPE flag DEFAULT space
        !i_attachment         TYPE any OPTIONAL
        !io_details           TYPE REF TO zif_log_details OPTIONAL
      EXPORTING
        !es_msg_handle        TYPE balmsghndl
        !ev_msg_was_logged    TYPE boolean
        !ev_msg_was_displayed TYPE boolean
      RAISING
        zcx_log .
    METHODS add_bapiret2
      IMPORTING
        !is_data              TYPE bapiret2
        !iv_msgv1_src         TYPE balmsgvsrc OPTIONAL
        !iv_msgv2_src         TYPE balmsgvsrc OPTIONAL
        !iv_msgv3_src         TYPE balmsgvsrc OPTIONAL
        !iv_msgv4_src         TYPE balmsgvsrc OPTIONAL
        !iv_detlevel          TYPE ballevel OPTIONAL
        !iv_probclass         TYPE balprobcl OPTIONAL
        !iv_alsort            TYPE balsort OPTIONAL
        !iv_time_stmp         TYPE baltimstmp OPTIONAL
        !iv_msg_count         TYPE balcntcum OPTIONAL
        !is_context           TYPE bal_s_cont OPTIONAL
        !is_params            TYPE bal_s_parm OPTIONAL
        !iv_cumulate          TYPE flag DEFAULT space
        !i_attachment         TYPE any OPTIONAL
        !io_details           TYPE REF TO zif_log_details OPTIONAL
      EXPORTING
        !es_msg_handle        TYPE balmsghndl
        !ev_msg_was_logged    TYPE boolean
        !ev_msg_was_displayed TYPE boolean
      RAISING
        zcx_log .
    METHODS add_bapireturn
      IMPORTING
        !is_data              TYPE bapireturn
        !iv_msgv1_src         TYPE balmsgvsrc OPTIONAL
        !iv_msgv2_src         TYPE balmsgvsrc OPTIONAL
        !iv_msgv3_src         TYPE balmsgvsrc OPTIONAL
        !iv_msgv4_src         TYPE balmsgvsrc OPTIONAL
        !iv_detlevel          TYPE ballevel OPTIONAL
        !iv_probclass         TYPE balprobcl OPTIONAL
        !iv_alsort            TYPE balsort OPTIONAL
        !iv_time_stmp         TYPE baltimstmp OPTIONAL
        !iv_msg_count         TYPE balcntcum OPTIONAL
        !is_context           TYPE bal_s_cont OPTIONAL
        !is_params            TYPE bal_s_parm OPTIONAL
        !iv_cumulate          TYPE flag DEFAULT space
        !i_attachment         TYPE any OPTIONAL
        !io_details           TYPE REF TO zif_log_details OPTIONAL
      EXPORTING
        !es_msg_handle        TYPE balmsghndl
        !ev_msg_was_logged    TYPE boolean
        !ev_msg_was_displayed TYPE boolean
      RAISING
        zcx_log .
    METHODS add_bdcmsgcoll
      IMPORTING
        !is_data              TYPE bdcmsgcoll OPTIONAL
        !iv_msgv1_src         TYPE balmsgvsrc OPTIONAL
        !iv_msgv2_src         TYPE balmsgvsrc OPTIONAL
        !iv_msgv3_src         TYPE balmsgvsrc OPTIONAL
        !iv_msgv4_src         TYPE balmsgvsrc OPTIONAL
        !iv_detlevel          TYPE ballevel OPTIONAL
        !iv_probclass         TYPE balprobcl OPTIONAL
        !iv_alsort            TYPE balsort OPTIONAL
        !iv_time_stmp         TYPE baltimstmp OPTIONAL
        !iv_msg_count         TYPE balcntcum OPTIONAL
        !is_context           TYPE bal_s_cont OPTIONAL
        !is_params            TYPE bal_s_parm OPTIONAL
        !iv_cumulate          TYPE flag DEFAULT space
        !i_attachment         TYPE any OPTIONAL
        !io_details           TYPE REF TO zif_log_details OPTIONAL
      EXPORTING
        !es_msg_handle        TYPE balmsghndl
        !ev_msg_was_logged    TYPE boolean
        !ev_msg_was_displayed TYPE boolean
      RAISING
        zcx_log .
    METHODS add_fimsg
      IMPORTING
        !is_data              TYPE fimsg
        !iv_msgv1_src         TYPE balmsgvsrc OPTIONAL
        !iv_msgv2_src         TYPE balmsgvsrc OPTIONAL
        !iv_msgv3_src         TYPE balmsgvsrc OPTIONAL
        !iv_msgv4_src         TYPE balmsgvsrc OPTIONAL
        !iv_detlevel          TYPE ballevel OPTIONAL
        !iv_probclass         TYPE balprobcl OPTIONAL
        !iv_alsort            TYPE balsort OPTIONAL
        !iv_time_stmp         TYPE baltimstmp OPTIONAL
        !iv_msg_count         TYPE balcntcum OPTIONAL
        !is_context           TYPE bal_s_cont OPTIONAL
        !is_params            TYPE bal_s_parm OPTIONAL
        !iv_cumulate          TYPE flag DEFAULT space
        !i_attachment         TYPE any OPTIONAL
        !io_details           TYPE REF TO zif_log_details OPTIONAL
      EXPORTING
        !es_msg_handle        TYPE balmsghndl
        !ev_msg_was_logged    TYPE boolean
        !ev_msg_was_displayed TYPE boolean
      RAISING
        zcx_log .
    METHODS add_mesg
      IMPORTING
        !is_data              TYPE mesg
        !iv_msgv1_src         TYPE balmsgvsrc OPTIONAL
        !iv_msgv2_src         TYPE balmsgvsrc OPTIONAL
        !iv_msgv3_src         TYPE balmsgvsrc OPTIONAL
        !iv_msgv4_src         TYPE balmsgvsrc OPTIONAL
        !iv_detlevel          TYPE ballevel OPTIONAL
        !iv_probclass         TYPE balprobcl OPTIONAL
        !iv_alsort            TYPE balsort OPTIONAL
        !iv_time_stmp         TYPE baltimstmp OPTIONAL
        !iv_msg_count         TYPE balcntcum OPTIONAL
        !is_context           TYPE bal_s_cont OPTIONAL
        !is_params            TYPE bal_s_parm OPTIONAL
        !iv_cumulate          TYPE flag DEFAULT space
        !i_attachment         TYPE any OPTIONAL
        !io_details           TYPE REF TO zif_log_details OPTIONAL
      EXPORTING
        !es_msg_handle        TYPE balmsghndl
        !ev_msg_was_logged    TYPE boolean
        !ev_msg_was_displayed TYPE boolean
      RAISING
        zcx_log .
    METHODS compute_typeclass
      IMPORTING
        !iv_msgty TYPE sy-msgty OPTIONAL .
    METHODS free_text_to_msg
      IMPORTING
        !iv_text      TYPE clike
      RETURNING
        VALUE(rs_msg) TYPE symsg .
    METHODS free_text_from_msg
      IMPORTING
        !is_msg        TYPE bal_s_msgr
      RETURNING
        VALUE(rv_text) TYPE string .
    METHODS raise_exception
      IMPORTING
        !iv_function  TYPE clike
        !iv_exception TYPE clike
      RAISING
        zcx_log_exception .
    METHODS get_params_from_details
      IMPORTING
        io_details       TYPE REF TO zif_log_details
      RETURNING
        VALUE(rs_params) TYPE bal_s_parm.
ENDCLASS.



CLASS ZCL_LOG IMPLEMENTATION.


  METHOD add.
    DATA ls_msg TYPE bal_s_msg.
    DATA lv_detail TYPE string.

    ro_log = me.

    lv_detail = xsdbool( is_params IS NOT INITIAL )
             && xsdbool( i_attachment IS NOT INITIAL )
             && xsdbool( io_details IS BOUND ).
    ASSERT strlen( lv_detail ) LE 1.

    CLEAR ls_msg.
    ls_msg-msgty     = iv_msgty.
    ls_msg-msgid     = iv_msgid.
    ls_msg-msgno     = iv_msgno.
    ls_msg-msgv1     = iv_msgv1.
    ls_msg-msgv2     = iv_msgv2.
    ls_msg-msgv3     = iv_msgv3.
    ls_msg-msgv4     = iv_msgv4.
    ls_msg-msgv1_src = iv_msgv1_src.
    ls_msg-msgv2_src = iv_msgv2_src.
    ls_msg-msgv3_src = iv_msgv3_src.
    ls_msg-msgv4_src = iv_msgv4_src.
    ls_msg-detlevel  = iv_detlevel.
    IF iv_probclass IS INITIAL AND 'AEWS' CS iv_msgty.
      ls_msg-probclass = sy-fdpos + 1.
    ELSE.
      ls_msg-probclass = iv_probclass.
    ENDIF.
    ls_msg-alsort    = iv_alsort.
    ls_msg-time_stmp = iv_time_stmp.
    ls_msg-msg_count = iv_msg_count.
    ls_msg-context   = is_context.
    IF is_params IS NOT INITIAL.
      ls_msg-params = is_params.
    ELSEIF i_attachment IS NOT INITIAL.
      ls_msg-params = zcl_log_attachment=>from_any(
          i_attachment  = i_attachment
          iv_log_handle = mv_log_handle ).
    ELSEIF io_details IS BOUND.
      ls_msg-params = get_params_from_details( io_details ).
    ENDIF.

    CALL METHOD add_bal_msg
      EXPORTING
        is_msg               = ls_msg
        iv_cumulate          = iv_cumulate
      IMPORTING
        es_msg_handle        = es_msg_handle
        ev_msg_was_logged    = ev_msg_was_logged
        ev_msg_was_displayed = ev_msg_was_displayed
      RECEIVING
        ro_log               = ro_log.
  ENDMETHOD.


  METHOD add_bal_msg.
    DATA(lv_func) = ||.
    ro_log = me.

    IF iv_cumulate EQ abap_true.
      lv_func = 'BAL_LOG_MSG_CUMULATE'.
      CALL FUNCTION 'BAL_LOG_MSG_CUMULATE'
        EXPORTING
          i_log_handle         = mv_log_handle
          i_s_msg              = is_msg
          i_compare_attributes = abap_true
          i_compare_context    = abap_true
          i_compare_parameters = abap_true
        IMPORTING
          e_s_msg_handle       = es_msg_handle
          e_msg_was_logged     = ev_msg_was_logged
          e_msg_was_displayed  = ev_msg_was_displayed
        EXCEPTIONS
          log_not_found        = 1
          msg_inconsistent     = 2
          log_is_full          = 3.
    ELSE.
      lv_func = 'BAL_LOG_MSG_ADD'.
      CALL FUNCTION 'BAL_LOG_MSG_ADD'
        EXPORTING
          i_log_handle        = mv_log_handle
          i_s_msg             = is_msg
        IMPORTING
          e_s_msg_handle      = es_msg_handle
          e_msg_was_logged    = ev_msg_was_logged
          e_msg_was_displayed = ev_msg_was_displayed
        EXCEPTIONS
          log_not_found       = 1
          msg_inconsistent    = 2
          log_is_full         = 3
          OTHERS              = 4.
    ENDIF.
    CASE sy-subrc.
      WHEN 1.
        raise_exception( iv_function = lv_func iv_exception = 'LOG_NOT_FOUND' ).
      WHEN 2.
        raise_exception( iv_function = lv_func iv_exception = 'MSG_INCONSISTENT' ).
      WHEN 3.
        raise_exception( iv_function = lv_func iv_exception = 'LOG_IS_FULL' ).
      WHEN 4.
        raise_exception( iv_function = lv_func iv_exception = 'OTHERS' ).
    ENDCASE.
    ADD 1 TO mv_msg_count.
    compute_typeclass( iv_msgty = is_msg-msgty ).
  ENDMETHOD.


  METHOD add_bal_s_msg.
    CALL METHOD me->add
      EXPORTING
        iv_msgty             = is_data-msgty
        iv_msgid             = is_data-msgid
        iv_msgno             = is_data-msgno
        iv_msgv1             = is_data-msgv1
        iv_msgv2             = is_data-msgv2
        iv_msgv3             = is_data-msgv3
        iv_msgv4             = is_data-msgv4
        iv_msgv1_src         = COND #( WHEN iv_msgv1_src IS NOT INITIAL THEN iv_msgv1_src ELSE is_data-msgv1_src )
        iv_msgv2_src         = COND #( WHEN iv_msgv2_src IS NOT INITIAL THEN iv_msgv2_src ELSE is_data-msgv2_src )
        iv_msgv3_src         = COND #( WHEN iv_msgv3_src IS NOT INITIAL THEN iv_msgv3_src ELSE is_data-msgv3_src )
        iv_msgv4_src         = COND #( WHEN iv_msgv4_src IS NOT INITIAL THEN iv_msgv4_src ELSE is_data-msgv4_src )
        iv_detlevel          = COND #( WHEN iv_detlevel IS NOT INITIAL THEN iv_detlevel ELSE is_data-detlevel )
        iv_probclass         = COND #( WHEN iv_probclass IS NOT INITIAL THEN iv_probclass ELSE is_data-probclass )
        iv_alsort            = COND #( WHEN iv_alsort IS NOT INITIAL THEN iv_alsort ELSE is_data-alsort )
        iv_time_stmp         = COND #( WHEN iv_time_stmp IS NOT INITIAL THEN iv_time_stmp ELSE is_data-time_stmp )
        iv_msg_count         = COND #( WHEN iv_msg_count IS NOT INITIAL THEN iv_msg_count ELSE is_data-msg_count )
        is_context           = COND #( WHEN is_context IS NOT INITIAL THEN is_context ELSE is_data-context )
        is_params            = COND #( WHEN is_params IS NOT INITIAL THEN is_params ELSE is_data-params )
        iv_cumulate          = iv_cumulate
        i_attachment         = i_attachment
        io_details           = io_details
      IMPORTING
        es_msg_handle        = es_msg_handle
        ev_msg_was_logged    = ev_msg_was_logged
        ev_msg_was_displayed = ev_msg_was_displayed.
  ENDMETHOD.


  METHOD add_bal_s_msgr.
    CALL METHOD me->add
      EXPORTING
        iv_msgty             = is_data-msgty
        iv_msgid             = is_data-msgid
        iv_msgno             = is_data-msgno
        iv_msgv1             = is_data-msgv1
        iv_msgv2             = is_data-msgv2
        iv_msgv3             = is_data-msgv3
        iv_msgv4             = is_data-msgv4
        iv_msgv1_src         = COND #( WHEN iv_msgv1_src IS NOT INITIAL THEN iv_msgv1_src ELSE is_data-msgv1_src )
        iv_msgv2_src         = COND #( WHEN iv_msgv2_src IS NOT INITIAL THEN iv_msgv2_src ELSE is_data-msgv2_src )
        iv_msgv3_src         = COND #( WHEN iv_msgv3_src IS NOT INITIAL THEN iv_msgv3_src ELSE is_data-msgv3_src )
        iv_msgv4_src         = COND #( WHEN iv_msgv4_src IS NOT INITIAL THEN iv_msgv4_src ELSE is_data-msgv4_src )
        iv_detlevel          = COND #( WHEN iv_detlevel IS NOT INITIAL THEN iv_detlevel ELSE is_data-detlevel )
        iv_probclass         = COND #( WHEN iv_probclass IS NOT INITIAL THEN iv_probclass ELSE is_data-probclass )
        iv_alsort            = COND #( WHEN iv_alsort IS NOT INITIAL THEN iv_alsort ELSE is_data-alsort )
        iv_time_stmp         = COND #( WHEN iv_time_stmp IS NOT INITIAL THEN iv_time_stmp ELSE is_data-time_stmp )
        iv_msg_count         = COND #( WHEN iv_msg_count IS NOT INITIAL THEN iv_msg_count ELSE is_data-msg_count )
        is_context           = COND #( WHEN is_context IS NOT INITIAL THEN is_context ELSE is_data-context )
        is_params            = COND #( WHEN is_params IS NOT INITIAL THEN is_params ELSE is_data-params )
        iv_cumulate          = iv_cumulate
        i_attachment         = i_attachment
        io_details           = io_details
      IMPORTING
        es_msg_handle        = es_msg_handle
        ev_msg_was_logged    = ev_msg_was_logged
        ev_msg_was_displayed = ev_msg_was_displayed.
  ENDMETHOD.


  METHOD add_bapiret1.
    CALL METHOD me->add
      EXPORTING
        iv_msgty             = is_data-type
        iv_msgid             = is_data-id
        iv_msgno             = is_data-number
        iv_msgv1             = is_data-message_v1
        iv_msgv2             = is_data-message_v2
        iv_msgv3             = is_data-message_v3
        iv_msgv4             = is_data-message_v4
        iv_msgv1_src         = iv_msgv1_src
        iv_msgv2_src         = iv_msgv2_src
        iv_msgv3_src         = iv_msgv3_src
        iv_msgv4_src         = iv_msgv4_src
        iv_detlevel          = iv_detlevel
        iv_probclass         = iv_probclass
        iv_alsort            = iv_alsort
        iv_time_stmp         = iv_time_stmp
        iv_msg_count         = iv_msg_count
        is_context           = is_context
        is_params            = is_params
        iv_cumulate          = iv_cumulate
        i_attachment         = i_attachment
        io_details           = io_details
      IMPORTING
        es_msg_handle        = es_msg_handle
        ev_msg_was_logged    = ev_msg_was_logged
        ev_msg_was_displayed = ev_msg_was_displayed.
  ENDMETHOD.


  METHOD add_bapiret2.
    CALL METHOD me->add
      EXPORTING
        iv_msgty             = is_data-type
        iv_msgid             = is_data-id
        iv_msgno             = is_data-number
        iv_msgv1             = is_data-message_v1
        iv_msgv2             = is_data-message_v2
        iv_msgv3             = is_data-message_v3
        iv_msgv4             = is_data-message_v4
        iv_msgv1_src         = iv_msgv1_src
        iv_msgv2_src         = iv_msgv2_src
        iv_msgv3_src         = iv_msgv3_src
        iv_msgv4_src         = iv_msgv4_src
        iv_detlevel          = iv_detlevel
        iv_probclass         = iv_probclass
        iv_alsort            = iv_alsort
        iv_time_stmp         = iv_time_stmp
        iv_msg_count         = iv_msg_count
        is_context           = is_context
        is_params            = is_params
        iv_cumulate          = iv_cumulate
        i_attachment         = i_attachment
        io_details           = io_details
      IMPORTING
        es_msg_handle        = es_msg_handle
        ev_msg_was_logged    = ev_msg_was_logged
        ev_msg_was_displayed = ev_msg_was_displayed.
  ENDMETHOD.


  METHOD add_bapireturn.
    CALL METHOD me->add
      EXPORTING
        iv_msgty             = is_data-type
        iv_msgid             = CONV symsgid( is_data-code+0(2) )
        iv_msgno             = CONV symsgno( is_data-code+2(3) )
        iv_msgv1             = is_data-message_v1
        iv_msgv2             = is_data-message_v2
        iv_msgv3             = is_data-message_v3
        iv_msgv4             = is_data-message_v4
        iv_msgv1_src         = iv_msgv1_src
        iv_msgv2_src         = iv_msgv2_src
        iv_msgv3_src         = iv_msgv3_src
        iv_msgv4_src         = iv_msgv4_src
        iv_detlevel          = iv_detlevel
        iv_probclass         = iv_probclass
        iv_alsort            = iv_alsort
        iv_time_stmp         = iv_time_stmp
        iv_msg_count         = iv_msg_count
        is_context           = is_context
        is_params            = is_params
        iv_cumulate          = iv_cumulate
        i_attachment         = i_attachment
        io_details           = io_details
      IMPORTING
        es_msg_handle        = es_msg_handle
        ev_msg_was_logged    = ev_msg_was_logged
        ev_msg_was_displayed = ev_msg_was_displayed.
  ENDMETHOD.


  METHOD add_bdcmsgcoll.
    CALL METHOD me->add
      EXPORTING
        iv_msgty             = is_data-msgtyp
        iv_msgid             = is_data-msgid
        iv_msgno             = CONV symsgno( is_data-msgnr )
        iv_msgv1             = CONV symsgv( is_data-msgv1 )
        iv_msgv2             = CONV symsgv( is_data-msgv2 )
        iv_msgv3             = CONV symsgv( is_data-msgv3 )
        iv_msgv4             = CONV symsgv( is_data-msgv4 )
        iv_msgv1_src         = iv_msgv1_src
        iv_msgv2_src         = iv_msgv2_src
        iv_msgv3_src         = iv_msgv3_src
        iv_msgv4_src         = iv_msgv4_src
        iv_detlevel          = iv_detlevel
        iv_probclass         = iv_probclass
        iv_alsort            = iv_alsort
        iv_time_stmp         = iv_time_stmp
        iv_msg_count         = iv_msg_count
        is_context           = is_context
        is_params            = is_params
        iv_cumulate          = iv_cumulate
        i_attachment         = i_attachment
        io_details           = io_details
      IMPORTING
        es_msg_handle        = es_msg_handle
        ev_msg_was_logged    = ev_msg_was_logged
        ev_msg_was_displayed = ev_msg_was_displayed.
  ENDMETHOD.


  METHOD add_exc.
    DATA ls_params TYPE bal_s_parm.
    DATA ls_msg TYPE symsg.
    DATA lv_text TYPE string.
    DATA lo_exc_desc TYPE REF TO cl_instance_description.
    DATA lo_exception TYPE REF TO cx_root.
    FIELD-SYMBOLS <ls_exc> TYPE zcl_log_attachment=>mts_exception.

    ro_log = me.
    lo_exception = COND #(
      WHEN io_exception IS INSTANCE OF cx_sy_no_handler
      THEN io_exception->previous ELSE io_exception
    ).
    lo_exc_desc = NEW #( the_subject = lo_exception ).
    lv_text = lo_exception->get_text( ).
    IF lv_text IS INITIAL.
      lv_text = |<{ lo_exc_desc->class_name }>|.
    ENDIF.
    IF lo_exception IS INSTANCE OF if_t100_message.
      IF lo_exception IS INSTANCE OF if_t100_dyn_msg AND iv_msgty IS NOT SUPPLIED.
        ls_msg-msgty = CAST if_t100_dyn_msg( lo_exception )->msgty.
      ENDIF.
      DATA(ls_t100key) = CAST if_t100_message( lo_exception )->t100key.
      ls_msg-msgid = ls_t100key-msgid.
      ls_msg-msgno = ls_t100key-msgno.
      DO 4 TIMES.
        ASSIGN COMPONENT |ATTR{ sy-index }| OF STRUCTURE ls_t100key TO FIELD-SYMBOL(<lv_attr>).
        ASSIGN COMPONENT |MSGV{ sy-index }| OF STRUCTURE ls_msg TO FIELD-SYMBOL(<lv_msgv>).
        DATA(lv_attr) = |{ <lv_attr> }|.
        CHECK lv_attr IS NOT INITIAL.
        ASSIGN lo_exception->(lv_attr) TO FIELD-SYMBOL(<lv_val>).
        CHECK sy-subrc EQ 0.
        MOVE <lv_val> TO <lv_msgv>.
      ENDDO.
    ELSE.
      ls_msg = free_text_to_msg( lv_text ).
    ENDIF.
    IF ls_msg-msgty IS INITIAL.
      ls_msg-msgty = iv_msgty.
    ENDIF.

    IF is_params IS NOT INITIAL OR iv_text_only IS NOT INITIAL.
      ls_params = is_params.
    ELSEIF i_attachment IS NOT INITIAL.
      ls_params = zcl_log_attachment=>from_any(
          i_attachment  = i_attachment
          iv_log_handle = mv_log_handle ).
    ELSE.
      ls_params = zcl_log_attachment=>from_exception(
          io_exception  = lo_exception
          iv_log_handle = mv_log_handle ).
    ENDIF.

    CALL METHOD me->add
      EXPORTING
        iv_msgty             = ls_msg-msgty
        iv_msgid             = ls_msg-msgid
        iv_msgno             = ls_msg-msgno
        iv_msgv1             = ls_msg-msgv1
        iv_msgv2             = ls_msg-msgv2
        iv_msgv3             = ls_msg-msgv3
        iv_msgv4             = ls_msg-msgv4
        iv_msgv1_src         = iv_msgv1_src
        iv_msgv2_src         = iv_msgv2_src
        iv_msgv3_src         = iv_msgv3_src
        iv_msgv4_src         = iv_msgv4_src
        iv_detlevel          = iv_detlevel
        iv_probclass         = iv_probclass
        iv_alsort            = iv_alsort
        iv_time_stmp         = iv_time_stmp
        iv_msg_count         = iv_msg_count
        is_context           = is_context
        is_params            = ls_params
        iv_cumulate          = iv_cumulate
        i_attachment         = i_attachment
        io_details           = io_details
      IMPORTING
        es_msg_handle        = es_msg_handle
        ev_msg_was_logged    = ev_msg_was_logged
        ev_msg_was_displayed = ev_msg_was_displayed.
  ENDMETHOD.


  METHOD add_exception.
    DATA ls_exc TYPE bal_s_exc.
    DATA ls_msg TYPE bal_s_msg.

    ro_log = me.

    CLEAR ls_exc.
    ls_exc-exception = COND #(
      WHEN io_exception IS INSTANCE OF cx_sy_no_handler
      THEN io_exception->previous ELSE io_exception
    ).
    ls_exc-msgty = iv_msgty.
    IF ls_exc-exception IS INSTANCE OF if_t100_dyn_msg AND iv_msgty IS NOT SUPPLIED.
      ls_exc-msgty = CAST if_t100_dyn_msg( ls_exc-exception )->msgty.
    ENDIF.
    ls_exc-detlevel = iv_detlevel.
    ls_exc-probclass = iv_probclass.
    ls_exc-alsort = iv_alsort.
    ls_exc-time_stmp = iv_time_stmp.
    ls_exc-msg_count = iv_msg_count.

    CALL FUNCTION 'BAL_LOG_EXCEPTION_ADD'
      EXPORTING
        i_log_handle        = mv_log_handle
        i_s_exc             = ls_exc
      IMPORTING
        e_s_msg_handle      = es_msg_handle
        e_msg_was_logged    = ev_msg_was_logged
        e_msg_was_displayed = ev_msg_was_displayed
      EXCEPTIONS
        log_not_found       = 1
        msg_inconsistent    = 2
        log_is_full         = 3
        OTHERS              = 4.
    CASE sy-subrc.
      WHEN 0.
        ADD 1 TO mv_msg_count.
      WHEN 1.
        raise_exception( iv_function = 'BAL_LOG_EXCEPTION_ADD' iv_exception = 'LOG_NOT_FOUND' ).
      WHEN 2.
        raise_exception( iv_function = 'BAL_LOG_EXCEPTION_ADD' iv_exception = 'MSG_INCONSISTENT' ).
      WHEN 3.
        raise_exception( iv_function = 'BAL_LOG_EXCEPTION_ADD' iv_exception = 'LOG_IS_FULL' ).
      WHEN 4.
        raise_exception( iv_function = 'BAL_LOG_EXCEPTION_ADD' iv_exception = 'OTHERS' ).
    ENDCASE.

    compute_typeclass( iv_msgty = iv_msgty ).
  ENDMETHOD.


  METHOD add_fimsg.
    DATA lv_alsort TYPE balsort.
    DATA lv_detlevel TYPE ballevel.
    DATA lv_probclass TYPE balprobcl.

    IF iv_alsort IS NOT INITIAL.
      lv_alsort = iv_alsort.
    ELSEIF strlen( is_data-msort ) LE 3.
      lv_alsort = is_data-msort.
    ENDIF.
    IF iv_detlevel IS NOT INITIAL.
      lv_detlevel = iv_detlevel.
    ELSEIF strlen( is_data-msgpr ) EQ 1 AND is_data-msgpr CO '123456789'.
      lv_detlevel = is_data-msgpr.
    ENDIF.
    IF iv_probclass IS NOT INITIAL.
      lv_probclass = iv_probclass.
    ELSEIF strlen( is_data-msgpr ) EQ 1 AND is_data-msgpr CO '1234'.
      lv_probclass = is_data-msgpr.
    ENDIF.

    CALL METHOD me->add
      EXPORTING
        iv_msgty             = is_data-msgty
        iv_msgid             = is_data-msgid
        iv_msgno             = is_data-msgno
        iv_msgv1             = is_data-msgv1
        iv_msgv2             = is_data-msgv2
        iv_msgv3             = is_data-msgv3
        iv_msgv4             = is_data-msgv4
        iv_msgv1_src         = iv_msgv1_src
        iv_msgv2_src         = iv_msgv2_src
        iv_msgv3_src         = iv_msgv3_src
        iv_msgv4_src         = iv_msgv4_src
        iv_detlevel          = lv_detlevel
        iv_probclass         = lv_probclass
        iv_alsort            = lv_alsort
        iv_time_stmp         = iv_time_stmp
        iv_msg_count         = iv_msg_count
        is_context           = is_context
        is_params            = is_params
        iv_cumulate          = iv_cumulate
        i_attachment         = i_attachment
        io_details           = io_details
      IMPORTING
        es_msg_handle        = es_msg_handle
        ev_msg_was_logged    = ev_msg_was_logged
        ev_msg_was_displayed = ev_msg_was_displayed.
  ENDMETHOD.


  METHOD add_free_text.
    DATA ls_msg TYPE symsg.
    FIELD-SYMBOLS <i_attachment> TYPE any.

    ro_log = me.

    ls_msg = free_text_to_msg( iv_text ).

    IF i_attachment IS INITIAL.
      ASSIGN space TO <i_attachment>.
    ELSE.
      ASSIGN i_attachment TO <i_attachment>.
    ENDIF.
    DO 1 TIMES.
      CHECK is_context IS INITIAL.
      CHECK is_params IS INITIAL.
      CHECK i_attachment IS INITIAL.
      CHECK strlen( iv_text ) GT 200.
      ASSIGN iv_text TO <i_attachment>.
    ENDDO.

    CALL METHOD me->add
      EXPORTING
        iv_msgty             = iv_msgty
        iv_msgid             = ls_msg-msgid
        iv_msgno             = ls_msg-msgno
        iv_msgv1             = ls_msg-msgv1
        iv_msgv2             = ls_msg-msgv2
        iv_msgv3             = ls_msg-msgv3
        iv_msgv4             = ls_msg-msgv4
        iv_msgv1_src         = iv_msgv1_src
        iv_msgv2_src         = iv_msgv2_src
        iv_msgv3_src         = iv_msgv3_src
        iv_msgv4_src         = iv_msgv4_src
        iv_detlevel          = iv_detlevel
        iv_probclass         = iv_probclass
        iv_alsort            = iv_alsort
        iv_time_stmp         = iv_time_stmp
        iv_msg_count         = iv_msg_count
        is_context           = is_context
        is_params            = is_params
        iv_cumulate          = iv_cumulate
        i_attachment         = <i_attachment>
        io_details           = io_details
      IMPORTING
        es_msg_handle        = es_msg_handle
        ev_msg_was_logged    = ev_msg_was_logged
        ev_msg_was_displayed = ev_msg_was_displayed.
  ENDMETHOD.


  METHOD add_log.
    DATA lt_msg_self TYPE bal_t_msgr.
    DATA lt_msg TYPE bal_t_msgr.
    DATA lv_time_stmp TYPE bal_s_msgr-time_stmp.
    FIELD-SYMBOLS <ls_msg> TYPE bal_s_msgr.

    ro_log = me.

    CALL FUNCTION 'BAL_LOG_READ'
      EXPORTING
        i_log_handle  = io_log->mv_log_handle
      IMPORTING
        et_msg        = lt_msg
      EXCEPTIONS
        log_not_found = 1
        OTHERS        = 2.
    CASE sy-subrc.
      WHEN 1.
        raise_exception( iv_function = 'BAL_LOG_READ' iv_exception = 'LOG_NOT_FOUND' ).
      WHEN 2.
        raise_exception( iv_function = 'BAL_LOG_READ' iv_exception = 'OTHERS' ).
    ENDCASE.
    CHECK lt_msg[] IS NOT INITIAL.

    read( IMPORTING et_msg = lt_msg_self ).
    lv_time_stmp = REDUCE #( " Max TIME_STMP
        INIT time_stmp_max = VALUE #( )
        FOR wa_msg IN lt_msg_self WHERE ( time_stmp IS NOT INITIAL )
        NEXT time_stmp_max = nmax( val1 = time_stmp_max val2 = wa_msg-time_stmp ) ).

    LOOP AT lt_msg ASSIGNING <ls_msg>.
      IF <ls_msg>-time_stmp IS NOT INITIAL.
        IF lv_time_stmp IS NOT INITIAL.
          <ls_msg>-time_stmp = nmax( val1 = lv_time_stmp val2 = <ls_msg>-time_stmp ).
        ENDIF.
        lv_time_stmp = <ls_msg>-time_stmp.
      ENDIF.
      CALL METHOD add
        EXPORTING
          iv_msgty     = <ls_msg>-msgty
          iv_msgid     = <ls_msg>-msgid
          iv_msgno     = <ls_msg>-msgno
          iv_msgv1     = <ls_msg>-msgv1
          iv_msgv2     = <ls_msg>-msgv2
          iv_msgv3     = <ls_msg>-msgv3
          iv_msgv4     = <ls_msg>-msgv4
          iv_msgv1_src = <ls_msg>-msgv1_src
          iv_msgv2_src = <ls_msg>-msgv2_src
          iv_msgv3_src = <ls_msg>-msgv3_src
          iv_msgv4_src = <ls_msg>-msgv4_src
          iv_detlevel  = <ls_msg>-detlevel
          iv_probclass = <ls_msg>-probclass
          iv_alsort    = <ls_msg>-alsort
          iv_time_stmp = <ls_msg>-time_stmp
          iv_msg_count = <ls_msg>-msg_count
          is_context   = <ls_msg>-context
          is_params    = <ls_msg>-params.
    ENDLOOP.
  ENDMETHOD.


  METHOD add_mesg.
    CALL METHOD me->add
      EXPORTING
        iv_msgty             = is_data-msgty
        iv_msgid             = is_data-arbgb
        iv_msgno             = CONV symsgno( is_data-txtnr )
        iv_msgv1             = is_data-msgv1
        iv_msgv2             = is_data-msgv2
        iv_msgv3             = is_data-msgv3
        iv_msgv4             = is_data-msgv4
        iv_msgv1_src         = iv_msgv1_src
        iv_msgv2_src         = iv_msgv2_src
        iv_msgv3_src         = iv_msgv3_src
        iv_msgv4_src         = iv_msgv4_src
        iv_detlevel          = iv_detlevel
        iv_probclass         = iv_probclass
        iv_alsort            = iv_alsort
        iv_time_stmp         = iv_time_stmp
        iv_msg_count         = iv_msg_count
        is_context           = is_context
        is_params            = is_params
        iv_cumulate          = iv_cumulate
        i_attachment         = i_attachment
        io_details           = io_details
      IMPORTING
        es_msg_handle        = es_msg_handle
        ev_msg_was_logged    = ev_msg_was_logged
        ev_msg_was_displayed = ev_msg_was_displayed.
  ENDMETHOD.


  METHOD add_struct.
    ro_log = me.

    DATA(lo_structdescr) = cl_abap_structdescr=>describe_by_data( p_data = is_data ).
    DATA(lv_method) = |ADD_{ lo_structdescr->get_relative_name( ) }|.

    CALL METHOD me->(lv_method)
      EXPORTING
        is_data              = is_data
        iv_msgv1_src         = iv_msgv1_src
        iv_msgv2_src         = iv_msgv2_src
        iv_msgv3_src         = iv_msgv3_src
        iv_msgv4_src         = iv_msgv4_src
        iv_detlevel          = iv_detlevel
        iv_probclass         = iv_probclass
        iv_alsort            = iv_alsort
        iv_time_stmp         = iv_time_stmp
        iv_msg_count         = iv_msg_count
        is_context           = is_context
        is_params            = is_params
        iv_cumulate          = iv_cumulate
        i_attachment         = i_attachment
      IMPORTING
        es_msg_handle        = es_msg_handle
        ev_msg_was_logged    = ev_msg_was_logged
        ev_msg_was_displayed = ev_msg_was_displayed.
  ENDMETHOD.


  METHOD add_syst.
    ro_log = me.

    CALL METHOD me->add
      EXPORTING
        iv_msgty             = is_data-msgty
        iv_msgid             = is_data-msgid
        iv_msgno             = is_data-msgno
        iv_msgv1             = is_data-msgv1
        iv_msgv2             = is_data-msgv2
        iv_msgv3             = is_data-msgv3
        iv_msgv4             = is_data-msgv4
        iv_msgv1_src         = iv_msgv1_src
        iv_msgv2_src         = iv_msgv2_src
        iv_msgv3_src         = iv_msgv3_src
        iv_msgv4_src         = iv_msgv4_src
        iv_detlevel          = iv_detlevel
        iv_probclass         = iv_probclass
        iv_alsort            = iv_alsort
        iv_time_stmp         = iv_time_stmp
        iv_msg_count         = iv_msg_count
        is_context           = is_context
        is_params            = is_params
        iv_cumulate          = iv_cumulate
        i_attachment         = i_attachment
        io_details           = io_details
      IMPORTING
        es_msg_handle        = es_msg_handle
        ev_msg_was_logged    = ev_msg_was_logged
        ev_msg_was_displayed = ev_msg_was_displayed.
  ENDMETHOD.


  METHOD add_table.
    DATA ls_params TYPE bal_s_parm.

    ro_log = me.

    IF is_params IS NOT INITIAL.
      ls_params = is_params.
    ELSEIF i_attachment IS NOT INITIAL.
      ls_params = zcl_log_attachment=>from_any(
          i_attachment  = i_attachment
          iv_log_handle = mv_log_handle ).
    ELSE.
      CLEAR ls_params.
    ENDIF.

    LOOP AT it_data ASSIGNING FIELD-SYMBOL(<ls_data>).
      CALL METHOD me->add_struct
        EXPORTING
          is_data              = <ls_data>
          iv_msgv1_src         = iv_msgv1_src
          iv_msgv2_src         = iv_msgv2_src
          iv_msgv3_src         = iv_msgv3_src
          iv_msgv4_src         = iv_msgv4_src
          iv_detlevel          = iv_detlevel
          iv_probclass         = iv_probclass
          iv_alsort            = iv_alsort
*         iv_time_stmp         = iv_time_stmp
          iv_msg_count         = iv_msg_count
          is_context           = is_context
          is_params            = ls_params
          io_details           = io_details
          iv_cumulate          = iv_cumulate
        IMPORTING
          es_msg_handle        = es_msg_handle
          ev_msg_was_logged    = ev_msg_was_logged
          ev_msg_was_displayed = ev_msg_was_displayed.
    ENDLOOP.
  ENDMETHOD.


  METHOD change.
    DATA ls_msg_src TYPE bal_s_msg.
    DATA ls_msg TYPE bal_s_msg.

    ro_log = me.

    CLEAR ls_msg.
    ls_msg-msgty     = iv_msgty.
    ls_msg-msgid     = iv_msgid.
    ls_msg-msgno     = iv_msgno.
    ls_msg-msgv1     = iv_msgv1.
    ls_msg-msgv2     = iv_msgv2.
    ls_msg-msgv3     = iv_msgv3.
    ls_msg-msgv4     = iv_msgv4.
    ls_msg-msgv1_src = iv_msgv1_src.
    ls_msg-msgv2_src = iv_msgv2_src.
    ls_msg-msgv3_src = iv_msgv3_src.
    ls_msg-msgv4_src = iv_msgv4_src.
    ls_msg-detlevel  = iv_detlevel.
    ls_msg-probclass = iv_probclass.
    ls_msg-alsort    = iv_alsort.
    ls_msg-time_stmp = iv_time_stmp.
    ls_msg-msg_count = iv_msg_count.
    ls_msg-context   = is_context.
    IF is_params IS NOT INITIAL.
      ls_msg-params = is_params.
    ELSEIF i_attachment IS NOT INITIAL.
      ls_msg-params = zcl_log_attachment=>from_any(
          i_attachment  = i_attachment
          iv_log_handle = mv_log_handle ).
    ELSEIF io_details IS BOUND.
      ls_msg-params = get_params_from_details( io_details ).
    ENDIF.

    CALL FUNCTION 'BAL_LOG_MSG_READ'
      EXPORTING
        i_s_msg_handle = is_msg_handle
      IMPORTING
        e_s_msg        = ls_msg_src
      EXCEPTIONS
        log_not_found  = 1
        msg_not_found  = 2
        OTHERS         = 3.
    CASE sy-subrc.
      WHEN 1.
        raise_exception( iv_function = 'BAL_LOG_MSG_READ' iv_exception = 'LOG_NOT_FOUND' ).
      WHEN 2.
        raise_exception( iv_function = 'BAL_LOG_MSG_READ' iv_exception = 'MSG_NOT_FOUND' ).
      WHEN 3.
        raise_exception( iv_function = 'BAL_LOG_MSG_READ' iv_exception = 'OTHERS' ).
    ENDCASE.

    IF ls_msg-detlevel IS INITIAL.
      ls_msg-detlevel = ls_msg_src-detlevel.
    ENDIF.
    IF ls_msg-probclass IS INITIAL.
      ls_msg-probclass = ls_msg_src-probclass.
    ENDIF.
    IF ls_msg-alsort IS INITIAL.
      ls_msg-alsort = ls_msg_src-alsort.
    ENDIF.
    IF ls_msg-time_stmp IS INITIAL.
      ls_msg-time_stmp = ls_msg_src-time_stmp.
    ENDIF.
    IF ls_msg-msg_count IS INITIAL.
      ls_msg-msg_count = ls_msg_src-msg_count.
    ENDIF.
    IF ls_msg-context IS INITIAL.
      ls_msg-context = ls_msg_src-context.
    ENDIF.
    IF ls_msg-params IS INITIAL.
      ls_msg-params = ls_msg_src-params.
    ENDIF.

    CALL FUNCTION 'BAL_LOG_MSG_CHANGE'
      EXPORTING
        i_s_msg_handle   = is_msg_handle
        i_s_msg          = ls_msg
      EXCEPTIONS
        log_not_found    = 1
        msg_inconsistent = 2
        msg_not_found    = 3.
    CASE sy-subrc.
      WHEN 1.
        raise_exception( iv_function = 'BAL_LOG_MSG_CHANGE' iv_exception = 'LOG_NOT_FOUND' ).
      WHEN 2.
        raise_exception( iv_function = 'BAL_LOG_MSG_CHANGE' iv_exception = 'MSG_INCONSISTENT' ).
      WHEN 3.
        raise_exception( iv_function = 'BAL_LOG_MSG_CHANGE' iv_exception = 'MSG_NOT_FOUND' ).
      WHEN 4.
        raise_exception( iv_function = 'BAL_LOG_MSG_CHANGE' iv_exception = 'OTHERS' ).
    ENDCASE.

    compute_typeclass( ).
  ENDMETHOD.


  METHOD change_from_syst.
    ro_log = me.

    CALL METHOD me->change
      EXPORTING
        is_msg_handle = is_msg_handle
        iv_msgty      = is_data-msgty
        iv_msgid      = is_data-msgid
        iv_msgno      = is_data-msgno
        iv_msgv1      = is_data-msgv1
        iv_msgv2      = is_data-msgv2
        iv_msgv3      = is_data-msgv3
        iv_msgv4      = is_data-msgv4
        iv_msgv1_src  = iv_msgv1_src
        iv_msgv2_src  = iv_msgv2_src
        iv_msgv3_src  = iv_msgv3_src
        iv_msgv4_src  = iv_msgv4_src
        iv_detlevel   = iv_detlevel
        iv_probclass  = iv_probclass
        iv_alsort     = iv_alsort
        iv_time_stmp  = iv_time_stmp
        iv_msg_count  = iv_msg_count
        is_context    = is_context
        is_params     = is_params
        i_attachment  = i_attachment
        io_details    = io_details.
  ENDMETHOD.


  METHOD check_errors.
    IF has_errors( ) EQ abap_true.
      RAISE EXCEPTION TYPE zcx_log_errors
        EXPORTING
          log = me.
    ENDIF.
  ENDMETHOD.


  METHOD clear.
    CLEAR: mv_msg_count, mv_type_class, mv_type_class3.

    ro_log = me.

    CALL FUNCTION 'BAL_LOG_MSG_DELETE_ALL'
      EXPORTING
        i_log_handle  = mv_log_handle
      EXCEPTIONS
        log_not_found = 1
        OTHERS        = 2.
    CASE sy-subrc.
      WHEN 1.
        raise_exception( iv_function = 'BAL_LOG_MSG_DELETE_ALL' iv_exception = 'LOG_NOT_FOUND' ).
      WHEN 2.
        raise_exception( iv_function = 'BAL_LOG_MSG_DELETE_ALL' iv_exception = 'OTHERS' ).
    ENDCASE.
  ENDMETHOD.


  METHOD commit.
    ro_log = me.

    IF iv_in_update_task EQ abap_true.
      CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'
        EXPORTING
          wait = abap_true.
    ELSE.
      CALL FUNCTION 'DB_COMMIT'.
    ENDIF.
  ENDMETHOD.


  METHOD compute_typeclass.
    CONSTANTS lc_probclass TYPE string VALUE ' SIWEAX'.

    IF iv_msgty IS NOT SUPPLIED.
      CLEAR: mv_type_class, mv_type_class3.
      read( IMPORTING et_msg = DATA(lt_msg) ).
      mv_msg_count = lines( lt_msg ).
      LOOP AT lt_msg ASSIGNING FIELD-SYMBOL(<ls_msg>).
        compute_typeclass( iv_msgty = <ls_msg>-msgty ).
      ENDLOOP.
      RETURN.
    ENDIF.

    DATA(lv_level) = COND #( WHEN lc_probclass CA mv_type_class THEN sy-fdpos ELSE 0 ).
    DATA(lv_level_new) = COND #( WHEN lc_probclass CA iv_msgty THEN sy-fdpos ELSE 0 ).

    CHECK lv_level_new GE lv_level.

    mv_type_class = lc_probclass+lv_level_new(1).
    CASE mv_type_class.
      WHEN ' '. mv_type_class3 = 'S'.
      WHEN 'S'. mv_type_class3 = 'S'.
      WHEN 'I'. mv_type_class3 = 'S'.
      WHEN 'W'. mv_type_class3 = 'W'.
      WHEN 'E'. mv_type_class3 = 'E'.
      WHEN 'A'. mv_type_class3 = 'E'.
      WHEN 'X'. mv_type_class3 = 'E'.
    ENDCASE.
  ENDMETHOD.


  METHOD constructor.
    DATA(ls_msg_syst) = CORRESPONDING daag_s_t100_message( sy ).
    DATA(ls_log) = VALUE bal_s_log(
        extnumber  = iv_extnumber
        object     = iv_object
        subobject  = iv_subobject
        aldate     = iv_aldate
        altime     = iv_altime
        aluser     = iv_aluser
        altcode    = iv_altcode
        alprog     = iv_alprog
        almode     = iv_almode
        alchdate   = iv_alchdate
        alchtime   = iv_alchtime
        alchuser   = iv_alchuser
        aldate_del = iv_aldate_del
        del_before = iv_del_before
        alstate    = iv_alstate
        context    = is_context
        params     = is_params
    ).
    IF ls_log-aldate_del IS INITIAL.
      IF ls_log-object IS INITIAL.
        ls_log-aldate_del = sy-datum + 12.
      ELSE.
        ls_log-aldate_del = sy-datum + 1200.
      ENDIF.
    ENDIF.

    IF iv_log_handle IS INITIAL.
      CALL FUNCTION 'BAL_LOG_CREATE'
        EXPORTING
          i_s_log                 = ls_log
        IMPORTING
          e_log_handle            = mv_log_handle
        EXCEPTIONS
          log_header_inconsistent = 1
          OTHERS                  = 2.
      CASE sy-subrc.
        WHEN 1.
          raise_exception( iv_function = 'BAL_LOG_CREATE' iv_exception = 'LOG_HEADER_INCONSISTENT' ).
        WHEN 2.
          raise_exception( iv_function = 'BAL_LOG_CREATE' iv_exception = 'OTHERS' ).
      ENDCASE.
    ELSE.
      CALL FUNCTION 'BAL_DB_LOAD'
        EXPORTING
          i_t_log_handle     = VALUE bal_t_logh( ( iv_log_handle ) )
        EXCEPTIONS
          no_logs_specified  = 1
          log_not_found      = 2
          log_already_loaded = 3
          OTHERS             = 4.
      CASE sy-subrc.
        WHEN 0.
          mv_log_handle = iv_log_handle.
        WHEN 1.
          raise_exception( iv_function = 'BAL_DB_LOAD' iv_exception = 'NO_LOGS_SPECIFIED' ).
        WHEN 2.
          raise_exception( iv_function = 'BAL_DB_LOAD' iv_exception = 'LOG_NOT_FOUND' ).
        WHEN 3.
          raise_exception( iv_function = 'BAL_DB_LOAD' iv_exception = 'LOG_ALREADY_LOADED' ).
        WHEN 4.
          raise_exception( iv_function = 'BAL_DB_LOAD' iv_exception = 'OTHERS' ).
      ENDCASE.
    ENDIF.

    compute_typeclass( ).
    MOVE-CORRESPONDING ls_msg_syst TO sy.
  ENDMETHOD.


  METHOD del.
    ro_log = me.

    CALL FUNCTION 'BAL_LOG_MSG_DELETE'
      EXPORTING
        i_s_msg_handle = is_msg_handle
      EXCEPTIONS
        msg_not_found  = 1
        log_not_found  = 2
        OTHERS         = 3.
    CASE sy-subrc.
      WHEN 1.
        raise_exception( iv_function = 'BAL_LOG_MSG_DELETE' iv_exception = 'MSG_NOT_FOUND' ).
      WHEN 2.
        raise_exception( iv_function = 'BAL_LOG_MSG_DELETE' iv_exception = 'LOG_NOT_FOUND' ).
      WHEN 3.
        raise_exception( iv_function = 'BAL_LOG_MSG_DELETE' iv_exception = 'OTHERS' ).
    ENDCASE.

    compute_typeclass( ).
  ENDMETHOD.


  METHOD display.
    DATA lt_context_table TYPE TABLE OF bal_s_cont-tabname.
    DATA ls_display_profile TYPE bal_s_prof.
    DATA lt_log_handle TYPE bal_t_logh.
    DATA lv_fm TYPE rs38l-name.
    APPEND mv_log_handle TO lt_log_handle.

    IF iv_profile IS NOT INITIAL AND is_display_profile IS NOT INITIAL.
      raise_exception( iv_function = 'BAL_DSP_LOG_DISPLAY' iv_exception = 'PROFILE_INCONSISTENT' ).
    ENDIF.
    IF is_display_profile IS NOT INITIAL.
      ls_display_profile = is_display_profile.
    ENDIF.
    IF iv_profile IS NOT INITIAL.
      lv_fm = |BAL_DSP_PROFILE_{ iv_profile }_GET|.

      CALL FUNCTION 'FUNCTION_EXISTS'
        EXPORTING
          funcname           = lv_fm
        EXCEPTIONS
          function_not_exist = 1.
      IF sy-subrc NE 0.
        raise_exception( iv_function = 'FUNCTION_EXISTS' iv_exception = 'FUNCTION_NOT_EXIST' ).
      ENDIF.

      CALL FUNCTION lv_fm
        IMPORTING
          e_s_display_profile = ls_display_profile.

      ls_display_profile-use_grid = abap_true.

      CASE iv_profile.
        WHEN 'POPUP'.
          IF line_exists( ls_display_profile-mess_fcat[ ref_field = 'ALSORT' ] ).
            LOOP AT read_msg( ) TRANSPORTING NO FIELDS
              WHERE alsort IS NOT INITIAL.
              EXIT.
            ENDLOOP.
            IF sy-subrc EQ 0.
              ls_display_profile-mess_fcat[ ref_field = 'ALSORT' ]-no_out = space.
              ls_display_profile-mess_fcat[ ref_field = 'ALSORT' ]-col_pos = lines( ls_display_profile-mess_fcat ) - 1.
            ENDIF.
          ENDIF.
          ls_display_profile-start_col = 5.
          ls_display_profile-start_row = 4.
          ls_display_profile-end_col = 120.
          ls_display_profile-end_row = 24.
        WHEN OTHERS.
      ENDCASE.

      IF NOT line_exists( ls_display_profile-mess_fcat[ ref_field = 'MSG_STMP' ] ).
        APPEND VALUE #(
          ref_table = 'BAL_S_SHOW'
          ref_field = 'MSG_STMP'
          col_pos   = lines( ls_display_profile-mess_fcat ) + 1
        ) TO ls_display_profile-mess_fcat.
      ENDIF.
      ls_display_profile-mess_fcat[ ref_field = 'MSG_STMP' ]-no_out = space.
      ls_display_profile-mess_fcat[ ref_field = 'MSG_STMP' ]-col_pos = lines( ls_display_profile-mess_fcat ) + 1.

      LOOP AT read_msg( ) ASSIGNING FIELD-SYMBOL(<ls_msg>)
        WHERE context IS NOT INITIAL.
        COLLECT <ls_msg>-context-tabname INTO lt_context_table.
      ENDLOOP.
      LOOP AT lt_context_table INTO DATA(lv_context_table).
        TRY.
            DATA(lo_structdescr) = cl_abap_structdescr=>describe_by_name( lv_context_table ).
            DATA(lt_components) = CAST cl_abap_structdescr( lo_structdescr )->components.
            LOOP AT lt_components INTO DATA(ls_component).
              APPEND VALUE #(
                ref_table = lv_context_table
                ref_field = ls_component-name
                col_pos   = lines( ls_display_profile-mess_fcat ) + 1
              ) TO ls_display_profile-mess_fcat.
            ENDLOOP.
          CATCH cx_root.
        ENDTRY.
      ENDLOOP.
    ENDIF.
    IF is_variant IS NOT INITIAL.
      ls_display_profile-disvariant = is_variant.
    ENDIF.

    CALL FUNCTION 'BAL_DSP_LOG_DISPLAY'
      EXPORTING
        i_s_display_profile    = ls_display_profile
        i_t_log_handle         = lt_log_handle
        i_t_msg_handle         = it_msg_handle
        i_s_log_filter         = is_log_filter
        i_s_msg_filter         = is_msg_filter
        i_t_log_context_filter = it_log_context_filter
        i_t_msg_context_filter = it_msg_context_filter
        i_amodal               = iv_amodal
        i_srt_by_timstmp       = iv_srt_by_timstmp
      IMPORTING
        e_s_exit_command       = rs_exit_command
      EXCEPTIONS
        profile_inconsistent   = 1
        internal_error         = 2
        no_data_available      = 3
        no_authority           = 4
        OTHERS                 = 5.
    CASE sy-subrc.
      WHEN 1.
        raise_exception( iv_function = 'BAL_DSP_LOG_DISPLAY' iv_exception = 'PROFILE_INCONSISTENT' ).
      WHEN 2.
        raise_exception( iv_function = 'BAL_DSP_LOG_DISPLAY' iv_exception = 'INTERNAL_ERROR' ).
      WHEN 3.
        raise_exception( iv_function = 'BAL_DSP_LOG_DISPLAY' iv_exception = 'NO_DATA_AVAILABLE' ).
      WHEN 4.
        raise_exception( iv_function = 'BAL_DSP_LOG_DISPLAY' iv_exception = 'NO_AUTHORITY' ).
      WHEN 5.
        raise_exception( iv_function = 'BAL_DSP_LOG_DISPLAY' iv_exception = 'OTHERS' ).
    ENDCASE.
  ENDMETHOD.


  METHOD free_text_from_msg.
    DATA: BEGIN OF ls_text,
            part1 TYPE symsgv,
            part2 TYPE symsgv,
            part3 TYPE symsgv,
            part4 TYPE symsgv,
          END OF ls_text.

    IF is_msg-msgid = mc_freetext_msgid AND
       is_msg-msgno = mc_freetext_msgno.
      ls_text-part1 = is_msg-msgv1.
      ls_text-part2 = is_msg-msgv2.
      ls_text-part3 = is_msg-msgv3.
      ls_text-part4 = is_msg-msgv4.
      rv_text = ls_text.
    ELSE.
      MESSAGE ID is_msg-msgid TYPE is_msg-msgty NUMBER is_msg-msgno
        WITH is_msg-msgv1 is_msg-msgv2 is_msg-msgv3 is_msg-msgv4
        INTO rv_text.
    ENDIF.
  ENDMETHOD.


  METHOD free_text_to_msg.
    DATA: BEGIN OF ls_text,
            part1 TYPE symsgv,
            part2 TYPE symsgv,
            part3 TYPE symsgv,
            part4 TYPE symsgv,
          END OF ls_text.

    ls_text = iv_text.

    rs_msg-msgid = mc_freetext_msgid.
    rs_msg-msgno = mc_freetext_msgno.
    rs_msg-msgv1 = ls_text-part1.
    rs_msg-msgv2 = ls_text-part2.
    rs_msg-msgv3 = ls_text-part3.
    rs_msg-msgv4 = ls_text-part4.
  ENDMETHOD.


  METHOD has_errors.
    rv_value = xsdbool( mv_type_class3 EQ rs_c_error ).
  ENDMETHOD.


  METHOD has_messages.
    rv_value = xsdbool( mv_msg_count GT 0 ).
  ENDMETHOD.


  METHOD modal.
    DATA lt_msg TYPE bal_t_msgr.
    FIELD-SYMBOLS <ls_msg> TYPE bal_s_msgr.

    CALL METHOD read
      IMPORTING
        et_msg = lt_msg.
    CHECK lt_msg[] IS NOT INITIAL.

    CALL FUNCTION 'MESSAGES_INITIALIZE'.

    LOOP AT lt_msg ASSIGNING <ls_msg>.
      CALL FUNCTION 'MESSAGE_STORE'
        EXPORTING
          msgty = <ls_msg>-msgty
          arbgb = <ls_msg>-msgid
          txtnr = <ls_msg>-msgno
          msgv1 = <ls_msg>-msgv1
          msgv2 = <ls_msg>-msgv2
          msgv3 = <ls_msg>-msgv3
          msgv4 = <ls_msg>-msgv4
          zeile = sy-tabix.
    ENDLOOP.

    CALL FUNCTION 'MESSAGES_STOP'
      EXCEPTIONS
        OTHERS = 0.

    CALL FUNCTION 'MESSAGES_SHOW'
      EXPORTING
        i_use_grid         = abap_true
      IMPORTING
        corrections_wanted = ev_corrections_wanted
        msg_selected       = es_msg_selected
        e_exit_command     = es_exit_command.

    rs_exit_command = es_exit_command.
  ENDMETHOD.


  METHOD notify.
    ro_log = me.

    CHECK has_messages( ) EQ abap_true.

    IF mv_msg_count EQ 1.
      READ TABLE read_msg( ) INTO DATA(ls_msg) INDEX 1.
      MESSAGE ID ls_msg-msgid TYPE rs_c_success NUMBER ls_msg-msgno
            WITH ls_msg-msgv1 ls_msg-msgv2 ls_msg-msgv3 ls_msg-msgv4
            DISPLAY LIKE ls_msg-msgty.
    ELSE.
      CASE mv_type_class3.
        WHEN rs_c_success.
          MESSAGE s001(zbc_log) DISPLAY LIKE rs_c_success. " Возникли сообщения. См. журнал.
        WHEN rs_c_warning.
          MESSAGE s002(zbc_log) DISPLAY LIKE rs_c_warning. " Возникли предупреждения. См. журнал.
        WHEN rs_c_error.
          MESSAGE s003(zbc_log) DISPLAY LIKE rs_c_error.   " Возникли ошибки. См. журнал.
      ENDCASE.
    ENDIF.
  ENDMETHOD.


  METHOD popup.
    TRY.
        rs_exit_command = display( iv_profile = 'POPUP' ).
      CATCH zcx_log_exception INTO DATA(lx_log).
        IF lx_log->exception EQ 'NO_AUTHORITY'.
          rs_exit_command = modal( ).
        ELSE.
          RAISE EXCEPTION lx_log.
        ENDIF.
    ENDTRY.
  ENDMETHOD.


  METHOD raise_exception.
    RAISE EXCEPTION TYPE zcx_log_exception
      EXPORTING
        log       = me
        function  = |{ iv_function }|
        exception = |{ iv_exception }|.
  ENDMETHOD.


  METHOD read.
    FIELD-SYMBOLS <ls_msg> TYPE bal_s_msgr.

    ro_log = me.

    CLEAR: et_msg, et_bapiret1, et_bapiret2, et_bdcmsgcoll, et_fimsg.

    CALL FUNCTION 'BAL_LOG_READ'
      EXPORTING
        i_log_handle  = mv_log_handle
        i_read_texts  = iv_read_texts
        i_langu       = iv_langu
      IMPORTING
        es_log        = es_log
        es_statistics = es_statistics
        et_msg        = et_msg
        et_exc        = et_exc
      EXCEPTIONS
        log_not_found = 1
        OTHERS        = 2.
    CASE sy-subrc.
      WHEN 1.
        raise_exception( iv_function = 'BAL_LOG_READ' iv_exception = 'LOG_NOT_FOUND' ).
      WHEN 2.
        raise_exception( iv_function = 'BAL_LOG_READ' iv_exception = 'OTHERS' ).
    ENDCASE.

    LOOP AT et_msg ASSIGNING <ls_msg>.
      <ls_msg>-msg_txt = free_text_from_msg( <ls_msg> ).
    ENDLOOP.

    IF et_bapiret1 IS REQUESTED.
      LOOP AT et_msg ASSIGNING <ls_msg>.
        APPEND INITIAL LINE TO et_bapiret1 ASSIGNING FIELD-SYMBOL(<ls_bapiret1>).
        <ls_bapiret1>-type       = <ls_msg>-msgty.
        <ls_bapiret1>-id         = <ls_msg>-msgid.
        <ls_bapiret1>-number     = <ls_msg>-msgno.
        <ls_bapiret1>-message_v1 = <ls_msg>-msgv1.
        <ls_bapiret1>-message_v2 = <ls_msg>-msgv2.
        <ls_bapiret1>-message_v3 = <ls_msg>-msgv3.
        <ls_bapiret1>-message_v4 = <ls_msg>-msgv4.
        <ls_bapiret1>-message    = <ls_msg>-msg_txt.
      ENDLOOP.
    ENDIF.

    IF et_bapiret2 IS REQUESTED.
      LOOP AT et_msg ASSIGNING <ls_msg>.
        APPEND INITIAL LINE TO et_bapiret2 ASSIGNING FIELD-SYMBOL(<ls_bapiret2>).
        <ls_bapiret2>-type       = <ls_msg>-msgty.
        <ls_bapiret2>-id         = <ls_msg>-msgid.
        <ls_bapiret2>-number     = <ls_msg>-msgno.
        <ls_bapiret2>-message_v1 = <ls_msg>-msgv1.
        <ls_bapiret2>-message_v2 = <ls_msg>-msgv2.
        <ls_bapiret2>-message_v3 = <ls_msg>-msgv3.
        <ls_bapiret2>-message_v4 = <ls_msg>-msgv4.
        <ls_bapiret2>-message    = <ls_msg>-msg_txt.
      ENDLOOP.
    ENDIF.

    IF et_bdcmsgcoll IS REQUESTED.
      LOOP AT et_msg ASSIGNING <ls_msg>.
        APPEND INITIAL LINE TO et_bdcmsgcoll ASSIGNING FIELD-SYMBOL(<ls_bdcmsgcoll>).
        <ls_bdcmsgcoll>-msgtyp = <ls_msg>-msgty.
        <ls_bdcmsgcoll>-msgid  = <ls_msg>-msgid.
        <ls_bdcmsgcoll>-msgnr  = <ls_msg>-msgno.
        <ls_bdcmsgcoll>-msgv1  = <ls_msg>-msgv1.
        <ls_bdcmsgcoll>-msgv2  = <ls_msg>-msgv2.
        <ls_bdcmsgcoll>-msgv3  = <ls_msg>-msgv3.
        <ls_bdcmsgcoll>-msgv4  = <ls_msg>-msgv4.
      ENDLOOP.
    ENDIF.

    IF et_fimsg IS REQUESTED.
      LOOP AT et_msg ASSIGNING <ls_msg>.
        APPEND INITIAL LINE TO et_fimsg ASSIGNING FIELD-SYMBOL(<ls_fimsg>).
        <ls_fimsg>-msgty = <ls_msg>-msgty.
        <ls_fimsg>-msgid  = <ls_msg>-msgid.
        <ls_fimsg>-msgno  = <ls_msg>-msgno.
        <ls_fimsg>-msgv1  = <ls_msg>-msgv1.
        <ls_fimsg>-msgv2  = <ls_msg>-msgv2.
        <ls_fimsg>-msgv3  = <ls_msg>-msgv3.
        <ls_fimsg>-msgv4  = <ls_msg>-msgv4.
        <ls_fimsg>-msort  = <ls_msg>-alsort.
        IF <ls_msg>-detlevel IS NOT INITIAL.
          <ls_fimsg>-msgpr  = <ls_msg>-detlevel.
        ELSE.
          <ls_fimsg>-msgpr  = <ls_msg>-probclass.
        ENDIF.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD read_bapiret2.
    CALL METHOD read
      EXPORTING
        iv_read_texts = iv_read_texts
        iv_langu      = iv_langu
      IMPORTING
        et_bapiret2   = rt_bapiret2.
  ENDMETHOD.


  METHOD read_msg.
    CALL METHOD read
      EXPORTING
        iv_read_texts = iv_read_texts
        iv_langu      = iv_langu
      IMPORTING
        et_msg        = rt_msg.
  ENDMETHOD.


  METHOD save.
    DATA lt_log_handle TYPE bal_t_logh.
    APPEND mv_log_handle TO lt_log_handle.

    ro_log = me.

    CALL FUNCTION 'BAL_DB_SAVE'
      EXPORTING
        i_in_update_task     = iv_in_update_task
        i_save_all           = iv_save_all
        i_t_log_handle       = lt_log_handle
        i_2th_connection     = iv_2th_connection
        i_2th_connect_commit = iv_2th_connect_commit
        i_link2job           = iv_link2job
      EXCEPTIONS
        log_not_found        = 1
        save_not_allowed     = 2
        numbering_error      = 3
        OTHERS               = 4.
    CASE sy-subrc.
      WHEN 1.
        raise_exception( iv_function = 'BAL_DB_SAVE' iv_exception = 'LOG_NOT_FOUND' ).
      WHEN 2.
        raise_exception( iv_function = 'BAL_DB_SAVE' iv_exception = 'SAVE_NOT_ALLOWED' ).
      WHEN 3.
        raise_exception( iv_function = 'BAL_DB_SAVE' iv_exception = 'NUMBERING_ERROR' ).
      WHEN 4.
        raise_exception( iv_function = 'BAL_DB_SAVE' iv_exception = 'OTHERS' ).
    ENDCASE.
  ENDMETHOD.


  METHOD search.
    DATA ls_log_filter TYPE bal_s_lfil.
    DATA lt_log_header TYPE balhdr_t.
    DATA lt_messages TYPE TABLE OF bal_s_msgr.
    FIELD-SYMBOLS <lt_range> TYPE STANDARD TABLE.

    ls_log_filter = is_filter.
    DO. " Добавляем I, EQ в RANGE по умолчанию
      ASSIGN COMPONENT sy-index OF STRUCTURE ls_log_filter TO FIELD-SYMBOL(<l_param>).
      IF sy-subrc NE 0.
        EXIT.
      ENDIF.
      DESCRIBE FIELD <l_param> TYPE DATA(lv_type).
      CHECK lv_type EQ cl_abap_typedescr=>typekind_table.
      ASSIGN <l_param> TO <lt_range>.
      LOOP AT <lt_range> ASSIGNING FIELD-SYMBOL(<ls_range>).
        ASSIGN COMPONENT 'SIGN' OF STRUCTURE <ls_range> TO FIELD-SYMBOL(<lv_sign>).
        CHECK sy-subrc EQ 0.
        ASSIGN COMPONENT 'OPTION' OF STRUCTURE <ls_range> TO FIELD-SYMBOL(<lv_option>).
        CHECK sy-subrc EQ 0.
        ASSIGN COMPONENT 'LOW' OF STRUCTURE <ls_range> TO FIELD-SYMBOL(<lv_low>).
        CHECK sy-subrc EQ 0.
        ASSIGN COMPONENT 'HIGH' OF STRUCTURE <ls_range> TO FIELD-SYMBOL(<lv_high>).
        CHECK sy-subrc EQ 0.
        IF <lv_sign> IS INITIAL AND <lv_option> IS INITIAL AND
           <lv_low> IS NOT INITIAL AND <lv_high> IS INITIAL.
          <lv_sign> = rs_c_range_sign-including.
          <lv_option> = rs_c_range_opt-equal.
        ENDIF.
      ENDLOOP.
    ENDDO.

    CALL FUNCTION 'BAL_DB_SEARCH'
      EXPORTING
        i_s_log_filter = ls_log_filter
      IMPORTING
        e_t_log_header = lt_log_header
      EXCEPTIONS
        OTHERS         = 0.
    LOOP AT lt_log_header ASSIGNING FIELD-SYMBOL(<ls_log_header>).
      DATA(lo_log) = NEW zcl_log( iv_log_handle = <ls_log_header>-log_handle ).
      DATA(lt_msg) = lo_log->read_msg( ).
      APPEND LINES OF lt_msg TO lt_messages.
    ENDLOOP.
    SORT lt_messages BY time_stmp.

    ro_log = NEW #( ).
    LOOP AT lt_messages ASSIGNING FIELD-SYMBOL(<ls_message>).
      ro_log->add_bal_msg(
        is_msg      = CORRESPONDING #( <ls_message> )
        iv_cumulate = iv_cumulate
      ).
    ENDLOOP.
  ENDMETHOD.


  METHOD show.
    ro_log = me.
    CHECK has_messages( ).

    AUTHORITY-CHECK OBJECT 'S_DEVELOP'
      ID 'ACTVT'    FIELD '03'
      ID 'DEVCLASS' DUMMY
      ID 'OBJTYPE'  FIELD 'DEBUG'
      ID 'OBJNAME'  DUMMY
      ID 'P_GROUP'  DUMMY.
    DATA(lv_admin) = xsdbool( sy-subrc EQ 0 ).
    DATA(lt_messages) = read_msg( ).
    DATA(lv_single) = xsdbool( lines( lt_messages ) EQ 1 ).
    DATA(lv_complex) = xsdbool( lt_messages[ 1 ]-params IS NOT INITIAL ).
    IF lv_single EQ abap_true.
      IF lv_admin EQ abap_true AND lv_complex EQ abap_true.
        popup( ).
      ELSE.
        notify( ).
      ENDIF.
    ELSE.
      popup( ).
    ENDIF.
  ENDMETHOD.


  METHOD get_params_from_details.
    CONSTANTS lc_block_length TYPE i VALUE 75.
    DATA(lv_class) = |{ cl_abap_classdescr=>describe_by_object_ref( io_details )->absolute_name }|.
    DATA(lv_context) = CONV string( io_details->get_key( ) ).
    DATA(lv_length) = VALUE i( ).

    rs_params-callback-userexitf = 'Z_BC_LOG_DETAILS_VIEW'.
    rs_params-callback-userexitt = 'F'.

    DO 3 TIMES.
      rs_params-t_par = VALUE #( BASE rs_params-t_par (
          parname  = |CLASS{ condense( |{ sy-index }| ) }|
          parvalue = lv_class
      ) ).
      IF strlen( lv_class ) GT lc_block_length.
        lv_class = lv_class+lc_block_length.
      ELSE.
        EXIT.
      ENDIF.
    ENDDO.
    IF lv_context IS NOT INITIAL.
      rs_params-t_par = VALUE #( BASE rs_params-t_par (
          parname  = |LENGTH|
          parvalue = strlen( lv_context )
      ) ).
    ENDIF.
    WHILE lv_context IS NOT INITIAL.
      lv_length = nmin( val1 = strlen( lv_context ) val2 = lc_block_length ).
      rs_params-t_par = VALUE #( BASE rs_params-t_par (
          parname  = condense( |{ sy-index }| )
          parvalue = lv_context(lv_length)
      ) ).
      lv_context = lv_context+lv_length.
    ENDWHILE.
  ENDMETHOD.
ENDCLASS.
