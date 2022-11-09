import BlinkOpenAPI

public struct BlinkAuthenticator {
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
