import ballerina/io;
import ballerinax/amadeus.flightofferssearch;

configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string originLocationCode = ?;
configurable string destinationLocationCode = ?;
configurable string departureDate = ?;
configurable string currencyCode = "EUR";
configurable int adults = 1;
configurable int maxOffers = 20;

public function main() returns error? {
    flightofferssearch:Client amadeus = check new ({auth: {clientId, clientSecret}});

    // Search for offers on the requested route and date.
    flightofferssearch:FlightOffersResponse response = check amadeus->getFlightOffers(
        originLocationCode = originLocationCode,
        destinationLocationCode = destinationLocationCode,
        departureDate = departureDate,
        adults = adults,
        currencyCode = currencyCode,
        max = maxOffers
    );

    if response.data.length() == 0 {
        return error("No flight offers found for " + originLocationCode + " to " + destinationLocationCode + " on " + departureDate);
    }

    // Pick the offer with the lowest total price.
    flightofferssearch:FlightOffer cheapest = response.data[0];
    decimal cheapestTotal = check decimal:fromString(cheapest.price?.total ?: "0");
    foreach flightofferssearch:FlightOffer offer in response.data {
        decimal total = check decimal:fromString(offer.price?.total ?: "0");
        if total < cheapestTotal {
            cheapest = offer;
            cheapestTotal = total;
        }
    }

    io:println("Offers found: ", response.data.length());
    io:println("Cheapest offer ", cheapest.id, ": ", cheapestTotal, " ", cheapest.price?.currency ?: currencyCode);
    foreach flightofferssearch:Itinerary itinerary in cheapest.itineraries ?: [] {
        io:println("Itinerary duration: ", itinerary.duration ?: "unknown");
        foreach flightofferssearch:Segment segment in itinerary.segments {
            io:println("  ", segment.carrierCode ?: "", segment.number ?: "", " ",
                segment.departure?.iataCode ?: "", " (", segment.departure?.at ?: "", ") -> ",
                segment.arrival?.iataCode ?: "", " (", segment.arrival?.at ?: "", ")");
        }
    }
}
