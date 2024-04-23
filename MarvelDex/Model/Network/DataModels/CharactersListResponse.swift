//
//  CharacterListResponse.swift
//  MarvelDex
//
//  Created by Ricardo Ribeiro on 17/04/24.
//

import Foundation

struct CharactersListResponse: Decodable {
    var data: CharacterDataResponse
}

struct CharacterDataResponse: Decodable {
    var results: [CharacterResponse]
}

struct CharacterResponse: Decodable {
    var id: Int
    var name, description: String
    var thumbnail: CharacterThumbnailResponse
}

struct CharacterThumbnailResponse: Decodable {
    var path: String
    var `extension`: String
}
