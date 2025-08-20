//
//  Station.swift
//  EVStations
//
//  Created by Shamarcus Walker on 8/19/25.
//

import Foundation

struct Station: Identifiable {
    let id: Int
    let name: String
    let address: String
    let latitude: Double
    let longitude: Double
    let connectors: [String]
    let accessComments: String?
}

extension Station {
    init(from poi: EVStation) {
        self.id = poi.id
        self.name = poi.addressInfo.title
        self.address = [poi.addressInfo.addressLine1, poi.addressInfo.town, poi.addressInfo.stateOrProvince, poi.addressInfo.postcode]
            .compactMap { $0 }
            .joined(separator: ", ")
        self.latitude = poi.addressInfo.latitude
        self.longitude = poi.addressInfo.longitude
        self.connectors = poi.connections?.compactMap { $0.connectionType?.title } ?? []
        self.accessComments = poi.accessComments
    }
}
