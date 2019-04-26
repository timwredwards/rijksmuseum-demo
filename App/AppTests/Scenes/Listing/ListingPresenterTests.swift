
import XCTest
import UtilsTestTools
@testable import App

class ListingPresenterTests: XCTestCase {

    var sut: ListingPresenter!

    var displaySpy: ListingDisplaySpy!

    var artMock: ArtMock!

    override func setUp() {
        super.setUp()
        artMock = .init()
        displaySpy = .init()
        sut = .init()
        sut = .init(display: displaySpy)
    }
}

extension ListingPresenterTests {

    func test_didLoadArt(){
        sut.presentResponse(.didLoadArt(artMock))
        XCTAssertEqual([.imageUrl(artMock.imageUrl)], displaySpy.displayViewModelArgs)
    }
}