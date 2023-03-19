//
//  Publisher+Extension.swift
//  SerachGithubReposiotry
//
//  Created by M M Mehedi Hasan on 19/3/23.
//

import Foundation
import Combine

extension Publisher {
    func flatMapLatest<P: Publisher>(_ transform: @escaping (Output) -> P) -> Publishers.SwitchToLatest<P, Publishers.Map<Self, P>> {
        map(transform).switchToLatest()
    }
}

