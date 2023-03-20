//
//  RepositorySearchViewModel.swift
//  SerachGithubReposiotry
//
//  Created by M M Mehedi Hasan on 20/3/23.
//

import Foundation
import Combine
import Network

// MARK: - Repository Serarch ViewModel

class RepositorySerarchViewModel: ObservableObject {

    private let serviceManager: ServiceManager
    
    @Published var newQuery = ""
    @Published var prevQuery = "" // Continue next page loading with prevQuery when cancel searching option
    @Published var page = RepositorySerarchViewModel.initPage
    @Published var searchingState: ExecutionState = .empty(message: .searchRepos)
    private static let initPage = 1
    
    @Published var networkStatus: NWPath.Status = .satisfied
    private let monitorQueue = DispatchQueue(label: "monitor")
    private let monitor = NWPathMonitor()
    
    private var cancellables = Set<AnyCancellable>()

    init(serviceManager: ServiceManager) {
        self.serviceManager = serviceManager
        self.setupStateBinding()
        self.observeNetworkStatus()
    }

    // MARK: - setup State Binding for updating view with any changes of Observe object
    private func setupStateBinding() {
        
        // Fired when typing a query in the search field
        let newSearch = $newQuery
            .dropFirst(1)
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .handleEvents(receiveOutput: { [unowned self] _ in
                // When get any new search query, initilize with initial page
                self.page = Self.initPage
            })
            .map { (query: $0, page: Self.initPage) }

        // Fired when scrolled all the displayed list
        let nextPage = $page
            .dropFirst(1)
            .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
            .map { [unowned self] in (query: self.newQuery, page: $0) }

        // Merger both publishers with remove duplicate and search by query and page
        Publishers.Merge(newSearch, nextPage)
            .removeDuplicates(by: { $0.query == $1.query && $0.page == $1.page })
            .flatMapLatest { [unowned self] query, page -> AnyPublisher<ExecutionState, Never> in
                // Display the loading progress only when get new query
                if page == Self.initPage && !query.isEmpty {
                    self.searchingState = .loading
                }
                if !query.isEmpty {
                    self.prevQuery = query // Store prev query for loading next page
                }
                return self.searchRepositories(query: query, page: page)
            }
            .sink(receiveValue: { [weak self] state in
                guard let self =  self else {
                    return
                }
                self.searchingState = state
            })
            .store(in: &cancellables)
    }
    
    // MARK: - Search Repositories with query and page number
    
    private func searchRepositories(query: String, page: Int) -> AnyPublisher<ExecutionState, Never> {
        guard (!query.isEmpty || !self.prevQuery.isEmpty) && self.networkStatus == .satisfied else { //Don't need seach if if both query is empty or internet not available then return cache data
            let activeQuary = query.isEmpty ? self.prevQuery : query
            return self.checkCashData(activeQuary: activeQuary)
        }
        
        return self.serviceManager.repositorySearchWith(query: query.isEmpty ? self.prevQuery : query, page: page).map { [weak self] response -> ExecutionState in
            guard let self else {
                return .empty(message: .searchRepos)
            }
            guard let newRepositories = response.items, let totalCount = response.totalCount else {
                return .empty(message: .noRepos)
            }
            
            guard page > Self.initPage, case let ExecutionState.display(oldRepositories, hasNextPage) = self.searchingState, hasNextPage else {
                
                return newRepositories.isEmpty
                    ? .empty(message: .noRepos)
                    : .display(repositories: newRepositories, hasNextPage: totalCount > newRepositories.count)
            }
            var repositories = oldRepositories
            repositories.append(contentsOf: newRepositories)
            return repositories.isEmpty
                ? .empty(message: .noRepos)
                : .display(repositories: repositories, hasNextPage: totalCount > oldRepositories.count)
        }
        .catch {
            Just(.error(message: $0.localizedDescription))
                .eraseToAnyPublisher()
        }
        .eraseToAnyPublisher()
    }
    
    // MARK: - check Cache Data
    
    func checkCashData(activeQuary: String) -> AnyPublisher<ExecutionState, Never> {
        if self.networkStatus != .satisfied {
            let key = (activeQuary + String(page)) as AnyObject
            if let cash = CacheManager.sharedInstance.getUserFromCache(cacheKey: key) { //Check cache data available or not
                let repository = cash as RepositorySearchResponse
                return Just(.display(repositories: repository.items ?? [], hasNextPage: false)).eraseToAnyPublisher()
            }else {
                return Just(.error(message: "no Internet")).eraseToAnyPublisher()
            }
        }else {
            return Just(.empty(message: .noRepos)).eraseToAnyPublisher()
        }
    }
    
    // MARK: - Network Status Observation
    
    private func observeNetworkStatus() {
        NWPathMonitor()
            .publisher(queue: monitorQueue)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] status in
                self?.networkStatus = status
            }
            .store(in: &cancellables)
    }
}

