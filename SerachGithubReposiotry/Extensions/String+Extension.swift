//
//  String+Extension.swift
//  SerachGithubReposiotry
//
//  Created by M M Mehedi Hasan on 19/3/23.
//

import Foundation

// MARK: - Extension of String

public extension String {
    static let searchRepos = "Search Repositories"
    static let noRepos = "No Repositories Found"
    static let loadingNext = "Loading next page"
    
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
    
    func decodeBase64String() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }
}

public extension String {
    static let toBrowser = "Open in Browser"
    static let language = "Language: "
    static let unknown = "Unknown"
    static let subscribers = "Subscribers: "
    static let owner = "Owner: "

    static let chevronImageName = "chevron.right"
    static let photoImageName = "photo"
}

