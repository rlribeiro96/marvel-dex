//
//  GetAllCharactersUseCase.swift
//  MarvelDex
//
//  Created by Ricardo Ribeiro on 17/04/24.
//

import Foundation

protocol GetAllCharactersUseCaseProtocol {
    func getAllCharacters(page: Int) async throws -> [Character]
}

class GetAllCharactersUseCase: GetAllCharactersUseCaseProtocol {

    private let charactersService: CharactersServiceProtocol

    init(charactersService: CharactersServiceProtocol = CharactersService()) {
        self.charactersService = charactersService
    }

    func getAllCharacters(page: Int) async throws -> [Character] {
        let charactersResponse = try await charactersService.fetchAllCharacters(page: page)

        return charactersResponse.map {
            Character(id: String($0.id),
                      name: $0.name,
                      description: $0.description,
                      imageUrl: "\($0.thumbnail.path)/standard_medium.\($0.thumbnail.extension)",
                      landscapeImageUrl: "\($0.thumbnail.path)/landscape_incredible.\($0.thumbnail.extension)"
            )
        }
    }
}
