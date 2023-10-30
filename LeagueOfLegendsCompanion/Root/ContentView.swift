//
//  ContentView.swift
//  LeagueOfLegendsCompanion
//
//  Created by Ruan Jansen on 2023/08/04.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            CollectionView()
                .tabItem {
                    Label("Collection", systemImage: "backpack")
                }
            PracticeToolView()
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
