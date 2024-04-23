//
//  BookmarksView.swift
//  MarvelDex
//
//  Created by Ricardo Ribeiro on 19/04/24.
//

import SwiftUI
import RealmSwift

struct BookmarksView: View {

    @StateObject var viewModel: BookmarksViewModel
    @ObservedResults(BookmarkedCharacter.self)

    private var bookmarkedCharacters

    var body: some View {
        NavigationView {
            if viewModel.isUnlocked {
                VStack(alignment: .leading) {
                    Text("Bookmarks")
                        .font(.largeTitle)
                        .padding(.leading, 16)
                    ZStack {
                        if bookmarkedCharacters.isEmpty {
                            Text("You have not bookmarked any characters yet.")
                        }
                        List {
                            ForEach(bookmarkedCharacters, id: \.id) { bookmarkedCharacter in
                                CharactersListCellView(character: RealmMapper
                                    .convertBookmarkedCharacterToCharacter(bookmarkedCharacter: bookmarkedCharacter))
                            }
                            .onDelete { index in
                                $bookmarkedCharacters.remove(atOffsets: index)
                            }
                            .listRowSeparator(.hidden)
                        }
                        .listStyle(.plain)
                    }
                }
            } else {
                Text("Locked")
            }
        }
        .onAppear {
            if !viewModel.isUnlocked {
                viewModel.authenticate()
            }
        }
    }
}
