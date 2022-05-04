//
//  ComicBookOverviewPageObject.swift
//  WomenOfMarvelUITests
//
//  Created by fmustafa on 5/3/22.
//

import XCTest

class ComicBookOverviewPageObject: XCTestCase {
    var app: XCUIApplication = XCUIApplication()

    @discardableResult
    func verifyComicBookTitle() -> Self {

        let titleText = "Official Handbook of the Marvel Universe (2004) #9 (THE WOMEN OF MARVEL)"

        let titlePredicate = NSPredicate(format: "label CONTAINS[c] %@", titleText)
        let titleQuery = app.staticTexts.containing(titlePredicate)
        let titleExist = titleQuery.element.waitForExistence(timeout: 5)

        XCTAssertTrue(titleExist, "The Comic Book Title \(titleQuery) should exist")

        return self
    }

    @discardableResult
    func verifyComicBookDescription() -> Self {
        let descriptionText = "Marvel's leading ladies take center stage!"

        let descriptionPredicate = NSPredicate(format: "label CONTAINS[c] %@", descriptionText)
        let descriptionQuery = app.staticTexts.containing(descriptionPredicate)
        let descriptionTextExists = descriptionQuery.element.waitForExistence(timeout: 5)
        XCTAssertTrue(descriptionTextExists, "The Comic Book description \(descriptionQuery) should exist")

        return self
    }
}
