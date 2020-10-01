import BlinkOpenAPI
import Combine
import Foundation.NSURL
import GETracing

extension BlinkController {
    
    public func getVideo(media: String) -> AnyPublisher<VideoResponse, Error> {
        loggedIn()
            .flatMap { _ in
                BlinkDefaultAPI.getVideo(media: media)
            }
            .map { url in
                VideoResponse(url: url)
            }
            .eraseToAnyPublisher()
    }
}

public struct VideoResponse: Codable {
    public let url: URL
}
