//
//  Gateway.swift
//  LeagueOfLegendsCompanion
//
//  Created by Ruan Jansen on 2023/10/30.
//

import Foundation

final class Gateway {
    private let networkHandler: NetworkHandler = NetworkHandler()
    private var tasks: [Task<Void, Never>] = []

    func fetchVersions(completion: @escaping (VersionData?, Error?) -> Void) {
        let task = Task {
            do {
                let data = try await networkHandler.fetchLatestVersion()
                completion(data, nil)
            } catch {
                completion(nil, error)
            }
        }
        tasks.append(task)
    }
    
    func fetchChampions(for version: String, completion: @escaping (ChampionData?, Error?) -> Void) {
        let task = Task {
            do {
                let data = try await networkHandler.fetchChampionList(for: version)
                completion(data, nil)
            } catch {
                completion(nil, error)
            }
        }
        tasks.append(task)
    }
    
    func fetchItems(for version: String, completion: @escaping (ItemData?, Error?) -> Void) {
        let task = Task {
            do {
                let data = try await networkHandler.fetchItemList(for: version)
                completion(data, nil)
            } catch {
                completion(nil, error)
            }
        }
        tasks.append(task)
    }
    
    func cancelTasks() {
        tasks.forEach({ $0.cancel() })
        tasks = []
    }
}
