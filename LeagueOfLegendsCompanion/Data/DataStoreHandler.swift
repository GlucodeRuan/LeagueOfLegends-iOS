//
//  DataStoreHandler.swift
//  LeagueOfLegendsCompanion
//
//  Created by Ruan Jansen on 2023/08/05.
//

import Foundation

@MainActor
final class DataStoreHandler: ObservableObject {
    static let shared = DataStoreHandler()
    
    private let networkHandler: NetworkHandler = NetworkHandler()
    private var tasks: [Task<Void, Never>] = []

    @Published var champions = [ChampDatum]()
    @Published var items = [ItemDatum]()

    func cancelTasks() {
        tasks.forEach({ $0.cancel() })
        tasks = []
    }
    
    func fetchChampions() {
        let task = Task {
            do {
                self.champions = try await networkHandler.fetchChampionList().map({ $0.value }).unique()
            } catch {
                
            }
        }
        tasks.append(task)
    }
    
    func fetchItems() {
        let task = Task {
            do {
                self.items = try await networkHandler.fetchItemList().map({ $0.value }).unique()
            } catch {
                
            }
        }
        tasks.append(task)
    }
}
