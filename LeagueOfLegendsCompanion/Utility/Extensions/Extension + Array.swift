//
//  Extension + Array.swift
//  LeagueOfLegendsCompanion
//
//  Created by Ruan Jansen on 2023/08/06.
//

import Foundation

extension Array where Element: Hashable {
    func uniquedHash() -> [Element] {
      return Array(Set(self))
    }

    func unique() -> [Element] {
        var unique = Set<Element>()
        for value in self {
            let duplicate = unique.contains { $0 == value }

            if !duplicate {
                unique.insert(value)
            }
        }
        return Array(unique)
    }
}
