//
//  ExecutionState.swift
//  SerachGithubReposiotry
//
//  Created by M M Mehedi Hasan on 19/3/23.
//

import Foundation

enum ExecutionState {
    case display(repositories: [RepositoryItem], hasNextPage: Bool)
    case empty(message: String)
    case loading
    case error(message: String)
}
