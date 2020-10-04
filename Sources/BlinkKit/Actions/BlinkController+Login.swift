#if os(Linux)
    import OpenCombine
#else
    import Combine
#endif

extension BlinkController {
    
    public func login() -> AnyPublisher<AuthenticatedAccount, Error> {
        newlyLoggedInSaved()
    }
}
