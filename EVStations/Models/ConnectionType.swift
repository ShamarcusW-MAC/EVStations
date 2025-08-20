//
//  ConnectionType.swift
//  EVStations
//
//  Created by Shamarcus Walker on 8/19/25.
//

import Foundation

struct ConnectionTypeRef: Decodable, Equatable {
    let id: Int?
    let title: String?

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case title = "Title"
    }
}

struct StatusType: Decodable, Equatable { 
    let id: Int?
    let title: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case title = "Title"
    }
}
