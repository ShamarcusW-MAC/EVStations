//
//  StationDetailView.swift
//  EVStations
//
//  Created by Shamarcus Walker on 8/19/25.
//

import SwiftUI
import MapKit

struct StationDetailView: View {
    let station: Station

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                map
                    .frame(height: 220)
                    .cornerRadius(12)
                group("Address") {
                    Text(station.address)
                }
                group("Connector Type") {
                    Text(station.connectors[0])
                }
                if let comment = nonEmpty(station.accessComments) {
                    group("Access Comments") {
                        Text(comment)
                    }
                } else {
                    Text("No comments")
                }
            }
            .padding()
            
        }
        .navigationTitle(station.name)
        .navigationBarTitleDisplayMode(.inline)
        
    }


    private func group(_ title: String, @ViewBuilder content: () -> some View) -> some View {
        
        VStack(alignment: .leading, spacing: 8) {
            
            Text(title).font(.headline)
            content()

        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var map: some View {
        let coord = CLLocationCoordinate2D(latitude: station.latitude, longitude: station.longitude)
        return Map(coordinateRegion: .constant(MKCoordinateRegion(center: coord, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))), annotationItems: [station]) { item in
            MapMarker(coordinate: CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longitude))
        }
        
    }

    private func fullAddress(_ a: AddressInfo) -> String {
    [a.addressLine1, a.addressLine2, a.town, a.stateOrProvince, a.postcode, a.country?.title].compactMap { $0 }.joined(separator: ", ")
    }
    private func nonEmpty(_ s: String?) -> String? { guard let s = s?.trimmingCharacters(in: .whitespacesAndNewlines), !s.isEmpty else { return nil }; return s }
}

//#Preview {
//    StationDetailView()
//}
