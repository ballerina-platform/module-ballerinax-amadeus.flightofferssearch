# Tests

The test suite covers both operations of the connector, `getFlightOffers` and `searchFlightOffers`. Each test creates a client and asserts that the response contains at least one flight offer.

## Running Tests

By default the tests run against a local mock server (`tests/mock_service.bal`) and a mock OAuth 2.0 token endpoint (`tests/token_service.bal`), so no credentials are needed:

```bash
bal test
```

To run the same tests against the live Amadeus test environment, export your credentials and set `IS_LIVE_SERVER`:

```bash
export IS_LIVE_SERVER=true
export AMADEUS_CLIENT_ID=<api-key>
export AMADEUS_CLIENT_SECRET=<api-secret>
bal test --groups live_tests
```
