//
//  MessageView.swift
//  SerachGithubReposiotry
//
//  Created by M M Mehedi Hasan on 19/3/23.
//

import SwiftUI

// MARK: - Message Showing View

struct MessageView: View {
    let message: String
    let color: Color

    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            Text(message)
                .font(.title)
                .foregroundColor(color)
            Spacer()
        }
    }
}

