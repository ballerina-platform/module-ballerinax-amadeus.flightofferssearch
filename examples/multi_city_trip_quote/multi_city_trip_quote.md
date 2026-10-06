# Multi-city trip quote

This example requests quotes for a three-leg trip (home airport, first stop, second stop, back home) with a single search request, and prints each offer's total price and number of flight segments.

## Prerequisites

### 1. Get Amadeus credentials

Create an application in the [Amadeus for Developers](https://developers.amadeus.com/) portal and copy its API key and API secret. They are used as the client ID and client secret.

### 2. Configuration

Create a `Config.toml` file in this example's directory with the following content:

```toml
clientId = "<api-key>"
clientSecret = "<api-secret>"
homeAirport = "<IATA code, e.g. MAD>"
firstStopAirport = "<IATA code, e.g. ATH>"
secondStopAirport = "<IATA code, e.g. ROM>"
firstLegDate = "<date, e.g. 2026-12-01>"
secondLegDate = "<date, e.g. 2026-12-05>"
returnLegDate = "<date, e.g. 2026-12-09>"
currencyCode = "<ISO currency code, e.g. EUR>"
maxOffers = 5
```

## Run the example

Execute the following command to run the example:

```bash
bal run
```
