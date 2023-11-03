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
        CollectionView()
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
