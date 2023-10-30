//
//  VersionModel.swift
//  LeagueOfLegendsCompanion
//
//  Created by Ruan Jansen on 2023/10/30.
//

import Foundation
import RealmSwift

final class VersionModel: Object, ObjectKeyIdentifiable {
    
    @Persisted(primaryKey: true) var id = UUID()
    @Persisted var versions: List<String>
    @Persisted var latestVersion: String

    convenience init(_ versions: [String]) {
        self.init()

        self.versions = versions
        self.latestVersion = ""
    }
    
}
