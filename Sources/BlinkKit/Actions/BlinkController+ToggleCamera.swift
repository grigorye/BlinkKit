import Foundation

import class BlinkOpenAPI.BlinkDefaultAPI
import struct BlinkOpenAPI.InitialCommandResponse

extension BlinkController {
    
    public func enableCamera(networkID: Int, cameraID: Int) async throws -> InitialCommandResponse {
        try await BlinkDefaultAPI.enableCamera(networkID: networkID, cameraID: cameraID)
    }
    
    public func disableCamera(networkID: Int, cameraID: Int) async throws -> InitialCommandResponse {
        try await BlinkDefaultAPI.disableCamera(networkID: networkID, cameraID: cameraID)
    }
    
    public typealias InitialCommandResponse = BlinkOpenAPI.InitialCommandResponse
    
    public func toggleCamera(networkID: Int, cameraID: Int, on: Bool) async throws -> InitialCommandResponse {
        if on == true {
            return try await enableCamera(networkID: networkID, cameraID: cameraID)
        } else {
            return try await disableCamera(networkID: networkID, cameraID: cameraID)
        }
    }
}
