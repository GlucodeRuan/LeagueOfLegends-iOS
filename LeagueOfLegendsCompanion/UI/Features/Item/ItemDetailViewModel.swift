//
//  ItemDetailViewModel.swift
//  LeagueOfLegendsCompanion
//
//  Created by Ruan Jansen on 2023/08/05.
//

import Foundation

class ItemDetailViewModel: ObservableObject {
    @Published var item: Item

    init(item: Item) {
        self.item = item
    }
    
    func fetchItemImage() -> URL? {
        guard let latestVersion = VersionModel().read(key: "singleton")?.latestVersion else { return nil }
        let endpoint = "https://ddragon.leagueoflegends.com/cdn/\(latestVersion)/img/item/"
        let image = "\(item.image)"
        let result = endpoint + image
        let url = URL(string: result)
        return url
    }
}
