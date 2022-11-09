extension BlinkAuthenticator {
    
    public func login() async throws -> AuthenticatedAccount {
        try await newlyLoggedInSaved()
    }
}
