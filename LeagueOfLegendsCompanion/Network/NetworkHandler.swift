//
//  NetworkHandler.swift
//  LeagueOfLegendsCompanion
//
//  Created by Ruan Jansen on 2023/08/05.
//

import Foundation

enum NetworkError: String, Error {
    case invalidURL
    case invalidResponse
    case invalidData
}

class NetworkHandler: ObservableObject {
    
    func fetchChampionList() async throws -> [Champion] {
        let endpoint = "https://ddragon.leagueoflegends.com/cdn/13.21.1/data/en_US/champion.json"
        
        guard let url = URL(string: endpoint) else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let result = try decoder.decode(ChampionData.self, from: data)
            return result.data.map(\.value)
        } catch {
            throw NetworkError.invalidData
        }
    }
    
    func fetchItemList() async throws -> [Item] {
        let endpoint = "https://ddragon.leagueoflegends.com/cdn/13.21.1/data/en_US/item.json"
        
        guard let url = URL(string: endpoint) else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let result = try decoder.decode(ItemData.self, from: data)
            return result.data.map(\.value)
        } catch {
            throw NetworkError.invalidData
        }
    }
}
