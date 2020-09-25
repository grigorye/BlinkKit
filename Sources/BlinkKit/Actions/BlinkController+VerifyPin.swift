import BlinkOpenAPI
import Combine
import Foundation.NSURL
import GETracing

extension BlinkController {
    
    public typealias VerifyPinResponse = BlinkOpenAPI.VerifyPinResponse
    
    public func verifyPin(pin: String) -> AnyPublisher<VerifyPinResponse, Error> {
        let request = LoginRequest(uniqueId: uniqueId, password: password, email: email)
        return
            BlinkDefaultAPI
            .login(loginRequest: request)
            .flatMap { loginResponse in
                BlinkDefaultAPI.verifyPin(
                    accountID: loginResponse.account.id,
                    clientID: loginResponse.client.id,
                    verifyPinRequest: VerifyPinRequest(pin: pin)
                )
            }
            .eraseToAnyPublisher()
    }
}
