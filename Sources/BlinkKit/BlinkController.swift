import BlinkOpenAPI
import Foundation

#if os(Linux)
    import OpenCombine
#else
    import Combine
#endif

public struct AuthenticatedAccount: Codable {
    var accountID: Int
    var clientID: Int
    var authenticationToken: String
    var tier: String
}

public protocol AuthenticationTokenStorage {
    func save(_ authenticatedAccount: AuthenticatedAccount) throws
    var load: AnyPublisher<AuthenticatedAccount?, Error> { get }
}

public struct BlinkController {
    public let uniqueId = "6437737B-41DD-4810-87BB-3DAB28C3C3FE"
    
    public let email: String
    public let password: String?
    public let reauth: Bool
    public let authenticationTokenStorage: AuthenticationTokenStorage
    
    public init(email: String, password: String?, reauth: Bool, authenticationTokenStorage: AuthenticationTokenStorage) {
        self.email = email
        self.password = password
        self.reauth = reauth
        self.authenticationTokenStorage = authenticationTokenStorage
        
        BlinkOpenAPIAPI.requestBuilderFactory = CustomURLSessionRequestBuilderFactory()
    }
}
