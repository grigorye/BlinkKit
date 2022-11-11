import BlinkOpenAPI
import Foundation

extension BlinkController {
    
    public func getVideo(media: String) async throws -> VideoResponse {
        let url = try await BlinkDefaultAPI.getVideo(media: media)
        return VideoResponse(url: url)
    }
}

public struct VideoResponse: Codable {
    public let url: URL
}
