//
//  ContentView.swift
//  LeagueOfLegendsCompanion
//
//  Created by Ruan Jansen on 2023/08/04.
//

import SwiftUI

struct ContentView: View {
    @StateObject var dataStore = DataStoreHandler()
    var body: some View {
        TabView {
            CollectionView()
                .tabItem {
                    Label("Collection", systemImage: "backpack")
                }
        }
        .tint(.primary)
        .onAppear {
            dataStore.checkVersion()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
