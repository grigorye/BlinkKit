import BlinkOpenAPI
import Combine
import Foundation.NSURL
import GETracing

extension BlinkController {
    
    public struct VideoResponse: Codable {
        let url: URL
    }
    
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
