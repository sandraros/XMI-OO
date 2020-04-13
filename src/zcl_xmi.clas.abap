********************************************************************************
*  MIT License
*
*  Copyright (c) 2018 sandraros
*
*  Permission is hereby granted, free of charge, to any person obtaining a copy
*  of this software and associated documentation files (the "Software"), to deal
*  in the Software without restriction, including without limitation the rights
*  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
*  copies of the Software, and to permit persons to whom the Software is
*  furnished to do so, subject to the following conditions:
*
*  The above copyright notice and this permission notice shall be included in all
*  copies or substantial portions of the Software.
*
*  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
*  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
*  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
*  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
*  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
*  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
*  SOFTWARE.
********************************************************************************
"! <p class="shorttext synchronized" lang="en">XMI</p>
CLASS zcl_xmi DEFINITION
  PUBLIC
  CREATE PROTECTED .

  PUBLIC SECTION.

    CLASS-METHODS class_constructor .

    "! <p class="shorttext synchronized" lang="en"></p>
    "!
    "! @parameter RFCDEST | <p class="shorttext synchronized" lang="en"></p>
    "! @parameter interface | <p class="shorttext synchronized" lang="en"></p>
    "! @parameter version | <p class="shorttext synchronized" lang="en"></p>
    "! @parameter EXTCOMPANY | <p class="shorttext synchronized" lang="en"></p>
    "! @parameter EXTPRODUCT | <p class="shorttext synchronized" lang="en"></p>
    "! @parameter XMI | <p class="shorttext synchronized" lang="en"></p>
    "! @raising zcx_xmi | <p class="shorttext synchronized" lang="en"></p>
    CLASS-METHODS logon
      IMPORTING
        !rfcdest    TYPE rfcdest OPTIONAL
        !interface  TYPE bapixmlogr-interface OPTIONAL
        !version    TYPE bapixmlogr-version OPTIONAL
        !extcompany TYPE bapixmlogr-extcompany OPTIONAL
        !extproduct TYPE bapixmlogr-extproduct OPTIONAL
      RETURNING
        VALUE(xmi)  TYPE REF TO zif_xmi_bapi
      RAISING
        zcx_xmi .

  PROTECTED SECTION.
  PRIVATE SECTION.

    CLASS-METHODS _xmi_factory
      IMPORTING
        rfcdest    TYPE rfcdest OPTIONAL
      RETURNING
        VALUE(xmi) TYPE REF TO zif_xmi_bapi.

    CLASS-DATA xmi_factory TYPE REF TO zif_xmi_factory.

ENDCLASS.



CLASS ZCL_XMI IMPLEMENTATION.


  METHOD class_constructor.

    xmi_factory = NEW lcl_xmi_factory( ).

  ENDMETHOD.


  METHOD logon.

    xmi = xmi_factory->create( ).

    DATA(version_valid) = xmi->check_version(
        rfcdest   = rfcdest
        interface = interface
        version   = version ).

    IF version_valid = abap_false.
      MESSAGE e024(xmi) INTO DATA(message).
      RAISE EXCEPTION TYPE zcx_xmi
        EXPORTING
          return = VALUE bapiret2(
                type       = sy-msgty
                id         = sy-msgid
                number     = sy-msgno
                message    = message
                message_v1 = 'BAPI_XMI_CHECK_VERSION' ##NO_TEXT
                message_v2 = interface
                message_v3 = version ).
    ENDIF.

    xmi->logon(
        rfcdest    = rfcdest
        interface  = interface
        version    = version
        extcompany = extcompany
        extproduct = extproduct ).

  ENDMETHOD.


  METHOD _xmi_factory.

    xmi = NEW zcl_xmi_bapi( rfcdest ).

  ENDMETHOD.
ENDCLASS.
