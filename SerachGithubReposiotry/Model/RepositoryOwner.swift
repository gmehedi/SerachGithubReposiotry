//
//  RepositoryOwner.swift
//  SerachGithubReposiotry
//
//  Created by M M Mehedi Hasan on 19/3/23.
//

import Foundation

// MARK: - OwnRepository Ownerer

struct RepositoryOwner: Codable, Identifiable, Hashable, Equatable {
    var id: Int
    var userName: String?
    var avatarUrl: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case userName = "login"
        case avatarUrl = "avatar_url"
    }
}
