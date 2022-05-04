//
//  WomenOfMarvelViewModelTests.swift
//  WomenOfMarvelTests
//
//  Created by fmustafa on 5/3/22.
//

import XCTest
@testable import WomenOfMarvel

class WomenOfMarvelViewModelTests: XCTestCase {
    // sut stands for system under test
    var sut: WomenOfMarvelViewModel!

    override func setUp() {
        super.setUp()
        sut = WomenOfMarvelViewModel()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func testExpectedFullImageString() {
        // given
        let mockUrlPath = "http://i.annihil.us/u/prod/marvel/i/mg/9/b0/4c7d666c0e58a"
        let mockExtension = "jpg"

        // when
        let urlString = sut.getFullImageURLString(with: mockUrlPath, of: mockExtension)

        // then
        XCTAssertEqual(urlString, "http://i.annihil.us/u/prod/marvel/i/mg/9/b0/4c7d666c0e58a.jpg")
    }

    func testNilURLReturnsEmptyString() {
        // given
        let mockExtension = "jpg"

        // when
        let urlString = sut.getFullImageURLString(with: nil, of: mockExtension)

        // then
        XCTAssertEqual(urlString, "")
    }

    func testNilExtensionReturnsEmptyString() {
        // given
        let mockUrlPath = "http://i.annihil.us/u/prod/marvel/i/mg/9/b0/4c7d666c0e58a"

        // when
        let urlString = sut.getFullImageURLString(with: mockUrlPath, of: nil)

        // then
        XCTAssertEqual(urlString, "")
    }

}
