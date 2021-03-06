import Foundation
@testable import MuseumCore
import Utils

class JSONDecoderServiceSpy: JSONDecoderService {
    var decodeArgs = [Data]()

    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T: Decodable {
        decodeArgs.append(data)
        return try JSONDecoder().decode(type, from: data)
    }
}
