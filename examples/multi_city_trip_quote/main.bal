import ballerina/io;
import ballerinax/amadeus.flightofferssearch;

configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string homeAirport = ?;
configurable string firstStopAirport = ?;
configurable string secondStopAirport = ?;
configurable string firstLegDate = ?;
configurable string secondLegDate = ?;
configurable string returnLegDate = ?;
configurable string currencyCode = "EUR";
configurable decimal maxOffers = 5;

public function main() returns error? {
    flightofferssearch:Client amadeus = check new ({auth: {clientId, clientSecret}});

    // Build a three-leg itinerary: home -> first stop -> second stop -> home.
    flightofferssearch:GetFlightOffersQuery query = {
        currencyCode,
        originDestinations: [
            {id: "1", originLocationCode: homeAirport, destinationLocationCode: firstStopAirport, departureDateTimeRange: {date: firstLegDate}},
            {id: "2", originLocationCode: firstStopAirport, destinationLocationCode: secondStopAirport, departureDateTimeRange: {date: secondLegDate}},
            {id: "3", originLocationCode: secondStopAirport, destinationLocationCode: homeAirport, departureDateTimeRange: {date: returnLegDate}}
        ],
        travelers: [{id: "1", travelerType: "ADULT"}],
        sources: ["GDS"],
        searchCriteria: {maxFlightOffers: maxOffers}
    };

    flightofferssearch:FlightOffersSearchResponse response = check amadeus->searchFlightOffers(query);

    if response.data.length() == 0 {
        return error("No offers found for the requested multi-city trip");
    }

    io:println("Quotes for ", homeAirport, " -> ", firstStopAirport, " -> ", secondStopAirport, " -> ", homeAirport);
    foreach flightofferssearch:FlightOffer offer in response.data {
        int segmentCount = 0;
        foreach flightofferssearch:Itinerary itinerary in offer.itineraries ?: [] {
            segmentCount += itinerary.segments.length();
        }
        io:println("Offer ", offer.id, ": ", offer.price?.total ?: "n/a", " ", offer.price?.currency ?: currencyCode,
            ", ", segmentCount, " segment(s), seats left: ", offer.numberOfBookableSeats ?: 0d);
    }
}
