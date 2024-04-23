//
//  CharactersService.swift
//  MarvelDex
//
//  Created by Ricardo Ribeiro on 17/04/24.
//

import Foundation

protocol CharactersServiceProtocol {
    func fetchAllCharacters(page: Int) async throws -> [CharacterResponse]
    func fetchSearchedCharacters(query: String, page: Int) async throws -> [CharacterResponse]
}

final class CharactersService: CharactersServiceProtocol {

    public var apiManager: ApiManagerProtocol

    init(apiManager: ApiManagerProtocol = ApiManager()) {
        self.apiManager = apiManager
    }

    func fetchAllCharacters(page: Int) async throws -> [CharacterResponse] {
        let urlRequest = try buildRequest(CharactersListRequest(page: page))
        return try await apiManager.callApi(CharactersListResponse.self, urlRequest: urlRequest).data.results
    }

    func fetchSearchedCharacters(query: String, page: Int) async throws -> [CharacterResponse] {
        let urlRequest = try buildRequest(SearchedCharactersRequest(query: query, page: page))
        return try await apiManager.callApi(SearchedCharactersResponse.self, urlRequest: urlRequest).data.results
    }

    func buildRequest(_ requestModel: RequestProtocol) throws -> URLRequest {
        let parameters = requestModel.queryParameters?.map { URLQueryItem(name: $0.key, value: $0.value) }
        var urlComponents = URLComponents(string: requestModel.url + requestModel.path)

        urlComponents?.queryItems = parameters

        guard let url = urlComponents?.url else {
            throw NetworkError.badUrl("Bad Url.")
        }

        var urlRequest = URLRequest(url: url, cachePolicy: .reloadRevalidatingCacheData)
        urlRequest.httpMethod = requestModel.method

        return urlRequest
    }
}
