//
//  Extension + String.swift
//  LeagueOfLegendsCompanion
//
//  Created by Ruan Jansen on 2024/02/01.
//

import Foundation

extension String {
    func addSpacesToCaps() -> String {
        self.camelCaseToSnakeCase().replacingOccurrences(of: "_", with: " ")
    }

    func camelCaseToSnakeCase() -> String {
        let acronymPattern = "([A-Z]+)([A-Z][a-z]|[0-9])"
        let normalPattern = "([a-z0-9])([A-Z])"
        return self.processCamalCaseRegex(pattern: acronymPattern)?
            .processCamalCaseRegex(pattern: normalPattern)?.lowercased() ?? self.lowercased()
    }

    private func processCamalCaseRegex(pattern: String) -> String? {
        let regex = try? NSRegularExpression(pattern: pattern, options: [])
        let range = NSRange(location: 0, length: count)
        return regex?.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: "$1_$2")
    }
}
