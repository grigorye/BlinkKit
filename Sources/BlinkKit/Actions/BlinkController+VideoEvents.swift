import BlinkOpenAPI
import Combine
import Foundation.NSDate

extension BlinkController {
    
    public typealias VideoEventsResponse = BlinkOpenAPI.VideoEvents
    
    public func videoEvents(page: Int, since sinceDate: Date) -> AnyPublisher<VideoEventsResponse, Error> {
        loggedIn()
            .flatMap { loginResponse in
                BlinkDefaultAPI.getVideoEvents(
                    accountID: loginResponse.accountID, since: sinceDate, page: page
                )
            }
            .eraseToAnyPublisher()
    }
}
