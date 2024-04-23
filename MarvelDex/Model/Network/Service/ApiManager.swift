//
//  ApiManager.swift
//  MarvelDex
//
//  Created by Ricardo Ribeiro on 17/04/24.
//

import Foundation

enum NetworkError: Error {
    case dataRequestError(String)
    case badUrl(String)
    case badNetwork(String)
}

protocol ApiManagerProtocol {
    func callApi<T: Decodable>(_: T.Type, urlRequest: URLRequest) async throws -> T
}

class ApiManager: ApiManagerProtocol {

    func callApi<T>(_: T.Type, urlRequest: URLRequest) async throws -> T where T: Decodable {
        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            return  try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.dataRequestError("Bad request.")
        }
    }
}
