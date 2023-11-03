//
//  ItemDetailView.swift
//  LeagueOfLegendsCompanion
//
//  Created by Ruan Jansen on 2023/08/05.
//

import SwiftUI

struct ItemDetailView: View {
    @StateObject var viewModel: ItemDetailViewModel

    init(item: Item) {
        self._viewModel = StateObject(wrappedValue: ItemDetailViewModel(item: item))
    }
    
    var body: some View {
        Text("Hello summoner!")
    }
}
