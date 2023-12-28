//
//  marvelsTests.swift
//  marvelsTests
//
//  Created by Tu Tran on 23/12/2023.
//

import XCTest
@testable import marvels

final class marvelsTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testFetchData() async {
        let viewModel = await CharacterListViewModel()
        
        // Create an expectation
        let expectation = expectation(description: "Fetch data expectation")
        
        // Perform the asynchronous test
        Task {
            let data = await viewModel.fetchData(step: 20, offset: 0)
            XCTAssertNotNil(data, "Data should not be nil")
            
            // Fulfill the expectation
            expectation.fulfill()
        }
        
        // Wait for the expectation to be fulfilled
        await waitForExpectations(timeout: 10) // Adjust the timeout as needed
    }
    
    @MainActor
    func testGetCharacterList() async {
        let viewModel = await CharacterListViewModel()
        
        // Create an expectation
        let expectation = expectation(description: "Get character list expectation")
        
        // Perform the asynchronous test
        Task {
            await viewModel.getCharacterList(isRefesh: true)
            
            // Wait for a short duration to simulate the asynchronous nature
            await Task.sleep(1 * 1_000_000_000) // 1 second
            
            XCTAssertNotNil(viewModel.characterList, "Character list should not be nil")
            XCTAssertFalse(viewModel.isLoadingData, "isLoadingData should be false after fetching data")
            
            // Fulfill the expectation
            expectation.fulfill()
        }
        
        // Wait for the expectation to be fulfilled
        await waitForExpectations(timeout: 5) // Adjust the timeout as needed
    }
    

}
