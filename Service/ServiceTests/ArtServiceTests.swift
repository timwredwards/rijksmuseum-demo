
import XCTest
import Utils
@testable import Service

class ArtServiceNetworkTests: XCTestCase {
    var sut: ArtServiceDefault!
//    var apiServiceMock: APIServiceMock!
    override func setUp() {
        super.setUp()
//        apiServiceMock = .init()
//        sut = .init(apiService: apiServiceMock)
    }
}

extension ArtServiceNetworkTests {
//    func test_fetchArt(){
//        // when
//        sut.fetchArt(completion: {_ in})
//    }
//
//    func test_fetchArt_apiServiceMock_called(){
//        // when
//        sut.fetchArt(completion: {_ in})
//        // then
//        XCTAssert(apiServiceMock.performGetRequestArgs == 1,
//                  "Should forward to APIService")
//    }
//
//    func test_fetchArt_apiServiceMock_endpoint(){
//        // given
//        let correctEndpoint = ModelMock.Network.Endpoint.collection.rawValue
//        // when
//        sut.fetchArt(completion: {_ in})
//        // then
//        XCTAssert(apiServiceMock.lastRequest?.path == correctEndpoint,
//                  "Should call APIService with correct endpoint")
//    }
//
//    func test_fetchArt_apiServiceMock_parameters(){
//        // given
//        let queryItems = [URLQueryItem(name: "ps",
//                                       value: "100"),
//                          URLQueryItem(name: "imgonly",
//                                       value: "true"),
//                          URLQueryItem(name: "s",
//                                       value: "relevance")]
//        // when
//        sut.fetchArt(completion: {_ in})
//        // then
//        XCTAssert(apiServiceMock.lastRequest?.queryItems == queryItems,
//                  "Should call APIService with correct parameters")
//    }
//
//    func test_fetchArt_callback(){
//        // given
//        let exp = XCTestExpectation(description: "Should callback")
//        // when
//        sut.fetchArt(completion: {_ in
//            // then
//            exp.fulfill()
//        })
//        wait(for: [exp], timeout: 1)
//    }
//
//    func test_fetchArt_callback_success(){
//        // given
//        let exp = XCTestExpectation(description: "Should succeed")
//        // when
//        sut.fetchArt(completion: {result in
//            // then
//            if case .success = result {
//                exp.fulfill()
//            }
//        })
//        wait(for: [exp], timeout: 1)
//    }
//
//    func test_fetchArt_callback_arts(){
//        // given
//        let id = "EFED716C-1180-485A-A511-63F65F1D63F1"
//        let exp = XCTestExpectation(description: "Should succeed with result")
//        // when
//        sut.fetchArt(completion: {result in
//            // then
//            if case .success(let arts) = result {
//                XCTAssert(arts.count == 1)
//                XCTAssert(arts.first!.id == id)
//                exp.fulfill()
//            }
//        })
//        wait(for: [exp], timeout: 1)
//    }
//
//    func test_fetchArt_callback_failure(){
//        // given
//        let exp = XCTestExpectation(description: "Should fail when APIService fails")
//        apiServiceMock.shouldReturnSuccess = false
//        // when
//        sut.fetchArt(completion: {result in
//            // then
//            if case .failure(_) = result {
//                exp.fulfill()
//            }
//        })
//        wait(for: [exp], timeout: 1)
//    }
//
//    func test_fetchArt_callback_jsonError(){
//        // given
//        let exp = XCTestExpectation(description: "Should fail when no data")
//        apiServiceMock.shouldReturnData = false
//        // when
//        sut.fetchArt(completion: {result in
//            // then
//            if case .failure(_) = result {
//                exp.fulfill()
//            }
//        })
//        wait(for: [exp], timeout: 1)
//    }
}