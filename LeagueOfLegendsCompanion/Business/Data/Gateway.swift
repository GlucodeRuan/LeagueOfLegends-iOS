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
    private var tasks: [Task<Void, Never>] = []

    func fetchVersions(completion: @escaping (VersionData?, NetworkError?, DataError?) -> Void) {
        let networkHandler: NetworkHandler = VersionNetworkHandler()
        let task = Task {
            do {
                let version: String? = nil
                let data = try await networkHandler.fetch(for: version, to: VersionData.self) { error in
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
        let networkHandler: NetworkHandler = ChampionNetworkHandler()
        let task = Task {
            do {
                let data = try await networkHandler.fetch(for: version, to: ChampionData.self) { error in
                    completion(nil, error, nil)
                }
                completion(data, nil, nil)
            } catch {
                completion(nil, nil, DataError.unreadable_Data)
            }
        }
        tasks.append(task)
    }
    
    func fetchItems(for version: String, completion: @escaping (ItemData?, NetworkError?, DataError?) -> Void) {
        let networkHandler: NetworkHandler = ItemNetworkHandler()
        let task = Task {
            do {
                let data = try await networkHandler.fetch(for: version, to: ItemData.self) { error in
                    completion(nil, error, nil)
                }
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
