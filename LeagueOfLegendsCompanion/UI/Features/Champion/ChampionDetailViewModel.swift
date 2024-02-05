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

    func readableStats() -> [String: Double] {
        var readableStats = [String: Double]()

        for (key,value) in champion.stats {
            readableStats[key.addSpacesToCaps()] = value
        }

        return readableStats
    }

    func fetchChampImage(_ type: ChampionImageTypes, for skinNum: String = "0") -> URL? {
        let endpoint = "https://ddragon.leagueoflegends.com/cdn/img/champion/\(type)/"
        let image = champion.image.replacingOccurrences(of: ".png", with: "_\(skinNum).jpg")
        let result = endpoint + image
        let url = URL(string: result)
        return url
    }
}

//https://ddragon.leagueoflegends.com/cdn/img/champion/splash/Evelynn_0.jpg
