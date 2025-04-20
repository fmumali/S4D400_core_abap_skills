@Metadata.allowExtensions: true
@EndUserText.label: '###GENERATED Core Data Service Entity'
@AccessControl.authorizationCheck: #CHECK
define root view entity ZC_T001FLIGHT
  provider contract TRANSACTIONAL_QUERY
  as projection on ZR_T001FLIGHT
{
  key CarrierId,
  key ConnectionId,
  key FlightDate,
  Price,
  @Semantics.currencyCode: true
  CurrencyCode,
  PlaneTypeId,
  LocalCreatedBy,
  LocalCreatedAt,
  LocalLastChangedBy,
  LocalLastChangedAt,
  LastChangedAt
  
}
