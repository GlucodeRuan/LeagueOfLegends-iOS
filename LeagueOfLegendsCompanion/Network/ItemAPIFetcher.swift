//
//  ItemNetworkHandler.swift
//  LeagueOfLegendsCompanion
//
//  Created by Ruan Jansen on 2024/02/01.
//

import Foundation

class ItemAPIFetcher: APIFetchable {
    func fetch<T>(for version: String?, to modelType: T.Type, error: @escaping (NetworkError?) -> Void) async throws -> T where T : Decodable, T : Encodable {
        guard let version else {
            throw NetworkError.invalidURL
        }

        let endpoint = "https://ddragon.leagueoflegends.com/cdn/\(version)/data/en_US/item.json"

        guard let url = URL(string: endpoint) else {
            throw NetworkError.invalidURL
        }

        do {
            let result = try await DecoderFactory.decode(from: url, to: modelType.self)
            return result
        } catch {
            throw NetworkError.invalidData
        }
    }
}
