//
//  CharacterListViewModel.swift
//  MarvelDex
//
//  Created by Ricardo Ribeiro on 17/04/24.
//

import Foundation
import Reachability

protocol CharactersListViewModelProtocol {
    func fetchAllCharacters() async
    func fetchSearchedCharacters(query: String) async
}

class CharactersListViewModel: CharactersListViewModelProtocol, Observable, ObservableObject {

    @Published var query: String = ""
    @Published var isSearch: Bool = false
    @Published var state: ResponseState = .idle
    @Published var charactersList: [Character] = []

    private var page = 0
    private let reachability = try? Reachability()
    private let getAllCharactersUseCase: GetAllCharactersUseCaseProtocol
    private let getSearchedCharactersUseCase: GetSearchedCharactersUseCaseProtocol

    init(getAllCharactersUseCase: GetAllCharactersUseCaseProtocol = GetAllCharactersUseCase(),
         getSearchedCharactersUseCase: GetSearchedCharactersUseCaseProtocol = GetSearchedCharactersUseCase()) {
        self.getAllCharactersUseCase = getAllCharactersUseCase
        self.getSearchedCharactersUseCase = getSearchedCharactersUseCase
    }

    @MainActor
    func fetchAllCharacters() async {
        isSearch = false
        state = .loading

        charactersList = []
        do {
            let charactersList = try await getAllCharactersUseCase.getAllCharacters(page: page)
            state = charactersList.isEmpty ? .error : .loaded
            self.charactersList = charactersList
        } catch {
            checkForConexionError()
        }
    }

    @MainActor
    func fetchCharactersNextPage() async {
        page += 1

        do {
            let nextPageCharactersList = try await getAllCharactersUseCase.getAllCharacters(page: page)
            self.charactersList.append(contentsOf: nextPageCharactersList)
        } catch {
            checkForConexionError()
        }
    }

    @MainActor
    func fetchSearchedCharacters(query: String) async {
        isSearch = true
        state = .loading

        if !query.isEmpty {
            do {
                charactersList = try await getSearchedCharactersUseCase.getSearchedCharacters(query: query.lowercased(),
                                                                                              page: page)
                self.state = !charactersList.isEmpty ? .loaded : .errorNoResults
            } catch {
                checkForConexionError()
            }
        } else {
            page = 0
            await fetchAllCharacters()
        }
    }

    func getErrorMessage() -> String {
        var message = ""

        switch state {
        case .error:
            message = "Sorry, something went wrong."
        case .errorNoNetwork:
            message = "No internet conexion."
        case .errorNoResults:
            message = "No results found."
        default:
            break
        }

        return message
    }

    func recheadEndOfPage(character: Character) -> Bool {
        return charactersList.last?.id == character.id
    }

    private func checkForConexionError() {
        if reachability?.connection == .unavailable {
            self.state = .errorNoNetwork
            return
        }
        self.state = .error
    }
}
