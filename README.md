# Ballerina Amadeus Flight Offers Search connector

[![Build](https://github.com/ballerina-platform/module-ballerinax-amadeus.flightofferssearch/actions/workflows/ci.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-amadeus.flightofferssearch/actions/workflows/ci.yml)
[![GitHub Last Commit](https://img.shields.io/github/last-commit/ballerina-platform/module-ballerinax-amadeus.flightofferssearch.svg)](https://github.com/ballerina-platform/module-ballerinax-amadeus.flightofferssearch/commits/main)
[![GitHub Issues](https://img.shields.io/github/issues/ballerina-platform/ballerina-library/module/amadeus.flightofferssearch.svg?label=Open%20Issues)](https://github.com/ballerina-platform/ballerina-library/labels/module%2Famadeus.flightofferssearch)

## Overview

[Amadeus](https://amadeus.com/) is a global travel technology company, and its [Flight Offers Search](https://developers.amadeus.com/self-service/category/flights/api-doc/flight-offers-search) API returns flight offers with prices, itineraries and fare details for a given route, date and set of travellers. The Amadeus Flight Offers Search connector lets Ballerina applications query that API, either with a simple search by origin, destination and date or with a full search request for multi-city trips and advanced criteria.

This connector supports version 2.9.1 of the Flight Offers Search API.

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

## Build from the source

### Setting up the prerequisites

1. Download and install Java SE Development Kit (JDK) version 21. You can download it from either of the following sources:

    * [Oracle JDK](https://www.oracle.com/java/technologies/downloads/)
    * [OpenJDK](https://adoptium.net/)

   > **Note:** After installation, remember to set the `JAVA_HOME` environment variable to the directory where JDK was installed.

2. Download and install [Ballerina Swan Lake](https://ballerina.io/).

3. Download and install [Docker](https://www.docker.com/get-started).

   > **Note**: Ensure that the Docker daemon is running before executing any tests.

4. Export Github Personal access token with read package permissions as follows,

    ```bash
    export packageUser=<Username>
    export packagePAT=<Personal access token>
    ```

### Build options

Execute the commands below to build from the source.

1. To build the package:

   ```bash
   ./gradlew clean build
   ```

2. To run the tests:

   ```bash
   ./gradlew clean test
   ```

3. To build the without the tests:

   ```bash
   ./gradlew clean build -x test
   ```

4. To run tests against different environments:

   ```bash
   ./gradlew clean test -Pgroups=<Comma separated groups/test cases>
   ```

5. To debug the package with a remote debugger:

   ```bash
   ./gradlew clean build -Pdebug=<port>
   ```

6. To debug with the Ballerina language:

   ```bash
   ./gradlew clean build -PbalJavaDebug=<port>
   ```

7. Publish the generated artifacts to the local Ballerina Central repository:

    ```bash
    ./gradlew clean build -PpublishToLocalCentral=true
    ```

8. Publish the generated artifacts to the Ballerina Central repository:

   ```bash
   ./gradlew clean build -PpublishToCentral=true
   ```

## Contribute to Ballerina

As an open-source project, Ballerina welcomes contributions from the community.

For more information, go to the [contribution guidelines](https://github.com/ballerina-platform/ballerina-lang/blob/master/CONTRIBUTING.md).

## Code of conduct

All the contributors are encouraged to read the [Ballerina Code of Conduct](https://ballerina.io/code-of-conduct).

## Useful links

* For more information go to the [`amadeus.flightofferssearch` package](https://central.ballerina.io/ballerinax/amadeus.flightofferssearch/latest).
* For example demonstrations of the usage, go to [Ballerina By Examples](https://ballerina.io/learn/by-example/).
* Chat live with us via our [Discord server](https://discord.gg/ballerinalang).
* Post all technical questions on Stack Overflow with the [#ballerina](https://stackoverflow.com/questions/tagged/ballerina) tag.
