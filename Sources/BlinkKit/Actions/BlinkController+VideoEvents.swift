import BlinkOpenAPI
import Combine
import Foundation.NSDate

extension BlinkController {
    
    public func videoEvents(page: Int, since sinceDate: Date) -> AnyPublisher<VideoEvents, Error> {
        loggedIn()
            .flatMap { loginResponse in
                BlinkDefaultAPI.getVideoEvents(
                    accountID: loginResponse.accountID, since: sinceDate, page: page
                )
            }
            .eraseToAnyPublisher()
    }
}

public typealias VideoEvents = BlinkOpenAPI.VideoEvents
public typealias Media = BlinkOpenAPI.Media
