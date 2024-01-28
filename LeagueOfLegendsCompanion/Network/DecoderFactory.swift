//
//  DecoderFactory.swift
//  LeagueOfLegendsCompanion
//
//  Created by Ruan Jansen on 2024/01/27.
//

import Foundation

class DecoderFactory {
    static func decode<T: Codable>(from url: URL, to modelType: T.Type) async throws -> T {
        let (data, response) = try await URLSession.shared.data(from: url)

        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }

        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(T.self, from: data)
        }
    }
}
