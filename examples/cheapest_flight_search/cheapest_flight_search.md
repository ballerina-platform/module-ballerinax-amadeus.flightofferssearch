# Cheapest flight search

This example searches for flight offers on a route and date, picks the offer with the lowest total price and prints its itinerary segment by segment.

## Prerequisites

### 1. Get Amadeus credentials

Create an application in the [Amadeus for Developers](https://developers.amadeus.com/) portal and copy its API key and API secret. They are used as the client ID and client secret.

### 2. Configuration

Create a `Config.toml` file in this example's directory with the following content:

```toml
clientId = "<api-key>"
clientSecret = "<api-secret>"
originLocationCode = "<IATA origin code, e.g. MAD>"
destinationLocationCode = "<IATA destination code, e.g. ATH>"
departureDate = "<departure date, e.g. 2026-12-01>"
currencyCode = "<ISO currency code, e.g. EUR>"
adults = 1
maxOffers = 20
```

## Run the example

Execute the following command to run the example:

```bash
bal run
```
