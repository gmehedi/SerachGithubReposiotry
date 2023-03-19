//
//  NetworkError.swift
//  SerachGithubReposiotry
//
//  Created by M M Mehedi Hasan on 19/3/23.
//

import Foundation

// MARK: - Errors in Network

enum NetworkError: Error, Equatable {
    case requestCreateError
    case genericError(errorMessage: String)
    case responseError
    case dataError
    case parsingError
    case infoResponseError
    case redirection
    case clientError
    case serverError
    case badStatusCode(_: Int)
    case unexpectedError(statusCode: Int)
    case errorWithStatusCode(statusCode: Int)
}
