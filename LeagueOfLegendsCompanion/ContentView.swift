//
//  ContentView.swift
//  LeagueOfLegendsCompanion
//
//  Created by Ruan Jansen on 2023/08/04.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ListView()
    } 
}

enum ChampionImageTypes {
    case splash
    case loading
}

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
