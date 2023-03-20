//
//  ServiceManager.swift
//  SerachGithubReposiotry
//
//  Created by M M Mehedi Hasan on 20/3/23.
//

import Foundation
import Combine
import Network

// MARK: - Service Manager

final class ServiceManager {
    
    private static let cache: NSCache<NSString, AnyObject> = NSCache()
    
    // MARK: - Search Repositories with query and page number
    
    func repositorySearchWith(query: String, page: Int = 1) -> AnyPublisher<RepositorySearchResponse, Error>  {
        
        let params = generateParams(with: query, page: page)
        guard let request = Request.getSearchRepositoryRequestWith(params: params)?.getUrlRequest(), let url = request.url else {
            fatalError()
        }
        
        let key = (query + String(page)) as AnyObject

        return URLSession.shared.dataTaskPublisher(for: url).tryMap { result -> RepositorySearchResponse in
            
            guard let httpResponse = result.response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("status code for api response : \((result.response as? HTTPURLResponse)?.statusCode ?? 200)")
                let statusCode = ((result.response as? HTTPURLResponse)?.statusCode ?? 200)
                throw NetworkError.errorWithStatusCode(statusCode: statusCode)
            }
      
            guard let parsedData = NetworkDecoding<RepositorySearchResponse>.json.parsing(result.data) else {
                throw NetworkError.parsingError
            }
      
            CacheManager.sharedInstance.cacheUser(cacheKey: key, cashData: parsedData as AnyObject)
            return parsedData
            
        }.receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    private func generateParams(with keyword: String, page: Int) -> [String : String] {
        var result: [String : String] = Dictionary()
        result["q"] = keyword
        result["page"] = String(page)
        return result
    }
}


