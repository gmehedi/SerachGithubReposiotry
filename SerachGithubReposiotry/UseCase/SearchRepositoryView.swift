//
//  SearchRepositoryView.swift
//  SerachGithubReposiotry
//
//  Created by M M Mehedi Hasan on 19/3/23.
//

import SwiftUI
import Combine

// MARK: - SearchRepository View update the searching state by depends on api response

struct SearchRepositoryView: View {
    
    @ObservedObject var viewModel = RepositorySerarchViewModel(serviceManager: ServiceManager())
    
    var body: some View {
        NavigationStack {
            VStack {
                switch viewModel.searchingState {
                case let .display(repositories, hasNextPage):
                    RepositoriesList(viewModel: self.viewModel, repository: repositories, hasNextPage: hasNextPage)
                case let .empty(message):
                    MessageView(message: message, color: .gray)
                case let .error(message):
                    MessageView(message: message, color: .red)
                case .loading:
                    LoadingView()
                }
            }.searchable(text: $viewModel.newQuery, placement: .navigationBarDrawer(displayMode: .always), prompt: String.searchRepos).navigationTitle("Repositories")
        }
    }
}


// MARK: - Repositories List

private struct RepositoriesList: View {
    @ObservedObject var viewModel: RepositorySerarchViewModel
    
    let repository: [RepositoryItem]
    let hasNextPage: Bool
    
    var body: some View {
        List {
            ForEach(repository) { repository in
                NavigationLink(value: repository) {
                    RepositoryCell(repository: repository, viewModel: viewModel)
                }
            }
            if hasNextPage  { //&& !self.viewModel.query.isEmpty
                PageLoadingCell(viewModel: viewModel)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .listStyle(PlainListStyle())
        .listRowInsets(EdgeInsets())
        .listRowBackground(Color.black)
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationDestination(for: RepositoryItem.self) { item in
            RepoDetailsView(repository: item)
        }
    }
}

// MARK: - RepositoryRow

private struct RepositoryCell: View {
    let repository: RepositoryItem
    
    @ObservedObject var viewModel: RepositorySerarchViewModel
    
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            ImageHolderView(url: URL(string: (repository.owner?.avatarUrl ?? "") )!, size: CGSize(width: 60, height: 60) )
                .frame(width: 60, height: 60)
                .cornerRadius(30)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(repository.name ?? "")
                    .font(.headline)
                    .foregroundColor(.white)
                
                Text(repository.repoDescription ?? "")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .frame(height: 32)
            }
            Spacer()
        }
    }
}


// MARK: - Page PageLoadingCell

public struct PageLoadingCell: View {
    @ObservedObject var viewModel: RepositorySerarchViewModel
    
    public var body: some View {
        HStack(spacing: 16) {
            Text("Loading...")
                .font(.callout)
                .foregroundColor(.gray)
            ProgressView().id(self.viewModel.page)
        }.onAppear {
            self.viewModel.page += 1
        }
    }
}
