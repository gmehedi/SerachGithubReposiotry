//
//  RepoDetailsView.swift
//  SerachGithubReposiotry
//
//  Created by M M Mehedi Hasan on 20/3/23.
//

import Foundation
import SwiftUI

// MARK: - RepoDetailsView show the repository details

struct RepoDetailsView: View {
    
    let repository: RepositoryItem
    
    var body: some View {
        VStack(alignment: .center) {
            ImageHolderView(url: URL(string: (repository.owner?.avatarUrl ?? "") )!, size: CGSize(width: 350, height: 350) )
                .frame(width: 350, height: 350)
                .cornerRadius(8)
            
            Spacer()
            
            VStack(alignment: .leading) {
                HStack {
                    Text(String.owner)
                        .fontWeight(.semibold)
                    Text(repository.owner?.userName ?? "")
                }
               
                Text(repository.name ?? "")
                    .font(.title)
                Text(repository.repoDescription ?? "")
                    .font(.subheadline)
                
                Text(String.toBrowser)
                    .foregroundColor(.blue)
                    .onTapGesture {
                        UIApplication.shared.open(URL(string: repository.htmlUrl ?? "")!)
                    }
                
                HStack {
                    Text(String.language)
                        .fontWeight(.semibold)
                    Text(repository.language ?? .unknown)
                }
            }
            
            Spacer()
        }
    }
}
