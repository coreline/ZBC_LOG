class ZCX_LOG_EXCEPTION definition
  public
  inheriting from ZCX_LOG
  final
  create public .

public section.

  constants:
    begin of ZCX_LOG_EXCEPTION,
      msgid type symsgid value 'ZBC_LOG',
      msgno type symsgno value '004',
      attr1 type scx_attrname value 'EXCEPTION',
      attr2 type scx_attrname value 'FUNCTION',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of ZCX_LOG_EXCEPTION .
  data FUNCTION type STRING .
  data EXCEPTION type STRING .

  methods CONSTRUCTOR
    importing
      !TEXTID like IF_T100_MESSAGE=>T100KEY optional
      !PREVIOUS like PREVIOUS optional
      !LOG type ref to ZCL_LOG optional
      !FUNCTION type STRING optional
      !EXCEPTION type STRING optional .
protected section.
private section.
ENDCLASS.



CLASS ZCX_LOG_EXCEPTION IMPLEMENTATION.


  method CONSTRUCTOR.
CALL METHOD SUPER->CONSTRUCTOR
EXPORTING
PREVIOUS = PREVIOUS
LOG = LOG
.
me->FUNCTION = FUNCTION .
me->EXCEPTION = EXCEPTION .
clear me->textid.
if textid is initial.
  IF_T100_MESSAGE~T100KEY = ZCX_LOG_EXCEPTION .
else.
  IF_T100_MESSAGE~T100KEY = TEXTID.
endif.
  endmethod.
ENDCLASS.
