import Foundation

import class BlinkOpenAPI.BlinkDefaultAPI
import struct BlinkOpenAPI.Media
import struct BlinkOpenAPI.VideoEvents

extension BlinkController {
    
    public func videoEvents(page: Int, since sinceDate: Date) async throws -> VideoEvents {
        try await BlinkDefaultAPI.getVideoEvents(accountID: accountID, since: sinceDate, page: page)
    }
}

public typealias VideoEvents = BlinkOpenAPI.VideoEvents
public typealias Media = BlinkOpenAPI.Media
