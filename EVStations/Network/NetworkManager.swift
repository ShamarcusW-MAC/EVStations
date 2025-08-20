//
//  NetworkManager.swift
//  EVStations
//
//  Created by Shamarcus Walker on 8/19/25.
//

import Foundation

enum NetworkError: Error {
    case invalidUrl
    case apiFailed(String)
}
protocol NetworkManagerActions {
    func get(url: URL) async throws -> (Data, URLResponse)
}

final class NetworkManager: NetworkManagerActions {
    func get(url: URL) async throws -> (Data, URLResponse) {
        var request = URLRequest(url: url)
        request.setValue(Config.apiKey, forHTTPHeaderField: "X-API-Key")
        return try await URLSession.shared.data(for: request)
    }
}
