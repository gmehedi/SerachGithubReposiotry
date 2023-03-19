//
//  CashManager.swift
//  SerachGithubReposiotry
//
//  Created by M M Mehedi Hasan on 19/3/23.
//

import Foundation

class CacheManager {
    static let sharedInstance : CacheManager = CacheManager()
    let cache = NSCache<AnyObject, AnyObject>()
    
    public func getUserFromCache(cacheKey: AnyObject) -> RepositorySearchResponse?{
        // here the user is always nil
        if let user = cache.object(forKey: cacheKey) as? RepositorySearchResponse {
            return user
        }
        else {
            return nil
        }
    }
    
    public func cacheUser(cacheKey: AnyObject, cashData: AnyObject) {
        cache.setObject(cashData  as AnyObject, forKey: cacheKey)
    }
    
}
