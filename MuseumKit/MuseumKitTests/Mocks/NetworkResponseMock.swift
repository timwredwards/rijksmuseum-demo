import Foundation
import TestKit
@testable import TimKit

struct NetworkResponseMock: NetworkResponse {
    var data: Data? = Seeds.data
    var urlResponse: URLResponse? = Seeds.urlResponse
    var error: Error?
}
