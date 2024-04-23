//
//  CharactersListRequest.swift
//  MarvelDex
//
//  Created by Ricardo Ribeiro on 17/04/24.
//

import Foundation

struct CharactersListRequest: RequestProtocol {
    var page: Int
    var url: String { "https://gateway.marvel.com" }
    var path: String { "/v1/public/characters" }
    var method: String { "GET" }
    var queryParameters: [String: String]? { [
        "offset": String(page*30),
        "limit": "30",
        "apikey": CryptoManager.publicKey,
        "ts": CryptoManager.timestamp,
        "hash": CryptoManager.hash
    ] }
}
