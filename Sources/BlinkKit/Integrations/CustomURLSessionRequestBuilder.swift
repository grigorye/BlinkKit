import BlinkOpenAPI
import Foundation
import GETracing

#if os(Linux)
    import FoundationNetworking
#endif

class CustomURLSessionRequestBuilder<T>: URLSessionRequestBuilder<T> {
    
    required init(method: String, URLString: String, parameters: [String: Any]?, headers: [String: String] = [:]) {
        super.init(method: method, URLString: URLString, parameters: parameters, headers: headers)
        taskDidReceiveChallenge = { (_, _, _) in
            (.performDefaultHandling, nil)
        }
    }
}
