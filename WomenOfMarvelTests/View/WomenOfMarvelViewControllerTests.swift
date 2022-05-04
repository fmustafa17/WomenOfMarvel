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

    var mockTitleLabel: UILabel!
    var mockDescriptionLabel: UILabel!
   
    override func setUp() {
        super.setUp()
        sut = WomenOfMarvelViewController()
        sut.viewModel = WomenOfMarvelViewModel()

        // Initialize the IBOutlets
        mockTitleLabel = UILabel()
        sut.comicBookTitle = mockTitleLabel

        mockDescriptionLabel = UILabel()
        sut.comicBookDescription = mockDescriptionLabel
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    /*
    func testLabelsHaveTheCorrectText() {
        // given
        let mockResults = Result(id: 1590, digitalID: 0, title: "Women of Marvel", issueNumber: 0, variantDescription: "", resultDescription: "", modified: "", isbn: "", upc: "", diamondCode: "", ean: "", issn: "", format: "", pageCount: 0, textObjects: [], resourceURI: "", urls: [], series: Series(resourceURI: "", name: ""), variants: [], collections: [], collectedIssues: [], dates: [], prices: [], thumbnail: Thumbnail(path: "", thumbnailExtension: ""), images: [], creators: Creators(available: 0, collectionURI: "", items: [], returned: 0), characters: Characters(available: 0, collectionURI: "", items: [], returned: 0), stories: Stories(available: 0, collectionURI: "", items: [], returned: 0), events: Characters(available: 0, collectionURI: "", items: [], returned: 0))

        let mockData = DataClass(offset: 0, limit: 0, total: 0, count: 0, results: [mockResults])

        sut.viewModel.comicDetails = WomenOfMarvel(code: 200, status: "OK", copyright: "", attributionText: "", attributionHTML: "", etag: "", data: mockData)

        // when
        sut.viewDidLoad()

        // then
        XCTAssertEqual(sut.comicBookTitle.text, "Women of Marvel")
    }
    */

}
