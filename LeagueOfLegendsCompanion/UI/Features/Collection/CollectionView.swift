//
//  ListView.swift
//  LeagueOfLegendsCompanion
//
//  Created by Ruan Jansen on 2023/08/05.
//

import SwiftUI

struct CollectionView: View {
    let dataStore = DataStoreHandler()
    @StateObject var viewModel: CollectionViewModel = CollectionViewModel()
    
    var body: some View {
        Text("Hello summoner!")
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionView()
    }
}
