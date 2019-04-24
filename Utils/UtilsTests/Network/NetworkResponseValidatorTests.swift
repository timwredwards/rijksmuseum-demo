
import XCTest
@testable import Utils

class NetworkResponseValidatorDefaultTests: XCTestCase {

    var sut: NetworkResponseValidatorDefault!
    var response: NetworkResponseMock!

    override func setUp() {
        super.setUp()
        sut = .init()
        response = .init(data: Seeds.data, urlResponse: Seeds.urlResponse, error: nil)
    }
}

extension NetworkResponseValidatorDefaultTests {
    func test_validateResponse(){
        XCTAssertNoThrow(try sut.validateResponseAndUnwrapData(response))
    }

    func test_validateResponse_noData(){
        // given
        response.data = nil
        // then
        XCTAssertThrowsError(try sut.validateResponseAndUnwrapData(response))
    }

    func test_validateResponse_noInternalURLResponse(){
        // given
        response.urlResponse = nil
        // then
        XCTAssertThrowsError(try sut.validateResponseAndUnwrapData(response))
    }

    func test_validateResponse_badStatusCode(){
        // given
        response.urlResponse = HTTPURLResponse(url: Seeds.url,
                                               statusCode: 404,
                                               httpVersion: nil,
                                               headerFields: nil)
        // then
        XCTAssertThrowsError(try sut.validateResponseAndUnwrapData(response))
    }

    func test_validateResponse_error(){
        // given
        response.error = Seeds.error
        // then
        XCTAssertThrowsError(try sut.validateResponseAndUnwrapData(response))
    }
}

