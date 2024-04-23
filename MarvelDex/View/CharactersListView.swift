//
//  CharactersListView.swift
//  MarvelDex
//
//  Created by Ricardo Ribeiro on 17/04/24.
//

import SwiftUI

struct CharactersListView: View {

    @StateObject var viewModel: CharactersListViewModel

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                SearchedCharactersHeaderView().environmentObject(viewModel)
                switch viewModel.state {
                case .loading:
                    LoadingView()
                case .loaded, .idle:
                    CharactersListContainerView().environmentObject(viewModel)
                case .error, .errorNoNetwork, .errorNoResults:
                    ErrorView().environmentObject(viewModel)
                }
            }
            .padding(.horizontal, 16)
            .task {
                if viewModel.state != .loaded {
                    await viewModel.fetchAllCharacters()
                }
            }
        }
    }
}

struct SearchedCharactersHeaderView: View {

    @EnvironmentObject var viewModel: CharactersListViewModel

    var body: some View {
        TextField(" Search for characters...", text: $viewModel.query)
            .padding(EdgeInsets(top: 0, leading: 6, bottom: 0, trailing: 6))
            .frame(height: 32)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .onChange(of: viewModel.query, perform: { _ in
                Task {
                    await viewModel.fetchSearchedCharacters(query: viewModel.query)
                }
            })
    }
}

struct CharactersListContainerView: View {

    @EnvironmentObject var viewModel: CharactersListViewModel

    var body: some View {
        Text("Characters")
            .font(.largeTitle)
        ScrollView(showsIndicators: false) {
            LazyVStack(alignment: .leading) {
                ForEach(viewModel.charactersList, id: \.id) { character in
                    CharactersListCellView(character: character)
                        .task {
                            if viewModel.recheadEndOfPage(character: character) && !viewModel.isSearch {
                                await viewModel.fetchCharactersNextPage()
                            }
                        }
                }
            }
        }
    }
}

struct CharactersListCellView: View {

    @Environment(\.realm) var realm
    @State var bookmarked: Bool = false

    var character: Character

    var body: some View {
        NavigationLink(destination: CharacterDetailsView(character: character)) {
            let bookmarkedCharacter = RealmMapper.convertCharacterToBookmarkedCharacter(character: character)
            HStack {
                ThumbnailContainerView(imageUrl: character.imageUrl, height: 100, width: 100)
                Text(character.name)
                    .font(.system(size: 16))
                    .padding(.leading)
                Spacer()
                Button(action: {
                    try? realm.write {
                        if bookmarked {
                            realm.delete(realm.objects(BookmarkedCharacter.self)
                                .filter("id=%@", bookmarkedCharacter.id))
                            bookmarked = false
                            return
                        }
                        realm.add(bookmarkedCharacter, update: .all)
                        bookmarked = true
                    }
                }, label: {
                    Image(systemName: bookmarked ? "heart.fill" : "heart")
                        .resizable()
                        .frame(width: 24, height: 20)
                        .tint(.red)
                })
            }
            .onAppear {
                bookmarked = realm.object(ofType: BookmarkedCharacter.self,
                                          forPrimaryKey: character.id) != nil
            }
        }
        .buttonStyle(.plain)
    }
}

struct ThumbnailContainerView: View {

    let imageUrl: String
    var height: CGFloat
    var width: CGFloat

    var body: some View {
        AsyncImage(url: URL(string: imageUrl)) { imageResponse in
            if let image = imageResponse.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: width, height: height)
                    .font(.system(size: 20))
                    .clipped()
            } else if imageResponse.error != nil || imageUrl.isEmpty {
                Text("thumbnail not found")
                    .frame(width: width, height: height)
                    .multilineTextAlignment(.center)
                    .border(.gray, width: 0.5)
            } else {
                LoadingView(height: height, width: width)
            }
        }
    }
}
