import class BlinkOpenAPI.BlinkDefaultAPI
import struct BlinkOpenAPI.HomeScreenResponse

extension BlinkController {
    
    public typealias HomeScreenResponse = BlinkOpenAPI.HomeScreenResponse
    
    public func homeScreen() async throws -> HomeScreenResponse {
        try await BlinkDefaultAPI.homescreen(accountID: accountID)
    }
}
