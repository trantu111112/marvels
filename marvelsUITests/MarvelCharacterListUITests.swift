//
//  MarvelCharacterListUITests.swift
//  marvelsUITests
//
//  Created by Tu Tran on 29/12/2023.
//

import XCTest

class MarvelCharacterGridUITests: XCTestCase {

    @MainActor
    func testMarvelCharacterGrid() async throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        let navigatonView = app.otherElements["MarvelCharacterNavigationViewId"]
        let gridview = app.otherElements["MarvelCharacterGridView"]
        let characterScroll = app.scrollViews["MarvelCharacterScrollView"]
        print(XCUIApplication().debugDescription)
        
        XCTAssertTrue(navigatonView.exists, "characterNavigation view does not exist")
        XCTAssertTrue(gridview.exists, "characterGrid view does not exist")
        XCTAssertTrue(characterScroll.exists, "characterScroll view does not exist")
    }

}
