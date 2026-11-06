_Author_:  @DimuthuMadushan \
_Created_: 2026/10/06 \
_Updated_: 2026/10/06 \
_Edition_: Swan Lake

# Sanitation for OpenAPI specification

This document records the sanitation done on top of the official OpenAPI specification from Amadeus Flight Offers Search. 
The OpenAPI specification is obtained from [wso2/api-specs](https://github.com/wso2/api-specs/blob/main/openapi/amadeus/flightofferssearch/2.9.1/openapi.json).
These changes are done in order to improve the overall usability, and as workarounds for some known language limitations.

1. Add the OAuth 2.0 security scheme
- **Original**: The specification declared no `securityDefinitions` and no top-level `security`, so no authentication was generated for the client.
- **Updated**: Added an `oauth2` security definition using the `application` flow (client credentials) with token URL `https://test.api.amadeus.com/v1/security/oauth2/token`, and a top-level `security` requirement that references it.
- **Reason**: The API requires an OAuth 2.0 access token obtained with an API key and secret, as described in the API's authorization guide. Without the scheme the client has no `auth` configuration.

2. Name the inline success response schemas
- **Original**: The `GETAirOffersReply` and `returnAirOffers` responses both carried an inline schema titled `Success`, which generated the types `Success` and `Success_1`.
- **Updated**: Changed the inline schema titles to `FlightOffersResponse` (the `GET` response) and `FlightOffersSearchResponse` (the `POST` response).
- **Reason**: Descriptive type names for the two distinct response shapes instead of numbered generic names.

3. Update the API Paths
- **Original**: Paths included common prefix `/shopping` in each endpoint.
- **Updated**: Common prefix removed from endpoints as it is now in the base URL.
- **Reason**: Simplifies API paths and avoids duplication.

4. Simplify the API description
- **Original**: `info.description` held setup guidance — a pointer to the authorization guide and a note about the test environment's limited data — which was generated as the `Client` class documentation.
- **Updated**: Replaced it with a one-line summary: "Searches for and prices flight offers with the Amadeus Flight Offers Search API."
- **Reason**: The client class doc should say what the client does; setup guidance belongs in the setup docs.

5. Add missing field descriptions
- **Original**: `Tax.amount`, `Tax.code`, `Fee.amount` and the `additionalServices` array of the extended price had no `description`, and the `AllotmentDetails` and `AdditionalServicesRequest` schemas had none either, so the fields that reference them were undocumented.
- **Updated**: Added a `description` to each of those properties and to the two schemas.
- **Reason**: Removes the `undocumented field` warnings from the generated `types.bal`. A description beside a `$ref` is not carried into the generated field, so the referenced schemas carry it instead.

## OpenAPI cli command

The following command was used to generate the Ballerina client from the OpenAPI specification. The command should be executed from the repository root directory.

```bash
bal openapi -i docs/spec/aligned_ballerina_openapi.json --mode client --license docs/license.txt -o ballerina --client-methods remote
```
Note: The license year is hardcoded to 2024, change if necessary.
