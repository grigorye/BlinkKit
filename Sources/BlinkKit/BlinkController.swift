import BlinkOpenAPI
import Combine
import Foundation.NSURL
import GETracing

class URLSessionRequestBuilderFactory: RequestBuilderFactory {
    func getNonDecodableBuilder<T>() -> RequestBuilder<T>.Type {
        URLSessionRequestBuilder<T>.self
    }
    
    func getBuilder<T: Decodable>() -> RequestBuilder<T>.Type {
        if case is URL.Type = T.self {
            return URLSessionRequestBuilder<T>.self
        }
        return URLSessionDecodableRequestBuilder<T>.self
    }
}

public struct AuthenticatedAccount: Codable {
    var accountID: Int
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
    public let password: String
    public let authenticationTokenStorage: AuthenticationTokenStorage
    
    public init(email: String, password: String, authenticationTokenStorage: AuthenticationTokenStorage) {
        self.email = email
        self.password = password
        self.authenticationTokenStorage = authenticationTokenStorage
        
        BlinkOpenAPIAPI.requestBuilderFactory = URLSessionRequestBuilderFactory()
    }
}
