//
//  NetworkTesting.swift
//  MarvelDexTests
//
//  Created by Ricardo Ribeiro on 21/04/24.
//

import XCTest
@testable import MarvelDex

class NetworkTesting: XCTestCase {
    
    var sut: CharactersService?
    
    override func setUp() {
        super.setUp()
        sut = CharactersService()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testRequestBuilding() async throws {
        let results = [
            CharacterResponse(id: 1,
                              name: "Spider-Man",
                              description: "Uncle ben would be proud of him.",
                              thumbnail: CharacterThumbnailResponse(path: "", extension: "")),
            CharacterResponse(id: 2,
                              name: "Hulk",
                              description: "Greener than a pea.",
                              thumbnail: CharacterThumbnailResponse(path: "", extension: ""))
        ]
        
        let mockedResponse = CharactersListResponse(data: CharacterDataResponse(results: results))
        
        let apiManagerMock = ApiManagerMock(mockedResponse: mockedResponse)
        sut?.apiManager = apiManagerMock
        
        let requestUrl = try sut?.buildRequest(CharactersListRequest(page: 0))
        XCTAssertNotNil(requestUrl)
    }
    
    func testFetchAllCharacters() async throws {
        let results = [
            CharacterResponse(id: 1,
                              name: "Spider-Man",
                              description: "Uncle ben would be proud of him.",
                              thumbnail: CharacterThumbnailResponse(path: "", extension: "")),
            CharacterResponse(id: 2,
                              name: "Hulk",
                              description: "Greener than a pea.",
                              thumbnail: CharacterThumbnailResponse(path: "", extension: ""))
        ]
        
        let mockedResponse = CharactersListResponse(data: CharacterDataResponse(results: results))
        
        let apiManagerMock = ApiManagerMock(mockedResponse: mockedResponse)
        sut?.apiManager = apiManagerMock
        
        let searchResults = try await sut?.fetchAllCharacters(page: 0)
        XCTAssertEqual(searchResults?.count, 2)
    }
    
    func testFetchSearchedCharacters() async throws {
        let results = [
            CharacterResponse(id: 1,
                              name: "Spider-Man",
                              description: "Uncle ben would be proud of him.",
                              thumbnail: CharacterThumbnailResponse(path: "", extension: "")),
            CharacterResponse(id: 2,
                              name: "Hulk",
                              description: "Greener than a pea.",
                              thumbnail: CharacterThumbnailResponse(path: "", extension: ""))
        ]
        
        let mockedResponse = SearchedCharactersResponse(data: CharacterDataResponse(results: results))
        
        let apiManagerMock = ApiManagerMock(mockedResponse: mockedResponse)
        sut?.apiManager = apiManagerMock
        
        let searchResults = try await sut?.fetchSearchedCharacters(query: "", page: 0)
        
        XCTAssertEqual(searchResults?.count, 2)
    }
}

final class ApiManagerMock: ApiManagerProtocol {
    
    let mockedResponse: Decodable
    
    init(mockedResponse: Decodable) {
        self.mockedResponse = mockedResponse
    }
    
    func callApi<T>(_: T.Type, urlRequest: URLRequest) async throws -> T where T : Decodable {
        guard T.self == T.self else {
            throw NetworkError.dataRequestError("Unexpected type")
        }
        return mockedResponse as! T
    }
}
