//
//  CryptoManager.swift
//  MarvelDex
//
//  Created by Ricardo Ribeiro on 17/04/24.
//

import Foundation
import CryptoKit

class CryptoManager {

    static var publicKey = ""
    static var privateKey = ""
    static var timestamp = "1"
    static var hash = ""

    static func getKeys() {
        if let path = Bundle.main.path(forResource: "api_keys", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                let apiKeys = try decoder.decode(APIKeys.self, from: data)

                publicKey = apiKeys.publicKey
                privateKey = apiKeys.privateKey
                getMD5()
            } catch {
                print("Error reading API keys:", error)
            }
        }
    }

    static func getMD5() {
        let fullString = timestamp + privateKey + publicKey
        let digest = Insecure.MD5.hash(data: Data(fullString.utf8))

        hash = digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
}

struct APIKeys: Decodable {
    let publicKey: String
    let privateKey: String
}
