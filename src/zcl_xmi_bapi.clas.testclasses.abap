*"* use this source file for your ABAP unit test classes

CLASS lcl_helper DEFINITION DEFERRED.
CLASS zcl_xmi_bapi DEFINITION LOCAL FRIENDS lcl_helper.

CLASS lcl_helper DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS get_xmi RETURNING VALUE(result) TYPE REF TO zif_xmi_bapi.
ENDCLASS.

CLASS lcl_helper IMPLEMENTATION.
  METHOD get_xmi.
    result = NEW zcl_xmi_bapi( ).
  ENDMETHOD.
ENDCLASS.

CLASS ltc_logon_ok DEFINITION
      FOR TESTING
      DURATION SHORT
      RISK LEVEL HARMLESS.
  PRIVATE SECTION.
    DATA: xmi TYPE REF TO zif_xmi_bapi.
    METHODS nothing FOR TESTING.
    METHODS company_only FOR TESTING.
    METHODS interface_only FOR TESTING.
    METHODS interface_and_company FOR TESTING.
    METHODS interface_only_enter_logmsg FOR TESTING.
    METHODS check_version FOR TESTING RAISING cx_static_check.
    METHODS get_versions FOR TESTING RAISING cx_static_check.
    METHODS describe_interface FOR TESTING RAISING cx_static_check.
    METHODS enter_logmsg_in_interface_off FOR TESTING RAISING cx_static_check.
    METHODS logon_invalid_interface FOR TESTING RAISING cx_static_check.
    METHODS teardown.
    METHODS setup.
ENDCLASS.

CLASS ltc_logon_ok IMPLEMENTATION.

  METHOD logon_invalid_interface.
    TRY.
        xmi->logon(
            interface  = '???'
            version    = '?'
            extcompany = ''
            extproduct = '' ).

        cl_abap_unit_assert=>fail( msg = 'logon with invalid interface should fail' ).

      CATCH zcx_xmi INTO DATA(lx_xmi).
    ENDTRY.
    cl_abap_unit_assert=>assert_equals(
        act = CORRESPONDING bapiret2( lx_xmi->return EXCEPT message system )
        exp = VALUE bapiret2(
            type       = 'E'
            id         = 'XM'
            number     = '023'
            message_v1 = 'BAPI_XMI_LOGON'
            message_v2 = '???' ) ).

  ENDMETHOD.

  METHOD interface_and_company.

    xmi->logon(
        interface  = 'XBP'
        version    = '3.0'
        extcompany = 'DUMMY' ).

    xmi->select_log( extuser = 'ZZZ' ).

    xmi->logoff( ).

  ENDMETHOD.

  METHOD company_only.

    xmi->logon( extcompany = 'DUMMY' ).

    xmi->select_log( extuser = 'ZZZ' ).

    xmi->logoff( ).

  ENDMETHOD.

  METHOD interface_only.

    xmi->logon( interface = 'XBP' version = '3.0' ).

    TRY.
        xmi->logoff( interface = 'XBP' ).
      CATCH zcx_xmi INTO DATA(lx_xmi).
    ENDTRY.
    cl_abap_unit_assert=>assert_bound( act = lx_xmi ).
    cl_abap_unit_assert=>assert_equals(
        act = CORRESPONDING bapiret2( lx_xmi->return EXCEPT message system )
        exp = VALUE bapiret2(
            type       = 'E'
            id         = 'XM'
            number     = '028'
            message_v1 = 'BAPI_XMI_LOGOFF'
            message_v2 = 'XBP' ) ).

  ENDMETHOD.

  METHOD nothing.

    xmi->logon( ).

    TRY.
        xmi->logoff( ).
      CATCH zcx_xmi INTO DATA(lx_xmi).
    ENDTRY.
    cl_abap_unit_assert=>assert_bound( act = lx_xmi ).
    cl_abap_unit_assert=>assert_equals(
        act = CORRESPONDING bapiret2( lx_xmi->return EXCEPT message system )
        exp = VALUE bapiret2(
            type       = 'E'
            id         = 'XM'
            number     = '028'
            message_v1 = 'BAPI_XMI_LOGOFF' ) ).

  ENDMETHOD.

  METHOD teardown.

    TRY.
        xmi->logon( extcompany = 'ZZZ' ).
      CATCH zcx_xmi ##NO_HANDLER.
    ENDTRY.

    TRY.
        xmi->logoff( ).
      CATCH zcx_xmi ##NO_HANDLER.
    ENDTRY.

  ENDMETHOD.

  METHOD setup.

    xmi = lcl_helper=>get_xmi( ).

  ENDMETHOD.

  METHOD interface_only_enter_logmsg.

    xmi->logon( interface = 'XBP' version = '3.0' ).

    xmi->enter_logmsg( interface = 'XBP' msgtext = 'test' ).

    " LOGOFF is only possible with EXTCOMPANY
    xmi->logon( extcompany = 'A' ).
    xmi->logoff( ).

  ENDMETHOD.

  METHOD enter_logmsg_in_interface_off.

    xmi->logon( interface = 'XBP' version = '3.0' ).

    TRY.
        xmi->enter_logmsg( interface = 'XAL' msgtext = 'test' ).
        cl_abap_unit_assert=>fail( msg = 'should not write to interface not logged on' ).
      CATCH zcx_xmi INTO DATA(lx_xmi).
    ENDTRY.

    " LOGOFF is only possible with EXTCOMPANY
    xmi->logon( extcompany = 'A' ).
    xmi->logoff( ).

  ENDMETHOD.

  METHOD check_version.

    DATA(valid) = xmi->check_version( interface = 'XBP' version = '3.0' ).

    cl_abap_unit_assert=>assert_equals(
    msg = 'XBP 3.0 should be a valid version'
    exp = abap_true
    act = valid ).

  ENDMETHOD.

  METHOD get_versions.

    DATA(versions) = xmi->get_versions( interface = 'XBP' ).

    cl_abap_unit_assert=>assert_not_initial(
    msg = 'XBP should have at least one version'
    act = versions ).

  ENDMETHOD.

  METHOD describe_interface.

    DATA(description) = xmi->describe_interface( interface = 'XBP' ).

    cl_abap_unit_assert=>assert_not_initial(
    msg = 'XBP should have a description'
    act = description ).

  ENDMETHOD.

ENDCLASS.
