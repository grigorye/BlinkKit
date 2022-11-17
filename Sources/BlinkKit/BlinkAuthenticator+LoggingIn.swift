import BlinkOpenAPI
import Foundation

public struct AuthenticatedAccount: Codable {
    public var accountID: Int
    var clientID: Int
    var authenticationToken: String
    var tier: String
}

public protocol AuthenticationTokenStorage {
    func save(_ authenticatedAccount: AuthenticatedAccount) throws
    func load() async throws -> AuthenticatedAccount?
}

extension BlinkAuthenticator {
    
    public func loggedIn() async throws -> Int {
        let authenticatedAccount = try await authenticated()
        return authenticatedAccount.accountID
    }
    
    func authenticated() async throws -> AuthenticatedAccount {
        let authenticatedAccount = try await authenticatedAccount()
        
        BlinkOpenAPIAPI.basePath = "https://rest-\(authenticatedAccount.tier).immedia-semi.com"
        BlinkOpenAPIAPI.customHeaders = [
            "TOKEN_AUTH": authenticatedAccount.authenticationToken
        ]
        
        return authenticatedAccount
    }
    
    func authenticatedAccount() async throws -> AuthenticatedAccount {
        do {
            if let loadedAccount = try await authenticationTokenStorage.load() {
                return loadedAccount
            }
        } catch {
            _ = x$(error)
            return try await newlyLoggedInSaved()
        }
        return try await newlyLoggedInSaved()
    }
    
    func newlyLoggedInSaved() async throws -> AuthenticatedAccount {
        let authenticatedAccount = try await newlyLoggedIn()
        try! authenticationTokenStorage.save(authenticatedAccount)
        return authenticatedAccount
    }
    
    private func newlyLoggedIn() async throws -> AuthenticatedAccount {
        guard let password = password else {
            enum Error: Swift.Error {
                case needLoginButNoPasswordProvided
            }
            throw Error.needLoginButNoPasswordProvided
        }
        let request = LoginRequest(uniqueId: uniqueId, password: password, email: email, reauth: reauth)
        let loginResponse = try await BlinkDefaultAPI.login(loginRequest: request)
        
        let authenticatedAccount = AuthenticatedAccount(
            accountID: loginResponse.account.accountId,
            clientID: loginResponse.account.clientId,
            authenticationToken: loginResponse.auth.token,
            tier: loginResponse.account.tier
        )
        return authenticatedAccount
    }
}
