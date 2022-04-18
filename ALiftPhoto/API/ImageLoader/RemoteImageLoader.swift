//  Created on 08/03/2022.

import Foundation

class RemoteImageLoader: ImageLoader {
    
    let client: HTTPClient
    let url: URL
    
    init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    func load(completion: @escaping (Result) -> Void) {
        client.get(from: url, completion: {[weak self] result in
            guard self != nil else { return }
            
            switch result {
            case let .success(data, response):
                if let items = try? ImageItemMapper.map(data, response) {
                    completion(.success(items))
                } else {
                    completion(.failed(.invalidData))
                }
             
            case .failed:
                completion(.failed(.connectivity))
            }
        })
    }
}

