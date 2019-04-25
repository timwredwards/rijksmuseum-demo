
import Foundation
import Utils

public protocol Dependencies: Utils.Dependencies {}

public extension Dependencies {
    func resolve() -> ArtService {
        return ArtServiceDefault(apiRequestFactory: resolve(),
                                 networkService: resolve(),
                                 jsonDecoderService: resolve())
    }
}

private extension Dependencies {
    func resolve() -> APIRequestFactory {
        return APIRequestFactoryDefault(apiConfig: resolve())
    }

    func resolve() -> APIConfig {
        return APIConfigLive()
    }

    func resolve() -> JSONDecoder {
        return JSONDecoder()
    }
}
