*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
CLASS lcl_connection DEFINITION.

  PUBLIC SECTION.

    CLASS-DATA conn_counter TYPE i READ-ONLY.
    CLASS-METHODS class_constructor.

    METHODS constructor
      IMPORTING
        i_connection_id TYPE /dmo/connection_id
        i_carrier_id    TYPE /dmo/carrier_id
      RAISING
        cx_abap_invalid_value .

    METHODS get_output
      RETURNING
        VALUE(r_output) TYPE string_table.

  PROTECTED SECTION.

  PRIVATE SECTION.

    TYPES:
      BEGIN OF st_details,
        departureairport   TYPE /dmo/airport_from_id,
        destinationairport TYPE   /dmo/airport_to_id,
        airlinename        TYPE   /dmo/carrier_name,
      END OF st_details.

    TYPES:
      BEGIN OF st_airport,
        AirportId TYPE /dmo/airport_id,
        Name     TYPE /dmo/airport_name,
      END OF st_airport.

    TYPES tt_airports TYPE SORTED TABLE OF st_airport
                         WITH NON-UNIQUE DEFAULT KEY.


    CLASS-DATA airports TYPE tt_airports.


    DATA carrier_id    TYPE /dmo/carrier_id.
    DATA connection_id TYPE /dmo/connection_id.

    DATA details TYPE st_details.




  ENDCLASS.

CLASS lcl_connection IMPLEMENTATION.

  METHOD class_constructor.

    SELECT FROM /DMO/I_Airport
        FIELDS AirportID, Name
        INTO TABLE @airports.

  ENDMETHOD.

  METHOD constructor.

    " ensure non-initial input
    IF i_carrier_id IS INITIAL OR i_connection_id IS INITIAL.
      RAISE EXCEPTION TYPE cx_abap_invalid_value.
    ENDIF.

    " check existence and read additional data
    SELECT SINGLE
      FROM /dmo/i_connection
    FIELDS departureairport, destinationairport, \_airline-name AS airlinename
     WHERE airlineid    = @i_carrier_id
       AND connectionid = @i_connection_id
      INTO CORRESPONDING FIELDS OF @details.

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE cx_abap_invalid_value.
    ENDIF.

    me->connection_id = i_connection_id.
    me->carrier_id    = i_carrier_id.

    conn_counter = conn_counter + 1.

  ENDMETHOD.

  METHOD get_output.


*    DATA(departure)   = airports[ airportID = details-departureairport ].
*    DATA(destination) = airports[ airportid = details-destinationairport ].

    APPEND |--------------------------------|                    TO r_output.
    APPEND |Carrier:     { carrier_id } { details-airlinename }| TO r_output.
    APPEND |Connection:  { connection_id   }|                    TO r_output.
*    APPEND |Departure:   { details-departureairport     } { departure-name   }|     TO r_output.
*    APPEND |Destination: { details-destinationairport   } { destination-name }|     TO r_output.
    APPEND |Departure:   { details-departureairport     } { airports[ airportID = details-departureairport ]-name  }|     TO r_output.
    APPEND |Destination: { details-destinationairport   } { airports[ airportid = details-destinationairport ]-name }|    TO r_output.


  ENDMETHOD.

ENDCLASS.
