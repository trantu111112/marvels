//
//  CharacterDetailViewModel.swift
//  marvels
//
//  Created by Tu Tran on 25/12/2023.
//

import Foundation

@MainActor
class CharacterDetailViewModel<U: Codable> {
    
    var characterId: Int?
    private(set) var data: U?
    
    
    func fetchData() async {
        guard let characterId = self.characterId else {return}
        let endpoint = Characters()
            .path("\(characterId)")
            .limit(20)
            .offset(0)
            .build()
        do {
            let response: U = try await APIClient.shared.fetchDataNew(endpoint: endpoint)
            data = response
        } catch {
            print("Error fetching data: \(error)")
        }
    }
    
    func caseTypeData<T>() -> T? {
        return data as? T
    }
    
}
