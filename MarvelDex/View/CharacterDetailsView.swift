//
//  CharacterDetailsView.swift
//  MarvelDex
//
//  Created by Ricardo Ribeiro on 18/04/24.
//

import SwiftUI
import RealmSwift

@available(iOS 16.0, *)
struct CharacterDetailsView: View {

    @State var bookmarked: Bool = false
    @Environment(\.realm) var realm

    let character: Character

    var body: some View {
        ScrollView {
            let bookmarkedCharacter = RealmMapper.convertCharacterToBookmarkedCharacter(character: character)
            VStack(alignment: .leading) {
                Text(character.name)
                    .font(.largeTitle)
                    .padding(.horizontal, 16)
                ThumbnailContainerView(imageUrl: character.landscapeImageUrl,
                                       height: 260,
                                       width: UIScreen.main.bounds.width)
                HStack(alignment: .bottom, spacing: 16) {
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
                    ShareLink(item: character.landscapeImageUrl) {
                        Image(systemName: "square.and.arrow.up")
                            .resizable()
                            .frame(width: 16, height: 20)
                    }
                }
                .padding(.horizontal, 16)
                Text(character.description)
                    .font(.subheadline)
                    .padding(16)
                Spacer()
            }
            .onAppear {
                bookmarked = realm.object(ofType: BookmarkedCharacter.self, forPrimaryKey: character.id) != nil
            }
        }
    }
}
