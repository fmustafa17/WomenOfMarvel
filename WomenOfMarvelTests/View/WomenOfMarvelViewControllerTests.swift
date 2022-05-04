//
//  WomenOfMarvelViewControllerTests.swift
//  WomenOfMarvelTests
//
//  Created by fmustafa on 5/3/22.
//

import XCTest
@testable import WomenOfMarvel

class WomenOfMarvelViewControllerTests: XCTestCase {
    // sut stands for system under test
    var sut: WomenOfMarvelViewController!
   
    override func setUp() {
        super.setUp()
        sut = WomenOfMarvelViewController()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    

}
