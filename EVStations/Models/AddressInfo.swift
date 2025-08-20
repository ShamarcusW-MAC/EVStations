//
//  AddressInfo.swift
//  EVStations
//
//  Created by Shamarcus Walker on 8/19/25.
//

import Foundation

struct AddressInfo: Decodable, Equatable {
    let title: String
    let addressLine1: String?
    let addressLine2: String?
    let town: String?
    let stateOrProvince: String?
    let postcode: String?
    let country: CountryRef?
    let latitude: Double
    let longitude: Double
    let distance: Double?


    enum CodingKeys: String, CodingKey {
    case title = "Title"
    case addressLine1 = "AddressLine1"
    case addressLine2 = "AddressLine2"
    case town = "Town"
    case stateOrProvince = "StateOrProvince"
    case postcode = "Postcode"
    case country = "Country"
    case latitude = "Latitude"
    case longitude = "Longitude"
    case distance = "Distance"
    }
}


struct CountryRef: Codable, Equatable { let isoCode: String?; let title: String?
enum CodingKeys: String, CodingKey { case isoCode = "ISOCode"; case title = "Title" }
}
