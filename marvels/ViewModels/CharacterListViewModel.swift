//
//  MarvelViewModel.swift
//  marvels
//
//  Created by Tu Tran on 24/12/2023.
//

import Foundation
import CryptoKit

@MainActor
class CharacterListViewModel: ObservableObject {
    @Published var characterList: [MarvelCharacter]?
    @Published var isLoadingData: Bool = false
    @Published var isLoadingMore: Bool = false
    var characterQueryData: MarvelResponse?
    var displayedList: [MarvelCharacter]? = []
    var apiClient: APIClientProtocol
    static var AMOUNT_TO_LOAD = 20

    init(_ apiClient: APIClientProtocol = APIClient.shared) {
        self.apiClient = apiClient
        getCharacterList(isRefesh: true)
    }

    func fetchData(step: Int, offset: Int ) async -> MarvelResponse? {
        var data: MarvelResponse?
        let endpoint = Characters()
            .limit(step)
            .offset(offset)
            .build()
        do {
            let response: MarvelResponse = try await apiClient.fetchDataNew(endpoint: endpoint)
            data = response
        } catch {
            print("Error fetching data: \(error)")
        }
        return data
    }

    func getCharacterList(isRefesh: Bool) {
        Task {
            var data: MarvelResponse?
            if !isRefesh {
                isLoadingMore = true
                let amountToLoad = amountToLoad()
                guard amountToLoad > 0 else {return}
                data = await fetchData(step: CharacterListViewModel.AMOUNT_TO_LOAD, offset: characterList?.count ?? 0)
                isLoadingMore = false
            } else {
                isLoadingData = true
                data = await fetchData(step: CharacterListViewModel.AMOUNT_TO_LOAD, offset: 0)
                isLoadingData = false
            }
            updateData(data, isRefresh: isRefesh)
        }
    }

    func amountToLoad() -> Int {
        guard let total = characterQueryData?.data?.total else { return 0}
        guard let currentTotal = characterList?.count else { return 0}
        if currentTotal >= total { return 0}
        if currentTotal + CharacterListViewModel.AMOUNT_TO_LOAD > total {
            return total - currentTotal
        }
        return CharacterListViewModel.AMOUNT_TO_LOAD
    }

    func updateData(_ data: MarvelResponse?, isRefresh: Bool) {
        guard let dataTemp = data else {return}
        characterQueryData = dataTemp
        if isRefresh {
            characterList = dataTemp.data?.results
            return
        }
        characterList?.append(contentsOf: dataTemp.data?.results?.unwrapped() ?? [])
    }

    func updateDisplayedList(_ character: MarvelCharacter, isDisplayed: Bool) {
        if isDisplayed {
            displayedList?.append(character)
        } else {
            displayedList?.removeAll(where: { displayedCharacter in
                displayedCharacter.id == character.id
            })
        }

        if displayedList?.last?.id == characterList?.last?.id && !isLoadingMore {
            getCharacterList(isRefesh: false)
        }
    }

}
