//
//  Endpoint.swift
//  SerachGithubReposiotry
//
//  Created by M M Mehedi Hasan on 19/3/23.
//

import Foundation

// MARK: - Structure to represent Endpoint

struct Endpoint {
    let path: String
    let params: [String : String?]?
    
    init(path: String, params: [String : String?]? = nil) {
        self.path = path
        self.params = params
    }
}

extension Endpoint {
    func queryItems() -> [URLQueryItem]? {
        return params?.map { URLQueryItem(name: $0, value: $1) }
    }
}
