import BlinkOpenAPI
import Combine
import Foundation.NSURL
import GETracing

extension BlinkController {
    
    public struct LoggedIn: Codable {
        var accountID: Int
    }
    
    func loggedIn() -> AnyPublisher<LoggedIn, Error> {
        authenticated()
            .filter { authenticatedAccount -> Bool in
                _ = x$(authenticatedAccount)
                let tier = authenticatedAccount.tier
                let authenticationToken = authenticatedAccount.authenticationToken
                BlinkOpenAPIAPI.basePath = "https://rest-\(tier).immedia-semi.com"
                BlinkOpenAPIAPI.customHeaders = [
                    "TOKEN_AUTH": authenticationToken
                ]
                return true
            }
            .map { authenticatedAccount in
                LoggedIn(
                    accountID: authenticatedAccount.accountID
                )
            }
            .eraseToAnyPublisher()
    }
    
    private func authenticated() -> AnyPublisher<AuthenticatedAccount, Error> {
        authenticationTokenStorage
            .load
            .flatMap { loaded -> AnyPublisher<AuthenticatedAccount, Error> in
                if let loaded = loaded {
                    return Result.Publisher(loaded).eraseToAnyPublisher()
                } else {
                    return newlyLoggedInSaved()
                }
            }
            .tryCatch { error -> AnyPublisher<AuthenticatedAccount, Error> in
                _ = x$(error)
                return newlyLoggedInSaved()
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
        let request = LoginRequest(uniqueId: uniqueId, password: password, email: email)
        return
            BlinkDefaultAPI
            .login(loginRequest: request)
            .map { loginResponse in
                let authenticatedAccount = AuthenticatedAccount(
                    accountID: loginResponse.account.id,
                    authenticationToken: loginResponse.authtoken.authtoken,
                    tier: loginResponse.region.tier
                )
                return authenticatedAccount
            }
            .eraseToAnyPublisher()
    }
}
