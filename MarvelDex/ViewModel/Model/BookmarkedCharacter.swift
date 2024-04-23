//
//  BookmarkedCharacter.swift
//  MarvelDex
//
//  Created by Ricardo Ribeiro on 19/04/24.
//

import Foundation
import RealmSwift

class BookmarkedCharacter: Object, ObjectKeyIdentifiable {

    convenience init(id: String, name: String, charDescription: String, imageUrl: String, landscapeImageUrl: String) {
        self.init()
        self.id = id
        self.name = name
        self.charDescription = charDescription
        self.imageUrl = imageUrl
        self.landscapeImageUrl = landscapeImageUrl
    }

    @Persisted(primaryKey: true) var id: String
    @Persisted var name: String
    @Persisted var charDescription: String
    @Persisted var imageUrl: String
    @Persisted var landscapeImageUrl: String
}
