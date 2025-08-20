//
//  StationsListViewModelTests.swift
//  EVStationsTests
//
//  Created by ShaMarcus Walker on 8/19/25.
//

import XCTest
@testable import EVStations

final class StationsListViewModelTests: XCTestCase {

    // Helpers
    private func makeSUT(service: StationServiceProtocol) -> StationsListViewModel {
        StationsListViewModel(service: service)
    }

    // MARK: - Tests

    func test_initialState_isLoading() {
        let sut = makeSUT(service: MockStationService())
        if case .loading = sut.viewState {
            // ok
        } else {
            XCTFail("Expected .loading, got \(sut.viewState)")
        }
    }

    func test_load_success_setsLoadedStations() async {
        // Given
        let mock = MockStationService()
        let sample = Station(
            id: 1,
            name: "Test Station",
            address: "123 Main St",
            latitude: 10.0,
            longitude: 20.0,
            connectors: ["Type1"],
            accessComments: "Open 24/7"
        )
        mock.nextResult = .success([sample])

        let sut = makeSUT(service: mock)

        // When
        await sut.load(latitude: 10.0, longitude: 20.0)

        // Then
        switch sut.viewState {
        case .loaded(let stations):
            XCTAssertEqual(stations.count, 1)
            XCTAssertEqual(stations.first?.name, "Test Station")
            XCTAssertEqual(mock.lastLatitude, 10.0)
            XCTAssertEqual(mock.lastLongitude, 20.0)
        default:
            XCTFail("Expected .loaded, got \(sut.viewState)")
        }
    }

    func test_load_failure_setsErrorState() async {
        // Given
        let mock = MockStationService()
        mock.nextResult = .failure(NetworkError.apiFailed("Mock failure"))
        let sut = makeSUT(service: mock)

        // When
        await sut.load(latitude: 0, longitude: 0)

        // Then
        switch sut.viewState {
        case .error(let message):
            XCTAssertFalse(message.isEmpty)
        default:
            XCTFail("Expected .error, got \(sut.viewState)")
        }
    }

    func test_load_overwritesPreviousState() async {
        // Given
        let mock = MockStationService()
        let first = Station(id: 1, name: "A", address: "Addr A", latitude: 1, longitude: 1, connectors: [], accessComments: nil)
        let second = Station(id: 2, name: "B", address: "Addr B", latitude: 2, longitude: 2, connectors: [], accessComments: nil)

        let sut = makeSUT(service: mock)

        // 1) First load succeeds with two stations
        mock.nextResult = .success([first, second])
        await sut.load(latitude: 1, longitude: 1)
        if case .loaded(let stations) = sut.viewState {
            XCTAssertEqual(stations.count, 2)
        } else {
            XCTFail("Expected .loaded after first load")
        }

        // 2) Second load fails -> state should become .error
        mock.nextResult = .failure(NetworkError.apiFailed("Later failure"))
        await sut.load(latitude: 2, longitude: 2)
        if case .error = sut.viewState {
            // ok
        } else {
            XCTFail("Expected .error after second load")
        }
    }

    func test_load_passesThroughCoordinatesToService() async {
        // Given
        let mock = MockStationService()
        mock.nextResult = .success([])
        let sut = makeSUT(service: mock)

        // When
        await sut.load(latitude: 37.7749, longitude: -122.4194)

        // Then
        XCTAssertEqual(mock.lastLatitude, 37.7749)
        XCTAssertEqual(mock.lastLongitude, -122.4194)
    }
}
