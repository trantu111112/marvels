//
//  MockAPIClient.swift
//  marvelsTests
//
//  Created by Tu Tran on 29/12/2023.
//

import Foundation
@testable import marvels

final class MockAPIClient: APIClientProtocol, Mockable {
    static var shared: marvels.APIClientProtocol = MockAPIClient()
    
    func fetchDataNew<T: Codable>(endpoint: String) async throws -> T {
        return loadJSON(fileName: "CharacterMock", type: T.self)
    }

}
