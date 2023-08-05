//
//  ListViewModel.swift
//  LeagueOfLegendsCompanion
//
//  Created by Ruan Jansen on 2023/08/05.
//

import Foundation

class ListViewModel: ObservableObject {
    
    let networkHandler: NetworkHandler = NetworkHandler()
    
    @Published var list = [Datum]()
    @Published var searchText: String = ""
    
    func searchedList() -> [Datum] {
        let sortedChampions = list.sorted(by: { $0.name < $1.name })
        if searchText.isEmpty {
            return sortedChampions
        } else {
            return sortedChampions.filter({ $0.name.lowercased().contains(searchText.lowercased()) })
        }
    }
    
    func fetchChampions() async {
        do {
            list = try await networkHandler.fetchChampionList().map({ $0.value })
        } catch {
            
        }
    }
}
