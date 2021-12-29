import BlinkOpenAPI
import Foundation

class CustomURLSessionRequestBuilderFactory: RequestBuilderFactory {
    
    func getNonDecodableBuilder<T>() -> RequestBuilder<T>.Type {
        CustomURLSessionRequestBuilderX<T>.self
    }
    
    func getBuilder<T: Decodable>() -> RequestBuilder<T>.Type {
        if T.self is URL.Type {
            return CustomURLSessionDecodableRequestBuilderX<T>.self
        }
        return CustomURLSessionDecodableRequestBuilder<T>.self
    }
}
