//
//  WomenOfMarvelUITests.swift
//  WomenOfMarvelUITests
//
//  Created by fmustafa on 5/2/22.
//

import XCTest

class WomenOfMarvelUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.

        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.

        try super.tearDownWithError()
    }

    func testExpectedComicBookLabelsText() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        // Using the Builder Pattern to easily test views
        ComicBookOverviewPageObject()
            .verifyComicBookTitle()
            .verifyComicBookDescription()
    }
}
