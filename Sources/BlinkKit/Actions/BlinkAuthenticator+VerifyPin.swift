import Foundation

import class BlinkOpenAPI.BlinkDefaultAPI
import struct BlinkOpenAPI.VerifyPinRequest
import struct BlinkOpenAPI.VerifyPinResponse

extension BlinkAuthenticator {
    
    public typealias VerifyPinResponse = BlinkOpenAPI.VerifyPinResponse
    
    public func verifyPin(pin: String) async throws -> VerifyPinResponse {
        let authenticatedAccount = try await authenticated()
        return try await BlinkDefaultAPI.verifyPin(
            accountID: authenticatedAccount.accountID,
            clientID: authenticatedAccount.clientID,
            verifyPinRequest: VerifyPinRequest(pin: pin)
        )
    }
}
