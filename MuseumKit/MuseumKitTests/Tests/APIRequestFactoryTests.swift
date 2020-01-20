import XCTest
import TestKit
import TimKit
@testable import MuseumKit

class APIRequestFactoryTests: XCTestCase {

    var sut: APIRequestFactoryDefault!

    var apiRequestTemplatesMock: APIRequestTemplatesMock!

    var apiQueryStringKeys: APIQueryStringKeys!

    override func setUp() {
        super.setUp()

        apiRequestTemplatesMock = APIRequestTemplatesMock()

        apiQueryStringKeys = APIQueryStringKeysMock()

        sut = APIRequestFactoryDefault(apiRequestTemplates: apiRequestTemplatesMock,
                                       apiQueryStringKeys: apiQueryStringKeys)
    }
}

extension APIRequestFactoryTests {

    func test_constructAPIRequest() {
        // given
        let searchTerm = Seeds.string
        // when
        let apiRequest = sut.constructAPIRequest(fromOperation: .search(term: searchTerm))
        // then
        XCTAssertTrue(apiRequest.queryItems.values.contains(searchTerm))
    }
}
