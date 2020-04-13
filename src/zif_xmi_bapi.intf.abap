"! <p class="shorttext synchronized" lang="en">XMI BAPI interface</p>
INTERFACE zif_xmi_bapi
  PUBLIC .

  TYPES:
    ty_sessionlog TYPE STANDARD TABLE OF bapixmlogx WITH EMPTY KEY .
  TYPES:
    ty_messages   TYPE STANDARD TABLE OF bapixmmsg WITH EMPTY KEY .
  TYPES:
    ty_versions   TYPE STANDARD TABLE OF bapixmvers WITH EMPTY KEY .

  DATA: rfcdest TYPE rfcdest READ-ONLY.

  "! <p class="shorttext synchronized" lang="en"></p>
  "!
  "! @parameter RFCDEST | <p class="shorttext synchronized" lang="en"></p>
  "! @parameter interface | <p class="shorttext synchronized" lang="en"></p>
  "! @parameter version | <p class="shorttext synchronized" lang="en"></p>
  "! @parameter EXTCOMPANY | <p class="shorttext synchronized" lang="en"></p>
  "! @parameter EXTPRODUCT | <p class="shorttext synchronized" lang="en"></p>
  "! @parameter SESSIONID | <p class="shorttext synchronized" lang="en"></p>
  "! @raising zcx_xmi | <p class="shorttext synchronized" lang="en"></p>
  METHODS logon
    IMPORTING
      !rfcdest    TYPE rfcdest OPTIONAL
      !interface  TYPE bapixmlogr-interface OPTIONAL
      !version    TYPE bapixmlogr-version OPTIONAL
      !extcompany TYPE bapixmlogr-extcompany OPTIONAL
      !extproduct TYPE bapixmlogr-extproduct OPTIONAL
    EXPORTING
      sessionid   TYPE xmisessnid
    RAISING
      zcx_xmi .

  "! <p class="shorttext synchronized" lang="en">Log off</p>
  "! @parameter RFCDEST | <p class="shorttext synchronized" lang="en"></p>
  "! @parameter interface | <p class="shorttext synchronized" lang="en"></p>
  "! @raising zcx_xmi | <p class="shorttext synchronized" lang="en"></p>
  METHODS logoff
    IMPORTING
      !rfcdest   TYPE rfcdest OPTIONAL
      !interface TYPE bapixmlogr-interface OPTIONAL
    RAISING
      zcx_xmi .

  "! <p class="shorttext synchronized" lang="en">A general log on is required.</p>
  "!
  "! @parameter RFCDEST | <p class="shorttext synchronized" lang="en"></p>
  "! @parameter AUDITLEVEL | Number of messages: 0 (minimum, only important) to 3 (maximum)
  "!                      | <p class="shorttext synchronized" lang="en"></p>
  "! @raising zcx_xmi | <p class="shorttext synchronized" lang="en"></p>
  METHODS set_audit_level
    IMPORTING
      !rfcdest    TYPE rfcdest OPTIONAL
      !auditlevel TYPE bapixmlogr-auditlevel OPTIONAL
    RAISING
      zcx_xmi .

  "! <p class="shorttext synchronized" lang="en">Get text of interface. Log on not required.</p>
  "!
  "! @parameter RFCDEST | <p class="shorttext synchronized" lang="en"></p>
  "! @parameter interface | <p class="shorttext synchronized" lang="en"></p>
  "! @parameter description | <p class="shorttext synchronized" lang="en"></p>
  "! @raising zcx_xmi | <p class="shorttext synchronized" lang="en"></p>
  METHODS describe_interface
    IMPORTING
      !rfcdest           TYPE rfcdest OPTIONAL
      !interface         TYPE xmilogifac
    RETURNING
      VALUE(description) TYPE char128
    RAISING
      zcx_xmi .

  "! <p class="shorttext synchronized" lang="en">Log on not required</p>
  "!
  "! @parameter RFCDEST | <p class="shorttext synchronized" lang="en"></p>
  "! @parameter FROMTIMSTMP | <p class="shorttext synchronized" lang="en"></p>
  "! @parameter TOTIMSTMP | <p class="shorttext synchronized" lang="en"></p>
  "! @parameter EXTUSER | <p class="shorttext synchronized" lang="en"></p>
  "! @parameter interface | <p class="shorttext synchronized" lang="en"></p>
  "! @parameter SESSIONID | <p class="shorttext synchronized" lang="en"></p>
  "! @parameter object | <p class="shorttext synchronized" lang="en"></p>
  "! @parameter number | <p class="shorttext synchronized" lang="en"></p>
  "! @parameter translated | <p class="shorttext synchronized" lang="en"></p>
  "! @parameter truncated | <p class="shorttext synchronized" lang="en"></p>
  "! @parameter log | <p class="shorttext synchronized" lang="en"></p>
  "! @raising zcx_xmi | <p class="shorttext synchronized" lang="en"></p>
  METHODS select_log
    IMPORTING
      !rfcdest     TYPE rfcdest OPTIONAL
      !fromtimstmp TYPE tzntimestp OPTIONAL
      !totimstmp   TYPE tzntimestp OPTIONAL
      !extuser     TYPE xmilogeusr DEFAULT '*'
      !interface   TYPE xmilogifac DEFAULT '*'
      !sessionid   TYPE xmilogid DEFAULT '*'
      !object      TYPE xmilogobj DEFAULT '*'
    EXPORTING
      !number      TYPE sydbcnt
      !translated  TYPE sxmibool_d
      !truncated   TYPE sxmibool_d
      !log         TYPE ty_sessionlog
    RAISING
      zcx_xmi .

  "! <p class="shorttext synchronized" lang="en">Must be logged on</p>
  "!
  "! @parameter RFCDEST | <p class="shorttext synchronized" lang="en"></p>
  "! @parameter EXTUSER | <p class="shorttext synchronized" lang="en"></p>
  "! @parameter object | <p class="shorttext synchronized" lang="en"></p>
  "! @parameter MSGID | <p class="shorttext synchronized" lang="en">Optional ID of message defined in table TXMIMSG</p>
  "! @parameter MSGTEXT | <p class="shorttext synchronized" lang="en">Message text with placeholders &amp;1 to &amp;4 or &amp;</p>
  "! @parameter msgarg1 | <p class="shorttext synchronized" lang="en"></p>
  "! @parameter argtype1 | <p class="shorttext synchronized" lang="en">I, P, F, C, U (UTC timestamp YYYYMMDDhhmmss), D, T</p>
  "! @parameter msgarg2 | <p class="shorttext synchronized" lang="en"></p>
  "! @parameter argtype2 | <p class="shorttext synchronized" lang="en"></p>
  "! @parameter msgarg3 | <p class="shorttext synchronized" lang="en"></p>
  "! @parameter argtype3 | <p class="shorttext synchronized" lang="en"></p>
  "! @parameter msgarg4 | <p class="shorttext synchronized" lang="en"></p>
  "! @parameter argtype4 | <p class="shorttext synchronized" lang="en"></p>
  "! @raising zcx_xmi | <p class="shorttext synchronized" lang="en"></p>
  METHODS enter_logmsg
    IMPORTING
      !rfcdest   TYPE rfcdest OPTIONAL
      !extuser   TYPE xmilogeusr OPTIONAL
      !interface TYPE xmilogifac OPTIONAL
      !object    TYPE xmilogobj OPTIONAL
      !msgid     TYPE xmilogmid OPTIONAL
      !msgtext   TYPE xmimsgtxt
      !msgarg1   TYPE xmiargtxt OPTIONAL
      !argtype1  TYPE xmiargtyp DEFAULT 'C'
      !msgarg2   TYPE xmiargtxt OPTIONAL
      !argtype2  TYPE xmiargtyp DEFAULT 'C'
      !msgarg3   TYPE xmiargtxt OPTIONAL
      !argtype3  TYPE xmiargtyp DEFAULT 'C'
      !msgarg4   TYPE xmiargtxt OPTIONAL
      !argtype4  TYPE xmiargtyp DEFAULT 'C'
    RAISING
      zcx_xmi .

  "! <p class="shorttext synchronized" lang="en">Load table TXMIMSG. Must be logged on</p>
  "!
  "! @parameter RFCDEST | <p class="shorttext synchronized" lang="en"></p>
  "! @parameter formats | <p class="shorttext synchronized" lang="en"></p>
  "! @raising zcx_xmi | <p class="shorttext synchronized" lang="en"></p>
  METHODS upload_msg_formats
    IMPORTING
      !rfcdest       TYPE rfcdest OPTIONAL
    RETURNING
      VALUE(formats) TYPE ty_messages
    RAISING
      zcx_xmi .

  "! <p class="shorttext synchronized" lang="en"></p>
  "!
  "! @parameter RFCDEST | <p class="shorttext synchronized" lang="en"></p>
  "! @parameter interface | <p class="shorttext synchronized" lang="en"></p>
  "! @parameter version | <p class="shorttext synchronized" lang="en"></p>
  "! @parameter version_valid | <p class="shorttext synchronized" lang="en"></p>
  "! @raising zcx_xmi | <p class="shorttext synchronized" lang="en"></p>
  METHODS check_version
    IMPORTING
      !rfcdest             TYPE rfcdest OPTIONAL
      !interface           TYPE xmilogifac
      !version             TYPE xmiversion
    RETURNING
      VALUE(version_valid) TYPE sxmibool_d
    RAISING
      zcx_xmi .

  "! <p class="shorttext synchronized" lang="en">Log on not required</p>
  "!
  "! @parameter RFCDEST | <p class="shorttext synchronized" lang="en"></p>
  "! @parameter interface | <p class="shorttext synchronized" lang="en"></p>
  "! @parameter versions | <p class="shorttext synchronized" lang="en"></p>
  "! @raising zcx_xmi | <p class="shorttext synchronized" lang="en"></p>
  METHODS get_versions
    IMPORTING
      !rfcdest        TYPE rfcdest OPTIONAL
      !interface      TYPE xmilogifac DEFAULT '*'
    RETURNING
      VALUE(versions) TYPE ty_versions
    RAISING
      zcx_xmi .

ENDINTERFACE.
