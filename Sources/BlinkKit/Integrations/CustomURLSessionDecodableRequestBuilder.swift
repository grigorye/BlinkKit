import BlinkOpenAPI
import Foundation

#if os(Linux)
    import FoundationNetworking
#endif

class CustomURLSessionDecodableRequestBuilder<T>: URLSessionDecodableRequestBuilder<T> where T: Decodable {
    
    required init(method: String, URLString: String, parameters: [String: Any]?, headers: [String: String] = [:], requiresAuthentication: Bool) {
        super.init(method: method, URLString: URLString, parameters: parameters, headers: headers, requiresAuthentication: requiresAuthentication)
        taskDidReceiveChallenge = { (_, _, _) in
            (.performDefaultHandling, nil)
        }
    }
}
