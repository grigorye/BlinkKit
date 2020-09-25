import BlinkOpenAPI
import Combine

extension BlinkController {
    
    public typealias HomeScreenResponse = BlinkOpenAPI.HomeScreenResponse
    
    public func homeScreen() -> AnyPublisher<HomeScreenResponse, Error> {
        loggedIn()
            .flatMap { authenticatedAccount in
                BlinkDefaultAPI.homescreen(accountID: authenticatedAccount.accountID)
            }
            .eraseToAnyPublisher()
    }
}
