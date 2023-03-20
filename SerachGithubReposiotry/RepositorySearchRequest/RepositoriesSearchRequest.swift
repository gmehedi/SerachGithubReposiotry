//
//  RepositoriesSearchRequest.swift
//  SerachGithubReposiotry
//
//  Created by M M Mehedi Hasan on 20/3/23.
//

import Foundation

// MARK: - Return byn Creating request for search repository

extension Request where ResponseType == RepositorySearchResponse {
    static func getSearchRepositoryRequestWith(params: [String : String?]?) -> Self? {
        let endPoints = Endpoint(path: "/search/repositories", params: params)
        return Request(endPoint: endPoints)
    }
}
