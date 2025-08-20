//
//  StationService.swift
//  EVStations
//
//  Created by Shamarcus Walker on 8/19/25.
//

import Foundation

protocol StationServiceProtocol {
    func fetchStations(latitude: Double, longitude: Double)async throws -> [Station]
}

final class StationService: StationServiceProtocol {
    private let client: NetworkManagerActions
    private let baseURL: URL
    
    init(client: NetworkManagerActions = NetworkManager(), baseURL: URL = URL(string: Config.baseURL)!) {
        self.client = client
        self.baseURL = baseURL
    }
    
    func fetchStations(latitude: Double, longitude: Double)async throws -> [Station] {
        let url = try URLComponents.getStationServiceURL(baseURL, latitude, longitude)
        
        do {
          let (data, response) = try await client.get(url: url)
            let decoded = try JSONDecoder().decode([EVStation].self, from: data)
            return decoded.map(Station.init)
        } catch {
            throw NetworkError.apiFailed(error.localizedDescription)
        }
    }
}


extension URLComponents {
    static func getStationServiceURL(_ baseURL: URL, _ latitude: Double, _ longitude: Double) throws -> URL {
        var components = URLComponents(url: baseURL.appendingPathComponent("/v3/poi/"), resolvingAgainstBaseURL: false)!
        components.queryItems = [
            URLQueryItem(name: "output", value: "json"),
            URLQueryItem(name: "latitude", value: "\(latitude)"),
            URLQueryItem(name: "longitude", value: "\(longitude)"),
            URLQueryItem(name: "distance", value: "\(Config.defaultDistanceKM)"),
            URLQueryItem(name: "distanceunit", value: "KM"),
            URLQueryItem(name: "maxresults", value: "\(Config.defaultMaxResults)"),
            URLQueryItem(name: "key", value: Config.apiKey)
        ]
        
        guard let url = components.url else {
            throw NetworkError.invalidUrl
        }
        return url
    }
}
