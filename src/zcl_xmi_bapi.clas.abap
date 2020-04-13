CLASS zcl_xmi_bapi DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE
  GLOBAL FRIENDS zcl_xmi.

  PUBLIC SECTION.

    INTERFACES zif_xmi_bapi.

    METHODS constructor
      IMPORTING
        rfcdest TYPE rfcdest OPTIONAL.

  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS zcl_xmi_bapi IMPLEMENTATION.


  METHOD zif_xmi_bapi~check_version.

    DATA: return TYPE bapiret2.

    CALL FUNCTION 'BAPI_XMI_CHECK_VERSION'
      DESTINATION rfcdest
      EXPORTING
        interface             = interface
        version               = version
      IMPORTING
        version_valid         = version_valid
        return                = return
      EXCEPTIONS
        communication_failure = 1
        system_failure        = 2.

    CASE sy-subrc.
      WHEN 1.
        RAISE EXCEPTION TYPE zcx_xmi EXPORTING communication_failure = abap_true.
      WHEN 2.
        RAISE EXCEPTION TYPE zcx_xmi EXPORTING communication_failure = abap_true.
    ENDCASE.

    IF return IS NOT INITIAL.
      RAISE EXCEPTION TYPE zcx_xmi EXPORTING return = return.
    ENDIF.

  ENDMETHOD.


  METHOD zif_xmi_bapi~describe_interface.

    DATA: return TYPE bapiret2.

    CALL FUNCTION 'BAPI_XMI_DESCRIBE_INTERFACE'
      DESTINATION rfcdest
      EXPORTING
        interface             = interface
      IMPORTING
        descrption            = description
        return                = return
      EXCEPTIONS
        communication_failure = 1
        system_failure        = 2.

    CASE sy-subrc.
      WHEN 1.
        RAISE EXCEPTION TYPE zcx_xmi EXPORTING communication_failure = abap_true.
      WHEN 2.
        RAISE EXCEPTION TYPE zcx_xmi EXPORTING communication_failure = abap_true.
    ENDCASE.

    IF return IS NOT INITIAL.
      RAISE EXCEPTION TYPE zcx_xmi EXPORTING return = return.
    ENDIF.

  ENDMETHOD.


  METHOD zif_xmi_bapi~enter_logmsg.

    DATA: return TYPE bapiret2.

    CALL FUNCTION 'BAPI_XMI_ENTER_LOGMSG'
      DESTINATION rfcdest
      EXPORTING
        extuser               = extuser
        interface             = interface
        object                = object
        msgid                 = msgid
        msgtext               = msgtext
        msgarg1               = msgarg1
        argtype1              = argtype1
        msgarg2               = msgarg2
        argtype2              = argtype2
        msgarg3               = msgarg3
        argtype3              = argtype3
        msgarg4               = msgarg4
        argtype4              = argtype4
      IMPORTING
        return                = return
      EXCEPTIONS
        communication_failure = 1
        system_failure        = 2.

    CASE sy-subrc.
      WHEN 1.
        RAISE EXCEPTION TYPE zcx_xmi EXPORTING communication_failure = abap_true.
      WHEN 2.
        RAISE EXCEPTION TYPE zcx_xmi EXPORTING communication_failure = abap_true.
    ENDCASE.

    IF return IS NOT INITIAL.
      RAISE EXCEPTION TYPE zcx_xmi EXPORTING return = return.
    ENDIF.

  ENDMETHOD.


  METHOD zif_xmi_bapi~get_versions.

    DATA: return TYPE bapiret2.

    CALL FUNCTION 'BAPI_XMI_GET_VERSIONS'
      DESTINATION rfcdest
      EXPORTING
        interface             = interface
      IMPORTING
        return                = return
      TABLES
        versions              = versions
      EXCEPTIONS
        communication_failure = 1
        system_failure        = 2.

    CASE sy-subrc.
      WHEN 1.
        RAISE EXCEPTION TYPE zcx_xmi EXPORTING communication_failure = abap_true.
      WHEN 2.
        RAISE EXCEPTION TYPE zcx_xmi EXPORTING communication_failure = abap_true.
    ENDCASE.

    IF return IS NOT INITIAL.
      RAISE EXCEPTION TYPE zcx_xmi EXPORTING return = return.
    ENDIF.

  ENDMETHOD.


  METHOD zif_xmi_bapi~logoff.

    DATA: return TYPE bapiret2.

    CALL FUNCTION 'BAPI_XMI_LOGOFF'
      DESTINATION rfcdest
      EXPORTING
        interface             = interface
      IMPORTING
        return                = return
      EXCEPTIONS
        communication_failure = 1
        system_failure        = 2.

    CASE sy-subrc.
      WHEN 1.
        RAISE EXCEPTION TYPE zcx_xmi EXPORTING communication_failure = abap_true.
      WHEN 2.
        RAISE EXCEPTION TYPE zcx_xmi EXPORTING communication_failure = abap_true.
    ENDCASE.

    IF return IS NOT INITIAL.
      RAISE EXCEPTION TYPE zcx_xmi EXPORTING return = return.
    ENDIF.

  ENDMETHOD.


  METHOD zif_xmi_bapi~logon.

    DATA: return TYPE bapiret2.

    CALL FUNCTION 'BAPI_XMI_LOGON'
      DESTINATION rfcdest
      EXPORTING
        extcompany            = extcompany
        extproduct            = extproduct
        interface             = interface
        version               = version
      IMPORTING
        sessionid             = sessionid
        return                = return
      EXCEPTIONS
        communication_failure = 1
        system_failure        = 2.

    CASE sy-subrc.
      WHEN 1.
        RAISE EXCEPTION TYPE zcx_xmi EXPORTING communication_failure = abap_true.
      WHEN 2.
        RAISE EXCEPTION TYPE zcx_xmi EXPORTING communication_failure = abap_true.
    ENDCASE.

    IF return IS NOT INITIAL.
      RAISE EXCEPTION TYPE zcx_xmi EXPORTING return = return.
    ENDIF.

  ENDMETHOD.


  METHOD zif_xmi_bapi~select_log.

    DATA: return TYPE bapiret2.

    CALL FUNCTION 'BAPI_XMI_SELECT_LOG'
      DESTINATION rfcdest
      EXPORTING
        fromtimstmp           = fromtimstmp
        totimstmp             = totimstmp
        extuser               = extuser
        interface             = interface
        sessionid             = sessionid
        object                = object
      IMPORTING
        number                = number
        translated            = translated
        truncated             = truncated
        return                = return
      TABLES
        log                   = log
      EXCEPTIONS
        communication_failure = 1
        system_failure        = 2.

    CASE sy-subrc.
      WHEN 1.
        RAISE EXCEPTION TYPE zcx_xmi EXPORTING communication_failure = abap_true.
      WHEN 2.
        RAISE EXCEPTION TYPE zcx_xmi EXPORTING communication_failure = abap_true.
    ENDCASE.

    IF return IS NOT INITIAL.
      RAISE EXCEPTION TYPE zcx_xmi EXPORTING return = return.
    ENDIF.

  ENDMETHOD.


  METHOD zif_xmi_bapi~set_audit_level.

    DATA: return TYPE bapiret2.

    CALL FUNCTION 'BAPI_XMI_SET_AUDITLEVEL'
      DESTINATION rfcdest
      EXPORTING
        auditlevel            = auditlevel
      IMPORTING
        return                = return
      EXCEPTIONS
        communication_failure = 1
        system_failure        = 2.

    CASE sy-subrc.
      WHEN 1.
        RAISE EXCEPTION TYPE zcx_xmi EXPORTING communication_failure = abap_true.
      WHEN 2.
        RAISE EXCEPTION TYPE zcx_xmi EXPORTING communication_failure = abap_true.
    ENDCASE.
    IF return IS NOT INITIAL.
      RAISE EXCEPTION TYPE zcx_xmi EXPORTING return = return.
    ENDIF.

  ENDMETHOD.


  METHOD zif_xmi_bapi~upload_msg_formats.

    DATA: return TYPE bapiret2.

    CALL FUNCTION 'BAPI_XMI_UPLOAD_MSG_FORMATS'
      DESTINATION rfcdest
      IMPORTING
        return                = return
      TABLES
        formats               = formats
      EXCEPTIONS
        communication_failure = 1
        system_failure        = 2.

    CASE sy-subrc.
      WHEN 1.
        RAISE EXCEPTION TYPE zcx_xmi EXPORTING communication_failure = abap_true.
      WHEN 2.
        RAISE EXCEPTION TYPE zcx_xmi EXPORTING communication_failure = abap_true.
    ENDCASE.

    IF return IS NOT INITIAL.
      RAISE EXCEPTION TYPE zcx_xmi EXPORTING return = return.
    ENDIF.

  ENDMETHOD.

  METHOD constructor.

    me->zif_xmi_bapi~rfcdest = rfcdest.

  ENDMETHOD.

ENDCLASS.
