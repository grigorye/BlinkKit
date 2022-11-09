import Foundation
import GETracing

import class BlinkOpenAPI.BlinkDefaultAPI
import struct BlinkOpenAPI.HomeScreenResponse

extension BlinkController {
    
    public struct DownloadCameraThumbnailResponse: Codable {
        var url: URL?
    }
    
    public func getCameraThumbnail(networkID: Int, cameraID: Int) async throws -> DownloadCameraThumbnailResponse? {
        let homeScreenResponse = try await BlinkDefaultAPI.homescreen(accountID: accountID)
        
        guard
            let camera = homeScreenResponse.cameras.first(where: {
                $0.id == cameraID && $0.networkId == networkID
            })
        else {
            enum Error: Swift.Error {
                case cameraNotFound(cameraID: Int, networkID: Int)
            }
            throw Error.cameraNotFound(cameraID: cameraID, networkID: networkID)
        }
        guard let thumbnail = camera.thumbnail else {
            return nil
        }
        
        let thumbnailUrl = try await BlinkDefaultAPI.getThumbnail(media: thumbnail)
        
        return DownloadCameraThumbnailResponse(url: x$(thumbnailUrl))
    }
}
