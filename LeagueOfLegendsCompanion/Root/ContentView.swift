//
//  ContentView.swift
//  LeagueOfLegendsCompanion
//
//  Created by Ruan Jansen on 2023/08/04.
//

import SwiftUI

struct ContentView: View {
    @StateObject var dataStore = DataStoreHandler.shared

    var body: some View {
        TabView {
            CollectionView()
                .environmentObject(dataStore)
                .tabItem {
                    Label("Collection", systemImage: "backpack")
                }
            PracticeToolView()
                .environmentObject(dataStore)
                .tabItem {
                    Label("Practice Tool", systemImage: "scope")
                }
        }
        .tint(.primary)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
