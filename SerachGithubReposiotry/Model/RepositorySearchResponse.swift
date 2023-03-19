//
//  RepositorySearchResponse.swift
//  SerachGithubReposiotry
//
//  Created by M M Mehedi Hasan on 19/3/23.
//

import Foundation

// MARK: - RepoSearchResponse

struct RepositorySearchResponse: Codable, Hashable, Equatable {
    var totalCount: Int?
    var items: [RepositoryItem]?
    var message: String?
    
    private enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case items
    }
}
