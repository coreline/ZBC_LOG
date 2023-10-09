interface ZIF_LOG_DETAILS
  public .


  class-methods CREATE
    importing
      !IV_KEY type XSTRING
    returning
      value(RO_INSTANCE) type ref to ZIF_LOG_DETAILS .
  methods GET_KEY
    returning
      value(RV_KEY) type XSTRING .
  methods SHOW .
endinterface.
