//
//  RealmManager.swift
//  MarvelDex
//
//  Created by Ricardo Ribeiro on 19/04/24.
//

import Foundation

class RealmMapper {

    static func convertBookmarkedCharacterToCharacter(bookmarkedCharacter: BookmarkedCharacter) -> Character {
        return Character(id: bookmarkedCharacter.id,
                         name: bookmarkedCharacter.name,
                         description: bookmarkedCharacter.charDescription,
                         imageUrl: bookmarkedCharacter.imageUrl,
                         landscapeImageUrl: bookmarkedCharacter.landscapeImageUrl)
    }

    static func convertCharacterToBookmarkedCharacter(character: Character) -> BookmarkedCharacter {
        return BookmarkedCharacter(id: character.id,
                                   name: character.name,
                                   charDescription: character.description,
                                   imageUrl: character.imageUrl,
                                   landscapeImageUrl: character.landscapeImageUrl)
    }
}
