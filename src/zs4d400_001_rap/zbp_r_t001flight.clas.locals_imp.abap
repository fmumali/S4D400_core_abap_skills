CLASS LHC_ZR_T001FLIGHT DEFINITION INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
  PRIVATE SECTION.
    METHODS:
      GET_GLOBAL_AUTHORIZATIONS FOR GLOBAL AUTHORIZATION
        IMPORTING
           REQUEST requested_authorizations FOR Flight
        RESULT result,
      validatePrice FOR VALIDATE ON SAVE
            IMPORTING keys FOR Flight~validatePrice,
      validateCurrencyCode FOR VALIDATE ON SAVE
            IMPORTING keys FOR Flight~validateCurrencyCode.
ENDCLASS.

CLASS LHC_ZR_T001FLIGHT IMPLEMENTATION.
  METHOD GET_GLOBAL_AUTHORIZATIONS.
  ENDMETHOD.
  METHOD validatePrice.


    READ ENTITIES OF zr_t001flight IN LOCAL MODE
          ENTITY flight
          FIELDS ( price )
            WITH CORRESPONDING #(  keys )
          RESULT DATA(flights).



    LOOP AT flights ASSIGNING FIELD-SYMBOL(<flight>).

      IF <flight>-price < 0.

      APPEND VALUE #( %tky = <flight>-%tky ) TO failed-flight.

      APPEND VALUE #( %tky = <flight>-%tky
                      %msg = new_message(
                                   id       = '/LRN/S4D400'
                                   number   = '101'
                                   severity = if_abap_behv_message=>severity-error ) ) to reported-flight.
      ENDIF.

    ENDLOOP.




  ENDMETHOD.

  METHOD validateCurrencyCode.

    DATA exists TYPE abap_bool.

    READ ENTITIES OF zr_t001flight IN LOCAL MODE
          ENTITY flight
          FIELDS ( currencycode )
            WITH CORRESPONDING #(  keys )
          RESULT DATA(flights).

    LOOP AT flights ASSIGNING FIELD-SYMBOL(<flight>).

      exists = abap_false.

      SELECT SINGLE FROM I_Currency
            FIELDS @abap_true
            WHERE Currency = @<flight>-currencyCode
            INTO @exists.

      IF exists = abap_false.

      APPEND VALUE #( %tky = <flight>-%tky ) to failed-flight.
      APPEND VALUE #( %tky = <flight>-%tky
                      %msg = new_message(
                                  id       = '/LRN/S4D400'
                                  number   = '102'
                                  severity = if_abap_behv_message=>severity-error
                                  v1       = <flight>-CurrencyCode ) ) TO reported-flight.

      ENDIF.


    ENDLOOP.


  ENDMETHOD.

ENDCLASS.
