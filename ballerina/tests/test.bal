
// Copyright (c) 2026, WSO2 LLC. (http://www.wso2.com).
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/http;
import ballerina/os;
import ballerina/test;

final boolean isLiveServer = os:getEnv("IS_LIVE_SERVER") == "true";
final string serviceUrl = isLiveServer ? "https://test.api.amadeus.com/v2/shopping" : "http://localhost:9090/v2/shopping";
final string tokenUrl = isLiveServer ? "https://test.api.amadeus.com/v1/security/oauth2/token" : "http://localhost:9444/oauth2/token";
final string clientId = isLiveServer ? os:getEnv("AMADEUS_CLIENT_ID") : "test_client_id";
final string clientSecret = isLiveServer ? os:getEnv("AMADEUS_CLIENT_SECRET") : "test_client_secret";

// The OAuth2 client fetches a token on construction, so the client is created inside each test,
// after the mock token endpoint has started.
function initClient() returns Client|error => new (
    {
        auth: {tokenUrl, clientId, clientSecret},
        httpVersion: isLiveServer ? http:HTTP_2_0 : http:HTTP_1_1
    },
    serviceUrl
);

@test:Config {groups: ["live_tests", "mock_tests"]}
function testGetFlightOffers() returns error? {
    Client amadeus = check initClient();
    FlightOffersResponse response = check amadeus->getFlightOffers(
        originLocationCode = "MAD", destinationLocationCode = "ATH", departureDate = "2026-11-01", adults = 1, max = 2);
    test:assertTrue(response.data.length() > 0);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testSearchFlightOffers() returns error? {
    GetFlightOffersQuery payload = {
        currencyCode: "EUR",
        originDestinations: [
            {
                id: "1",
                originLocationCode: "MAD",
                destinationLocationCode: "ATH",
                departureDateTimeRange: {date: "2026-11-01"}
            }
        ],
        travelers: [{id: "1", travelerType: "ADULT"}],
        sources: ["GDS"]
    };
    Client amadeus = check initClient();
    FlightOffersSearchResponse response = check amadeus->searchFlightOffers(payload);
    test:assertTrue(response.data.length() > 0);
}
