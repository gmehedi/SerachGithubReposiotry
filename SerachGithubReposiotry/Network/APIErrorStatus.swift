//
//  APIErrorStatus.swift
//  SerachGithubReposiotry
//
//  Created by M M Mehedi Hasan on 19/3/23.
//

import Foundation

// MARK: - HTTP status code

struct APIErrorStatus: Equatable {
    
    static func checkStatusWith(statusCode: Int) -> NetworkError? {
        if 100 ... 199 ~= statusCode {
            return .infoResponseError
        }

        if 200 ... 299 ~= statusCode {
            return .badStatusCode(statusCode)
        }
        
        if 300 ... 399 ~= statusCode {
            return .redirection
        }
        
        if 400 ... 499 ~= statusCode {
            return .clientError
        }
        
        if 500 ... 599 ~= statusCode {
            return .serverError
        }
        
        return .unexpectedError(statusCode: statusCode)
    }
}
