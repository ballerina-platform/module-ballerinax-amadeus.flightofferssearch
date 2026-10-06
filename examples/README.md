# Examples

The `ballerinax/amadeus.flightofferssearch` connector provides practical examples illustrating usage in various scenarios.

1. **[Cheapest flight search](https://github.com/ballerina-platform/module-ballerinax-amadeus.flightofferssearch/tree/main/examples/cheapest_flight_search)** - Search for offers on a route and date, pick the lowest total price and print its itinerary.

2. **[Multi-city trip quote](https://github.com/ballerina-platform/module-ballerinax-amadeus.flightofferssearch/tree/main/examples/multi_city_trip_quote)** - Request quotes for a three-leg trip with a single search request and compare the offers.

## Prerequisites

1. Get an API key and API secret for the Amadeus Flight Offers Search API as described in the [Setup guide](https://github.com/ballerina-platform/module-ballerinax-amadeus.flightofferssearch/blob/main/ballerina/README.md#setup-guide).

2. For each example, create a `Config.toml` file with the related configuration. Here's an example of how your Config.toml file should look:

```toml
clientId = "<api-key>"
clientSecret = "<api-secret>"
```

Each example lists the additional values it needs in its own README.

## Running an example

Execute the following commands to build an example from the source:

* To build an example:

    ```bash
    bal build
    ```

* To run an example:

    ```bash
    bal run
    ```

## Building the examples with the local module

**Warning**: Due to the absence of support for reading local repositories for single Ballerina files, the Bala of the module is manually written to the central repository as a workaround. Consequently, the bash script may modify your local Ballerina repositories.

Execute the following commands to build all the examples against the changes you have made to the module locally:

* To build all the examples:

    ```bash
    ./build.sh build
    ```

* To run all the examples:

    ```bash
    ./build.sh run
    ```
