import BlinkOpenAPI
import Foundation.NSURL

class CustomURLSessionRequestBuilderFactory: RequestBuilderFactory {
    
    func getNonDecodableBuilder<T>() -> RequestBuilder<T>.Type {
        CustomURLSessionRequestBuilder<T>.self
    }
    
    func getBuilder<T: Decodable>() -> RequestBuilder<T>.Type {
        if T.self is URL.Type {
            return CustomURLSessionRequestBuilder<T>.self
        }
        return CustomURLSessionDecodableRequestBuilder<T>.self
    }
}
