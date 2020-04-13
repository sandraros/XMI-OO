"! <p class="shorttext synchronized" lang="en">XMI factory</p>
INTERFACE zif_xmi_factory
  PUBLIC .

  "! <p class="shorttext synchronized" lang="en"></p>
  "!
  "! @parameter RFCDEST | <p class="shorttext synchronized" lang="en"></p>
  "! @parameter XMI | <p class="shorttext synchronized" lang="en"></p>
  CLASS-METHODS create
    IMPORTING
      rfcdest    TYPE rfcdest OPTIONAL
    RETURNING
      VALUE(xmi) TYPE REF TO zif_xmi_bapi.

ENDINTERFACE.
