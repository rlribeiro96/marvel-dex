//
//  CharactersListViewModelTests.swift
//  MarvelDexTests
//
//  Created by Ricardo Ribeiro on 21/04/24.
//

import XCTest
@testable import MarvelDex


class CharactersListViewModelTests: XCTestCase {
    
    func testFetchAllCharacters_responseSuccess() async throws {
        let getAllCharacteresUseCase = GetAllCharactersUseCaseMock(successful: true)
        let viewModel = CharactersListViewModel(getAllCharactersUseCase: getAllCharacteresUseCase)

        await viewModel.fetchAllCharacters()

        XCTAssertEqual(viewModel.state, .loaded)
        XCTAssertFalse(viewModel.charactersList.isEmpty)
    }
    
    func testFetchAllCharacters_responseFailure() async throws {
        let getAllCharacteresUseCase = GetAllCharactersUseCaseMock(successful: false)
        let viewModel = CharactersListViewModel(getAllCharactersUseCase: getAllCharacteresUseCase)

        await viewModel.fetchAllCharacters()

        XCTAssertEqual(viewModel.state, .error)
        XCTAssertTrue(viewModel.charactersList.isEmpty)
    }
    
    func testFetchSearchedCharacters_responseSuccess() async throws {
        let getSearchedCharactersUseCase = SearchedCharactersUseCaseProtocolMock(successful: true)
        let viewModel = CharactersListViewModel(getSearchedCharactersUseCase: getSearchedCharactersUseCase)

        await viewModel.fetchSearchedCharacters(query: "spider")

        XCTAssertEqual(viewModel.state, .loaded)
        XCTAssertNotNil(viewModel.query)
        XCTAssertFalse(viewModel.charactersList.isEmpty)
    }

    func testFetchSearchedCharacters_responseFailure() async throws {
        let getSearchedCharactersUseCase = SearchedCharactersUseCaseProtocolMock(successful: false)
        let viewModel = CharactersListViewModel(getSearchedCharactersUseCase: getSearchedCharactersUseCase)

        await viewModel.fetchSearchedCharacters(query: "spider")

        XCTAssertEqual(viewModel.state, .error)
        XCTAssertNotNil(viewModel.query)
        XCTAssertTrue(viewModel.charactersList.isEmpty)
    }
}

class SearchedCharactersUseCaseProtocolMock: GetSearchedCharactersUseCaseProtocol {

    var successful: Bool

    init(successful: Bool) {
        self.successful = successful
    }

    func getSearchedCharacters(query: String, page: Int) async throws -> [MarvelDex.Character] {
        if successful {
            return [
                Character(id: "1",
                          name: "Spider-Man",
                          description: "Uncle ben would be proud of him.",
                          imageUrl: "",
                          landscapeImageUrl: ""
                         ),
                Character(id: "2",
                          name: "Hulk",
                          description: "Greener than a pea.",
                          imageUrl: "",
                          landscapeImageUrl: ""
                         )
            ]
        } else {
            throw NetworkError.dataRequestError("failure")
        }
    }
}

class GetAllCharactersUseCaseMock: GetAllCharactersUseCaseProtocol {

    var successful: Bool

    init(successful: Bool) {
        self.successful = successful
    }

    func getAllCharacters(page: Int) async throws -> [MarvelDex.Character] {
        if successful {
            return [
                Character(id: "1",
                          name: "Spider-Man",
                          description: "Uncle ben would be proud of him.",
                          imageUrl: "",
                          landscapeImageUrl: ""
                         ),
                Character(id: "2",
                          name: "Hulk",
                          description: "Greener than a pea.",
                          imageUrl: "",
                          landscapeImageUrl: ""
                         )
            ]
        } else {
            throw NetworkError.dataRequestError("failure")
        }
    }
}

