//
//  SearchedCharactersRequest.swift
//  MarvelDex
//
//  Created by Ricardo Ribeiro on 20/04/24.
//

import Foundation

struct SearchedCharactersRequest: RequestProtocol {
    var query: String
    var page: Int
    var url: String { "https://gateway.marvel.com" }
    var path: String { "/v1/public/characters" }
    var method: String { "GET" }
    var queryParameters: [String: String]? { [
        "nameStartsWith": self.query,
        "offset": String(page*30),
        "limit": "30",
        "apikey": CryptoManager.publicKey,
        "ts": CryptoManager.timestamp,
        "hash": CryptoManager.hash
    ] }
}
