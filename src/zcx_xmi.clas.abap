CLASS zcx_xmi DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_t100_dyn_msg .
    INTERFACES if_t100_message .

    METHODS constructor
      IMPORTING
        !return                TYPE bapiret2 OPTIONAL
        !communication_failure TYPE abap_bool DEFAULT abap_false
        !system_failure        TYPE abap_bool DEFAULT abap_false
        !textid                LIKE if_t100_message=>t100key OPTIONAL
        !previous              LIKE previous OPTIONAL .
    DATA return TYPE bapiret2 READ-ONLY.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCX_XMI IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    CALL METHOD super->constructor
      EXPORTING
        previous = previous.
    me->return = return.
    CLEAR me->textid.
    IF textid IS INITIAL.
      if_t100_message~t100key = if_t100_message=>default_textid.
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
