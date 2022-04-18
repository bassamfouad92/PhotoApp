//  Created on 08/03/2022.

import Foundation

class URLSessionHTTPClient: HTTPClient {
    
    private let session: HTTPSession
    
    public init(session: HTTPSession) {
        self.session = session
    }
    
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void) {
         session.dataTask(with: url) { data, response, error in
            if error != nil {
                completion(.failed(.invalidData))
            } else if let data = data, let response = response as? HTTPURLResponse {
                completion(.success(data, response))
            } else {
                completion(.failed(.connectivity))
            }
        }.resume()
    }
}
