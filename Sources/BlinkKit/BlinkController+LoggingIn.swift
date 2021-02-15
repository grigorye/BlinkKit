import BlinkOpenAPI
import Foundation
import GETracing

#if os(Linux)
    import OpenCombine
#else
    import Combine
#endif

extension BlinkController {
    
    public struct LoggedIn: Codable {
        var accountID: Int
    }
    
    func loggedIn() -> AnyPublisher<LoggedIn, Error> {
        authenticated()
            .map { authenticatedAccount in
                LoggedIn(
                    accountID: authenticatedAccount.accountID
                )
            }
            .eraseToAnyPublisher()
    }
    
    func authenticated() -> AnyPublisher<AuthenticatedAccount, Error> {
        authenticationTokenStorage
            .load
            .flatMap { loaded -> AnyPublisher<AuthenticatedAccount, Error> in
                if let loaded = loaded {
                    return Result<AuthenticatedAccount, Error>.Publisher(loaded).eraseToAnyPublisher()
                } else {
                    return newlyLoggedInSaved()
                }
            }
            .tryCatch { error -> AnyPublisher<AuthenticatedAccount, Error> in
                _ = x$(error)
                return newlyLoggedInSaved()
            }
            .filter { authenticatedAccount -> Bool in
                let tier = authenticatedAccount.tier
                let authenticationToken = authenticatedAccount.authenticationToken
                BlinkOpenAPIAPI.basePath = "https://rest-\(tier).immedia-semi.com"
                BlinkOpenAPIAPI.customHeaders = [
                    "TOKEN_AUTH": authenticationToken
                ]
                return true
            }
            .eraseToAnyPublisher()
    }
    
    func newlyLoggedInSaved() -> AnyPublisher<AuthenticatedAccount, Error> {
        newlyLoggedIn()
            .map { authenticatedAccount in
                try! authenticationTokenStorage.save(authenticatedAccount)
                return authenticatedAccount
            }
            .eraseToAnyPublisher()
    }
    
    private func newlyLoggedIn() -> AnyPublisher<AuthenticatedAccount, Error> {
        guard let password = password else {
            enum Error: Swift.Error {
                case needLoginButNoPasswordProvided
            }
            return Fail(error: Error.needLoginButNoPasswordProvided).eraseToAnyPublisher()
        }
        let request = LoginRequest(uniqueId: uniqueId, password: password, email: email, reauth: reauth)
        return
            BlinkDefaultAPI
            .login(loginRequest: request)
            .map { loginResponse in
                let authenticatedAccount = AuthenticatedAccount(
                    accountID: loginResponse.account.id,
                    clientID: loginResponse.client.id,
                    authenticationToken: loginResponse.authtoken.authtoken,
                    tier: loginResponse.region.tier
                )
                return authenticatedAccount
            }
            .eraseToAnyPublisher()
    }
}
