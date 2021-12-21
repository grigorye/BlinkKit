import Foundation
import GETracing

import class BlinkOpenAPI.BlinkDefaultAPI
import struct BlinkOpenAPI.HomeScreenResponse

#if os(Linux)
    import OpenCombine
#else
    import Combine
#endif

extension BlinkController {
    
    public struct DownloadCameraThumbnailResponse: Codable {
        var url: URL
    }
    
    public func getCameraThumbnail(networkID: Int, cameraID: Int) -> AnyPublisher<DownloadCameraThumbnailResponse, Error> {
        loggedIn()
            .flatMap { authenticatedAccount in
                BlinkDefaultAPI.homescreen(accountID: authenticatedAccount.accountID)
            }
            .flatMap {
                (homeScreenResponse: BlinkOpenAPI.HomeScreenResponse) -> AnyPublisher<URL, Error> in
                guard
                    let camera = homeScreenResponse.cameras.first(where: {
                        $0.id == cameraID && $0.networkId == networkID
                    })
                else {
                    enum Error: Swift.Error {
                        case cameraNotFound(cameraID: Int, networkID: Int)
                    }
                    return Fail(error: Error.cameraNotFound(cameraID: cameraID, networkID: networkID))
                        .eraseToAnyPublisher()
                }
                return BlinkDefaultAPI.getThumbnail(media: camera.thumbnail)
            }
            .map { url in
                DownloadCameraThumbnailResponse(url: x$(url))
            }
            .eraseToAnyPublisher()
    }
}
