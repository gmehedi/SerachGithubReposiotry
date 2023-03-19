//
//  RepositoryItem.swift
//  SerachGithubReposiotry
//
//  Created by M M Mehedi Hasan on 19/3/23.
//

import Foundation

// MARK: - Repository Item

struct RepositoryItem: Codable, Identifiable, Hashable, Equatable {
    var id: Int
    var name: String?
    var owner: RepositoryOwner?
    var htmlUrl: String?
    var repoDescription: String?
    var language: String?
    var stars: Int?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case owner
        case htmlUrl = "html_url"
        case repoDescription = "description"
        case language
        case stars = "stargazers_count"
    }
}
