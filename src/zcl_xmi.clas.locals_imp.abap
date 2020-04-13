*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

CLASS lcl_xmi_factory DEFINITION DEFERRED.
CLASS zcl_xmi DEFINITION LOCAL FRIENDS lcl_xmi_factory.

CLASS lcl_xmi_factory DEFINITION.
  PUBLIC SECTION.
    INTERFACES zif_xmi_factory.
ENDCLASS.

CLASS lcl_xmi_factory IMPLEMENTATION.
  METHOD zif_xmi_factory~create.
    xmi = zcl_xmi=>_xmi_factory( rfcdest ).
  ENDMETHOD.
ENDCLASS.
