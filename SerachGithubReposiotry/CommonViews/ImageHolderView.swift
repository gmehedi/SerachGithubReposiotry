//
//  ImageHolderView.swift
//  SerachGithubReposiotry
//
//  Created by M M Mehedi Hasan on 19/3/23.
//

import Foundation
import SwiftUI

// MARK: - ImageHolderView

public struct ImageHolderView: View {
    let url: URL
    let size: CGSize
    
    public var body: some View {
        CachedAsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case let .success(image):
                image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: size.width, maxHeight: size.height)
            case .failure:
                Circle().background(.gray.opacity(0.2))
                //Image(uiImage: UIImage(named: "placeHolder")!)
            @unknown default:
                EmptyView()
            }
        }
    }
}

