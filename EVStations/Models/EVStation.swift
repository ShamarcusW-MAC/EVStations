//
//  POI.swift
//  EVStations
//
//  Created by Shamarcus Walker on 8/19/25.
//

import Foundation

struct EVStation: Decodable, Equatable, Identifiable {
    let id: Int
    let addressInfo: AddressInfo
    let connections: [Connection]?
    let numberOfPoints: Int?
    let usageCost: String?
    let statusType: StatusType?
    let accessComments: String?
    let generalComments: String?


    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case addressInfo = "AddressInfo"
        case connections = "Connections"
        case numberOfPoints = "NumberOfPoints"
        case usageCost = "UsageCost"
        case statusType = "StatusType"
        case accessComments = "AccessComments"
        case generalComments = "GeneralComments"
    }
}
