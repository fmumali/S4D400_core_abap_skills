CLASS zcl_fm82_predefined_abap_types DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_fm82_predefined_abap_types IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

*  Data objects with build-in types
******************************************************************************************************

    "comment/uncomment the following declarations and check the output
    DATA variable TYPE string.
*    DATA Variable type I.
*    DATA variable TYPE d.
*    DATA variable TYPE c LENGTH 10.
*    DATA variable TYPE n LENGTH 10.
*    DATA variable TYPE p LENGTH 8 DECIMALS 2.

* Output
**********************************************************************

    out->write(  'Result with Initial Value)' ).
    out->write(   variable ).
    out->write(  '---------' ).

    variable = '19891109'.

    out->write(  'Result with Value 19891109' ).
    out->write(   variable ).
    out->write(  '---------' ).

  ENDMETHOD.
ENDCLASS.
