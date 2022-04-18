//  Created on 08/03/2022.

import XCTest
@testable import ALiftPhoto

class Helpers {
   
    // MARK: - Helpers
    
    public static func makeRequest(url: URL = URL(string: "https://pixabay.com/api/")!) -> (request: RemoteImageLoader, client: MockHTTPClient) {
        let client = MockHTTPClient()
        let remote = RemoteImageLoader(url: url, client: client)
        return (remote, client)
    }
    
    public static func makeMockItem(id: Int, type: Type, largeUrl: String, imageUrl: String) -> (item: ImageItem, json: [String: Any]) {
        
        let imageItem = ImageItem(id: id, type: type, largeImageURL: largeUrl, imageURL: imageUrl)
        
        let json = ["id" : id,
                    "type": type,
                    "largeImageURL": largeUrl,
                    "previewURL": imageUrl
        ] as [String : Any]
        
        return (imageItem, json)
    }
    
    public class MockHTTPClient: HTTPClient {
        
        func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void) {
            requestedURL = url
        }
        
        var requestedURL: URL?
    }
}
