//
//  Connection.swift
//  EVStations
//
//  Created by Shamarcus Walker on 8/19/25.
//

import Foundation

struct Connection: Decodable, Equatable {
    let id: Int?
    let connectionType: ConnectionTypeRef?
    let powerKW: Double?
    let quantity: Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case connectionType = "ConnectionType"
        case powerKW = "PowerKW"
        case quantity = "Quantity"
    }
}
