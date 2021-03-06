import BlinkOpenAPI
import Foundation

#if os(Linux)
    import OpenCombine
#else
    import Combine
#endif

extension BlinkController {
    
    public typealias VerifyPinResponse = BlinkOpenAPI.VerifyPinResponse
    
    public func verifyPin(pin: String) -> AnyPublisher<VerifyPinResponse, Error> {
        
        authenticated()
            .flatMap { authenticatedAccount in
                BlinkDefaultAPI.verifyPin(
                    accountID: authenticatedAccount.accountID,
                    clientID: authenticatedAccount.clientID,
                    verifyPinRequest: VerifyPinRequest(pin: pin)
                )
            }
            .eraseToAnyPublisher()
    }
}
