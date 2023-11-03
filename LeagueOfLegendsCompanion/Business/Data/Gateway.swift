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

    func fetchVersions(completion: @escaping (VersionData?) -> Void) {
        let task = Task {
            do {
                let data = try await networkHandler.fetchLatestVersion()
                completion(data)
            } catch {
                // Handel error
            }
        }
        tasks.append(task)
    }
    
    func fetchChampions(for version: String, completion: @escaping (ChampionData?) -> Void) {
        let task = Task {
            do {
                let data = try await networkHandler.fetchChampionList(for: version)
                completion(data)
            } catch {
                // Handel error
            }
        }
        tasks.append(task)
    }
    
    func fetchItems(for version: String, completion: @escaping (ItemData?) -> Void) {
        let task = Task {
            do {
                let data = try await networkHandler.fetchItemList(for: version)
                completion(data)
            } catch {
                // Handel error
            }
        }
        tasks.append(task)
    }
    
    func cancelTasks() {
        tasks.forEach({ $0.cancel() })
        tasks = []
    }
}
