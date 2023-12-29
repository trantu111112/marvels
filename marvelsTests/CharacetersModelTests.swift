//
//  CharacetersModelTests.swift
//  marvelsTests
//
//  Created by Tu Tran on 28/12/2023.
//

import XCTest
@testable import marvels


final class CharacetersModelTests: XCTestCase {
    
    @MainActor func testInit() async throws {
        let model = CharacterListViewModel()
        // our expectation has been fulfilled, so we can check the result is correct
        try await Task.sleep(nanoseconds: 5 * 1_000_000_000)
        XCTAssertEqual(model.characterList?.count, 20, "We should have loaded exactly 20 characters.")
    }
    
    @MainActor func testFetchData() async throws {
        let model = CharacterListViewModel()
        let response = await model.fetchData(step: 20, offset: 20)
        // our expectation has been fulfilled, so we can check the result is correct
        XCTAssertEqual(response?.data?.results?.count, 20, "We should have loaded exactly 20 characters.")
    }
    
    @MainActor func testGeCharacterList() async throws {
        let model = CharacterListViewModel()
        model.getCharacterList(isRefesh: true)
        try await Task.sleep(nanoseconds: 5 * 1_000_000_000)
        XCTAssertEqual(model.characterList?.count, 20, "The data list should be 20 characters")
    }
    
    @MainActor func testLoadingMore() async throws {
        let model = CharacterListViewModel()
        try await Task.sleep(nanoseconds: 3 * 1_000_000_000)
        model.getCharacterList(isRefesh: false)
        try await Task.sleep(nanoseconds: 3 * 1_000_000_000)
        XCTAssertEqual(model.characterList?.count, 40, "The data list should be 40 characters")
    }
}
