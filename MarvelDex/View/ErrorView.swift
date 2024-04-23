//
//  ErrorView.swift
//  MarvelDex
//
//  Created by Ricardo Ribeiro on 20/04/24.
//

import SwiftUI

struct ErrorView: View {

    @EnvironmentObject var viewModel: CharactersListViewModel

    var body: some View {
        VStack(spacing: 16) {
            Spacer()
            HStack {
                Spacer()
                Text(viewModel.getErrorMessage())
                Button {
                    Task {
                        viewModel.state = .idle
                        await viewModel.fetchAllCharacters()
                    }
                } label: {
                    Text("try again")
                }
                Spacer()
            }
            Spacer()
        }
    }
}
