//
//  NetworkHandler.swift
//  LeagueOfLegendsCompanion
//
//  Created by Ruan Jansen on 2023/08/05.
//

import Foundation

class NetworkHandler: ObservableObject {
    
    func fetchLatestVersion() async throws -> VersionData? {
        let endpoint = "https://ddragon.leagueoflegends.com/api/versions.json"
        return nil
    }
    
    func fetchChampionList(for version: String) async throws -> ChampionData? {
        let endpoint = "https://ddragon.leagueoflegends.com/cdn/\(version)/data/en_US/champion.json"
        return nil
    }
    
    func fetchItemList(for version: String) async throws -> ItemData? {
        let endpoint = "https://ddragon.leagueoflegends.com/cdn/\(version)/data/en_US/item.json"
        return nil
    }
}
