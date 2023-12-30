//
//  APClientTests.swift
//  marvelsTests
//
//  Created by Tu Tran on 29/12/2023.
//

import XCTest
@testable import marvels

final class APIClientTests: XCTestCase {
    
    var model: marvels.CharacterListViewModel!
    
    @MainActor override func setUp() {
        super.setUp()
        model = CharacterListViewModel(MockAPIClient())
    }
    
    override func tearDown() {
        super.tearDown()
        model = nil
    }
    
    @MainActor func testFetchData() async throws {
        model.getCharacterList(isRefesh: true)
        try await Task.sleep(nanoseconds: 3 * 1_000_000_000)
        XCTAssertEqual(model.characterList?.count, 2, "The data list should be 2 characters")
    }
    
    @MainActor func testId() async throws {
        model.getCharacterList(isRefesh: true)
        try await Task.sleep(nanoseconds: 3 * 1_000_000_000)
        let firstCharacter = model.characterList?.first
        XCTAssertEqual(firstCharacter?.id, 1011334, "The firs Id should be 1011334")
        XCTAssertEqual(firstCharacter?.name, "3-D Man", "The name should be 3-D Man")
    }
}
