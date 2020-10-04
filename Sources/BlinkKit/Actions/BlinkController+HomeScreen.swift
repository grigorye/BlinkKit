import BlinkOpenAPI

#if os(Linux)
    import OpenCombine
#else
    import Combine
#endif

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
