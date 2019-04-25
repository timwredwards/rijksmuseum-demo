
import Foundation

public protocol Dependencies {}

public extension Dependencies {
    func resolve() -> NetworkService {
        return NetworkServiceDefault(networkSession: resolve(),
                                     networkResponseValidator: resolve())
    }
}

private extension Dependencies {
    func resolve() -> NetworkSession {
        return URLSession.shared
    }

    func resolve() -> NetworkResponseValidatorDefault {
        return NetworkResponseValidatorDefault()
    }
}
