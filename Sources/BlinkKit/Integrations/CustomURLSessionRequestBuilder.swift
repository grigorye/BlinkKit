import BlinkOpenAPI
import Foundation
import GETracing

#if os(Linux)
    import FoundationNetworking
#endif

class CustomURLSessionRequestBuilder<T>: URLSessionRequestBuilder<T> {
    
    required public init(method: String, URLString: String, parameters: [String: Any]?, isBody: Bool, headers: [String: String] = [:]) {
        super.init(method: method, URLString: URLString, parameters: parameters, isBody: isBody, headers: headers)
        taskDidReceiveChallenge = { (_, _, _) in
            (.performDefaultHandling, nil)
        }
    }
}
