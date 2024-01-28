//
//  ChampionDetailViewModel.swift
//  LeagueOfLegendsCompanion
//
//  Created by Ruan Jansen on 2023/08/05.
//

import SwiftUI

class ChampionDetailViewModel: ObservableObject {
    @Published var champion: Champion
    
    init(champion: Champion) {
        self.champion = champion
    }
    
    func fetchChampImage(for type: ChampionImageTypes) -> URL? {
        let endpoint = "https://ddragon.leagueoflegends.com/cdn/img/champion/\(type)/"
        let image = "\(champion.name)_0"
        let format = ".jpg"
        let result = endpoint + image + format
        let url = URL(string: result)
        return url
    }
}

//https://ddragon.leagueoflegends.com/cdn/img/champion/splash/Evelynn_0.jpg
