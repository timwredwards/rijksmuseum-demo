
import XCTest
import TestTools
@testable import Kit

class ArtFactoryTests: XCTestCase {

    var sut: ArtFactoryDefault!
    
    var jsonDecoderServiceSpy: JSONDecoderServiceSpy!

    override func setUp() {
        super.setUp()
        jsonDecoderServiceSpy = .init()
        sut = .init(jsonDecoderService: jsonDecoderServiceSpy)
    }
}

extension ArtFactoryTests {
    func test_createArt() throws {
        let data = try XCTAssertUnwrapOptional(loadSampleFileData(withName: "collection.json"))
        XCTAssertNoThrow(try XCTAssertUnwrapOptional(sut.arts(fromJSONData: data)))
        XCTAssertEqual([data], jsonDecoderServiceSpy.decodeArgs)
    }

    func test_createArt_badData() throws {
        XCTAssertThrowsError(try sut.arts(fromJSONData: Seeds.data))
    }
}
