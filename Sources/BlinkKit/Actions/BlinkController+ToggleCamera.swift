import BlinkOpenAPI
import Foundation

#if os(Linux)
    import OpenCombine
#else
    import Combine
#endif

extension BlinkController {
    
    public func enableCamera(networkID: Int, cameraID: Int) -> AnyPublisher<InitialCommandResponse, Error> {
        loggedIn()
            .flatMap { _ in
                BlinkDefaultAPI.enableCamera(networkID: networkID, cameraID: cameraID)
            }
            .eraseToAnyPublisher()
    }
    
    public func disableCamera(networkID: Int, cameraID: Int) -> AnyPublisher<InitialCommandResponse, Error> {
        loggedIn()
            .flatMap { _ in
                BlinkDefaultAPI.disableCamera(networkID: networkID, cameraID: cameraID)
            }
            .eraseToAnyPublisher()
    }
    
    public typealias InitialCommandResponse = BlinkOpenAPI.InitialCommandResponse
    
    public func toggleCamera(networkID: Int, cameraID: Int, on: Bool) -> AnyPublisher<InitialCommandResponse, Error> {
        if on == true {
            return enableCamera(networkID: networkID, cameraID: cameraID)
        } else {
            return disableCamera(networkID: networkID, cameraID: cameraID)
        }
    }
}
