//
//  DataStoreHandler.swift
//  LeagueOfLegendsCompanion
//
//  Created by Ruan Jansen on 2023/08/05.
//

import Foundation
import Combine

final class DataStoreHandler: ObservableObject {
    
    @Published var championList: [Champion] = []
    @Published var itemList: [Item] = []
        
    private let network: NetworkHandler
    
    init() {
        self.network = NetworkHandler()
        self.fetchChampions()
        self.fetchItems()
    }
    
    private func fetchItems() {
        Task {
            do {
                itemList = try await network.fetchItemList()
            } catch {
                
            }
        }
    }
    
    private func fetchChampions() {
        Task {
            do {
                championList = try await network.fetchChampionList()
            } catch {
                
            }
        }
    }
}
