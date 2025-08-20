//
//  StationListView.swift
//  EVStations
//
//  Created by Shamarcus Walker on 8/19/25.
//

import Foundation
import MapKit
import SwiftUI

struct StationListView: View {
    @StateObject var viewModel = StationsListViewModel()
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 33.7490, longitude: -84.3880), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)) // Atlanta default
    
    var body: some View {
        NavigationStack {
            VStack {
                switch viewModel.viewState {
                case .loading:
                    ProgressView()
                case .loaded(let stations):
                    List(stations) { station in
                        NavigationLink(destination: StationDetailView(station: station)) {
                            VStack(alignment: .leading) {
                                Text(station.name).font(.headline)
                                Text(station.address).font(.subheadline).foregroundColor(.secondary)
                            }
                        }
                    }
                case .error(let error):
                    Text(error)
                }
            }
            .navigationTitle("EV Chargers")
            .navigationBarTitleDisplayMode(.inline)
        }
        .task {
            await viewModel.load(latitude: region.center.latitude, longitude: region.center.longitude)
        }
    }
}

