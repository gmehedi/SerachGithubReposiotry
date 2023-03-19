//
//  Encode+Decode.swift
//  SerachGithubReposiotry
//
//  Created by M M Mehedi Hasan on 19/3/23.
//

import Foundation

// MARK: - Encoding types

enum NetworkEncoding {
    case json
}

// MARK: - Encode Data

extension Encodable {
    func jsonData() -> Data? {
        try? JSONEncoder().encode(self)
    }
}

// MARK: - NetworkDecoding types

enum NetworkDecoding<T: Decodable> {
    case json
}

// MARK: - Decode Data

extension NetworkDecoding {
    func parsing(_ data: Data) -> T? {
        switch self {
        case .json:
            return try? JSONDecoder().decode(T.self, from: data)
        }
    }
}
