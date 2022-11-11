import BlinkOpenAPI
import Foundation
import GETracing

#if os(Linux)
    import FoundationNetworking
#endif

class CustomURLSessionRequestBuilderX<T>: URLSessionRequestBuilder<T> {
    
    required init(method: String, URLString: String, parameters: [String: Any]?, headers: [String: String] = [:], requiresAuthentication: Bool) {
        super.init(method: method, URLString: URLString, parameters: parameters, headers: headers, requiresAuthentication: requiresAuthentication)
        taskDidReceiveChallenge = { (_, _, _) in
            (.performDefaultHandling, nil)
        }
    }
}

class CustomURLSessionDecodableRequestBuilderX<T>: URLSessionDecodableRequestBuilder<T> where T: Decodable {
    
    required init(method: String, URLString: String, parameters: [String: Any]?, headers: [String: String] = [:], requiresAuthentication: Bool) {
        super.init(method: method, URLString: URLString, parameters: parameters, headers: headers, requiresAuthentication: requiresAuthentication)
        taskDidReceiveChallenge = { (_, _, _) in
            (.performDefaultHandling, nil)
        }
    }
}
