import Combine

extension BlinkController {
    
    public func login() -> AnyPublisher<AuthenticatedAccount, Error> {
        newlyLoggedInSaved()
    }
}
