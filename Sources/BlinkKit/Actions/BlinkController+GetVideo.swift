import BlinkOpenAPI
import Combine
import Foundation.NSURL
import GETracing

extension BlinkController {
    
    public struct VideoResponse: Codable {
        let url: URL
    }
    
    public func getVideo(mediaID: Int) -> AnyPublisher<VideoResponse, Error> {
        loggedIn()
            .flatMap { loginResponse in
                BlinkDefaultAPI.getVideoEvents(accountID: loginResponse.accountID, since: .distantPast, page: 0)
            }
            .flatMap { (videoEvents: BlinkOpenAPI.VideoEvents) -> AnyPublisher<URL, Error> in
                _ = x$(videoEvents)
                guard let media = videoEvents.media.first(where: { $0.id == mediaID }) else {
                    enum Error: Swift.Error {
                        case mediaNotFound(id: Int)
                    }
                    return Fail(error: Error.mediaNotFound(id: mediaID)).eraseToAnyPublisher()
                }
                return BlinkDefaultAPI.getVideo(media: x$(media.media))
            }
            .map { url in
                VideoResponse(url: x$(url))
            }
            .eraseToAnyPublisher()
    }
}
