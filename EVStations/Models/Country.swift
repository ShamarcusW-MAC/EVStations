//
//  Country.swift
//  EVStations
//
//  Created by Shamarcus Walker on 8/19/25.
//

import Foundation

struct Country: Decodable {
    let isoCode: String?
    let title: String?
    
    enum CodingKeys: String, CodingKey {
        case isoCode = "ISOCode"
        case title = "Title"
    }
}
