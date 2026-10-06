## Overview

[Amadeus](https://amadeus.com/) is a global travel technology company, and its [Flight Offers Search](https://developers.amadeus.com/self-service/category/flights/api-doc/flight-offers-search) API returns flight offers with prices, itineraries and fare details for a given route, date and set of travellers. The Amadeus Flight Offers Search connector lets Ballerina applications query that API, either with a simple search by origin, destination and date or with a full search request for multi-city trips and advanced criteria.

This connector supports version 2.9.1 of the Flight Offers Search API.

### Key features

- Search flight offers by origin, destination, dates and number of travellers
- Filter offers by travel class, airlines, non-stop flights, currency and maximum price
- Run advanced and multi-city searches with a full search request body
- Authenticate with the OAuth 2.0 client credentials grant, with tokens fetched and refreshed automatically

## Setup guide

To use the Amadeus Flight Offers Search connector you need an API key and an API secret for the Amadeus Flight Offers Search API.

> **Note:** Amadeus decommissioned its Self-Service APIs portal on 17 July 2026 and disabled the API keys issued through it, including those for the `https://test.api.amadeus.com` test environment that the connector uses by default. The [Amadeus for Developers](https://developers.amadeus.com/) portal now serves Amadeus Enterprise APIs only, so new credentials are available only to Amadeus Enterprise customers.

1. Obtain access to the Flight Offers Search API through an Amadeus Enterprise agreement, using the [Amadeus for Developers](https://developers.amadeus.com/) portal.

2. Get the API key and API secret issued for your application, along with the API and token URLs of your environment.

3. The connector uses the API key and API secret as the client ID and client secret of the OAuth 2.0 client credentials grant. When you create the client, pass the API URL as the `serviceUrl` and the token URL as `auth.tokenUrl`.

## Quickstart

To use the `amadeus.flightofferssearch` connector in your Ballerina application, update the `.bal` file as follows:

### Step 1: Import the module

```ballerina
import ballerinax/amadeus.flightofferssearch;
```

### Step 2: Instantiate a new connector

Create a `Config.toml` file with your credentials:

```toml
clientId = "<api-key>"
clientSecret = "<api-secret>"
```

Then create a `flightofferssearch:Client` using them:

```ballerina
configurable string clientId = ?;
configurable string clientSecret = ?;

final flightofferssearch:Client amadeus = check new ({auth: {clientId, clientSecret}});
```

### Step 3: Invoke the connector operation

Search for flight offers on a route:

```ballerina
public function main() returns error? {
    flightofferssearch:FlightOffersResponse _ = check amadeus->getFlightOffers(
        originLocationCode = "MAD", destinationLocationCode = "ATH", departureDate = "2026-12-01", adults = 1);
}
```

### Step 4: Run the Ballerina application

```bash
bal run
```

## Examples

The `Amadeus Flight Offers Search` connector provides practical examples illustrating usage in various scenarios. Explore these [examples](https://github.com/ballerina-platform/module-ballerinax-amadeus.flightofferssearch/tree/main/examples/), covering the following use cases:

1. [Cheapest flight search](https://github.com/ballerina-platform/module-ballerinax-amadeus.flightofferssearch/tree/main/examples/cheapest_flight_search) - Search for offers on a route and date, pick the lowest total price and print its itinerary.

2. [Multi-city trip quote](https://github.com/ballerina-platform/module-ballerinax-amadeus.flightofferssearch/tree/main/examples/multi_city_trip_quote) - Request quotes for a three-leg trip with a single search request and compare the offers.
