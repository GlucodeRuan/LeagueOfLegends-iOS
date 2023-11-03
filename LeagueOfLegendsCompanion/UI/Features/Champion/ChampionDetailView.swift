//
//  ChampionDetailView.swift
//  LeagueOfLegendsCompanion
//
//  Created by Ruan Jansen on 2023/08/05.
//

import SwiftUI

struct ChampionDetailView: View {
    @StateObject var viewModel: ChampionDetailViewModel
    
    init(champion: Champion) {
        self._viewModel = StateObject(wrappedValue: ChampionDetailViewModel(champion: champion))
    }
    
    var body: some View {
        Text("Hello summoner!")
    }
}
