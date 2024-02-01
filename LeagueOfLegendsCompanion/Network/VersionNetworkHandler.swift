//
//  VersionNetworkHandler.swift
//  LeagueOfLegendsCompanion
//
//  Created by Ruan Jansen on 2024/02/01.
//

import Foundation

class VersionNetworkHandler: NetworkHandler {
    func fetch<T>(for version: String?, to modelType: T.Type, error: @escaping (NetworkError?) -> Void) async throws -> T where T : Decodable, T : Encodable {
        let endpoint = "https://ddragon.leagueoflegends.com/api/versions.json"

        guard let url = URL(string: endpoint) else {
            throw NetworkError.invalidURL
        }

        do {
            let result = try await DecoderFactory.decode(from: url, to: [String].self)
            return VersionData(versions: result) as! T
        } catch {
            throw NetworkError.invalidData
        }
    }
}
