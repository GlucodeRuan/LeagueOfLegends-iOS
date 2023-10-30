//
//  LeagueOfLegendsCompanionApp.swift
//  LeagueOfLegendsCompanion
//
//  Created by Ruan Jansen on 2023/08/04.
//

import SwiftUI

@main
struct LeagueOfLegendsCompanionApp: App {
    let dataStore = DataStoreHandler()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .task {
                    dataStore.checkVersion()
                }
        }
    }
}
