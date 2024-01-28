//
//  Gateway.swift
//  LeagueOfLegendsCompanion
//
//  Created by Ruan Jansen on 2023/10/30.
//

import Foundation

enum DataError: String {
    case unreadable_Data
}

final class Gateway {
    private let networkHandler: NetworkHandler = NetworkHandler()
    private var tasks: [Task<Void, Never>] = []

    func fetchVersions(completion: @escaping (VersionData?, NetworkError?, DataError?) -> Void) {
        let task = Task {
            do {
                let data = try await networkHandler.fetchLatestVersion() { error in
                    completion(nil, error, nil)
                }
                completion(data, nil, nil)
            } catch {
                completion(nil, nil, DataError.unreadable_Data)
            }
        }
        tasks.append(task)
    }
    
    func fetchChampions(for version: String, completion: @escaping (ChampionData?, NetworkError?, DataError?) -> Void) {
        let task = Task {
            do {
                let data = try await networkHandler.fetchChampionList(for: version) { error in
                    completion(nil, error, nil)
                }

//                let endpoint = "https://ddragon.leagueoflegends.com/cdn/\(version)/data/en_US/champion.json"
//                guard let safeURL = URL(string: endpoint) else { return }
//                let data = try await DecoderFactory.decode(from: safeURL, to: ChampionData.self) { error in
//                    completion(nil, error, nil)
//                }

                completion(data, nil, nil)
            } catch {
                completion(nil, nil, DataError.unreadable_Data)
            }
        }
        tasks.append(task)
    }
    
    func fetchItems(for version: String, completion: @escaping (ItemData?, NetworkError?, DataError?) -> Void) {
        let task = Task {
            do {
                let data = try await networkHandler.fetchItemList(for: version) { error in
                    completion(nil, error, nil)
                }

//                let endpoint = "https://ddragon.leagueoflegends.com/cdn/\(version)/data/en_US/item.json"
//                guard let safeURL = URL(string: endpoint) else { return }
//                let data = try await DecoderFactory.decode(from: safeURL, to: ItemData.self) { error in
//                    completion(nil, error, nil)
//                }

                completion(data, nil, nil)
            } catch {
                completion(nil, nil, DataError.unreadable_Data)
            }
        }
        tasks.append(task)
    }
    
    func cancelTasks() {
        tasks.forEach({ $0.cancel() })
        tasks = []
    }
}
