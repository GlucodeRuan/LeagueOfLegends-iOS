//
//  PracticeToolViewModel.swift
//  LeagueOfLegendsCompanion
//
//  Created by Ruan Jansen on 2023/08/06.
//

import Foundation

enum PracticeToolPlayerPicker: String, CaseIterable {
    case user
    case enemy
}

class PracticeToolViewModel: ObservableObject {
    @Published var userInverntory: [ItemDatum] = [] 
    @Published var enemyInverntory: [ItemDatum] = []
    
    @Published var playerPicker: PracticeToolPlayerPicker = .user
    
    func fetchItemImage(for item: ItemDatum) -> URL? {
        let endpoint = "https://ddragon.leagueoflegends.com/cdn/13.15.1/img/item/"
        let image = "\(item.image.full)"
        let result = endpoint + image
        let url = URL(string: result)
        return url
    }
}
