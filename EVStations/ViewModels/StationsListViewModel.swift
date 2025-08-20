//
//  StationsListViewModel.swift
//  EVStations
//
//  Created by Shamarcus Walker on 8/19/25.
//

import Foundation

enum ViewState {
    case loading
    case loaded([Station])
    case error(String)
}
final class StationsListViewModel: ObservableObject {
    @Published var viewState: ViewState = .loading
    private let service: StationServiceProtocol
    
    init(service: StationServiceProtocol = StationService()) {
        self.service = service
    }
    
    @MainActor
    func load(latitude: Double, longitude: Double) async {
        do {
            let stations = try await service.fetchStations(latitude: latitude, longitude: longitude)
            viewState = .loaded(stations)
        } catch {
            viewState = .error( error.localizedDescription)
        }
    }
}
