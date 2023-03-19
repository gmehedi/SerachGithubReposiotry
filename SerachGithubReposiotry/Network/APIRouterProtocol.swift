//
//  APIRouterProtocol.swift
//  SerachGithubReposiotry
//
//  Created by M M Mehedi Hasan on 19/3/23.
//

import Foundation

// MARK: - Environment for Network

protocol APIRouterProtocol {
    var httpMethod: HTTPMethod { get }
    var scheme: String { get }
    var host: String { get }
    var endPoint: Endpoint { get }
    var commonHeaders: [String : String] { get }
    var commonQueries: [URLQueryItem]? { get }
    var timeout: TimeInterval { get }
}

// MARK: - APIRouterProtocol Default Values

extension APIRouterProtocol {
    var httpMethod: HTTPMethod { HTTPMethod.get }
    var scheme: String { "https" }
    var host: String { "api.github.com" }
    var commonHeaders: [String : String] {
        ["Accept": "application/vnd.github+json"]
    }
    var timeout: TimeInterval { 30 }
}
