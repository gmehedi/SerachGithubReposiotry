//
//  Request.swift
//  SerachGithubReposiotry
//
//  Created by M M Mehedi Hasan on 19/3/23.
//

import Foundation
import Combine

struct Request<ResponseType>: APIRouterProtocol {
    
    var endPoint: Endpoint
    var commonQueries: [URLQueryItem]?
    
    init(endPoint: Endpoint, commonQueries: [URLQueryItem]? = nil) {
        self.endPoint = endPoint
        self.commonQueries = commonQueries
    }
    
    func getUrlRequest() -> URLRequest? {
        
        var component: URLComponents = URLComponents()
        component.scheme = self.scheme
        component.host = self.host
        component.path = self.endPoint.path
        component.queryItems = self.endPoint.queryItems()
        
        guard let url = component.url else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = self.commonHeaders
        request.httpMethod = self.httpMethod.rawValue
        request.timeoutInterval = self.timeout
        
        return request
    }
}
