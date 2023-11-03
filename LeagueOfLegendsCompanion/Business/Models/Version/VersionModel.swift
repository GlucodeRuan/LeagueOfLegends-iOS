//
//  VersionModel.swift
//  LeagueOfLegendsCompanion
//
//  Created by Ruan Jansen on 2023/10/30.
//

import Foundation
import RealmSwift
import Realm

final class VersionModel: Object, ObjectKeyIdentifiable, RealmAdaptable {
    @Persisted(primaryKey: true) var id = "singleton"
    @Persisted var versions: List<String> = List()
    @Persisted var latestVersion: String = ""

    convenience init(_ versions: [String]) {
        self.init()

        self.versions.append(objectsIn: versions)
        self.latestVersion = latestVersion(for: versions)
    }
    
    private func latestVersion(for versions: [String]) -> String {
        let usableVersions = versions.filter({ !$0.lowercased().contains("lolpatch_")})
        let latestVersion = usableVersions.first!
        return latestVersion
    }
    
}
