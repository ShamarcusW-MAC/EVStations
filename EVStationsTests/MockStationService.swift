//
//  MockStationService.swift
//  EVStationsTests
//
//  Created by ShaMarcus Walker on 8/20/25.
//

import Foundation
@testable import EVStations

//final class MockStationService: StationServiceProtocol {
//    var shouldThrowError = false
//    var stationsToReturn: [Station] = []
//    var fetchCalled = false
//    var lastLatitude: Double?
//    var lastLongitude: Double?
//    
//    func fetchStations(latitude: Double, longitude: Double) async throws -> [Station] {
//        fetchCalled = true
//        lastLatitude = latitude
//        lastLongitude = longitude
//        
//        if shouldThrowError {
//            throw NetworkError.apiFailed("Mocked failure")
//        }
//        return stationsToReturn
//    }
//}


final class MockStationService: StationServiceProtocol {
    var nextResult: Result<[Station], Error> = .success([])
    private(set) var lastLatitude: Double?
    private(set) var lastLongitude: Double?

    func fetchStations(latitude: Double, longitude: Double) async throws -> [Station] {
        lastLatitude = latitude
        lastLongitude = longitude
        switch nextResult {
        case .success(let stations): return stations
        case .failure(let error): throw error
        }
    }
}
