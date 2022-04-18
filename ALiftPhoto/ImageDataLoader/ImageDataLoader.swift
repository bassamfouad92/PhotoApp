//  Created on 09/03/2022.

import Foundation

protocol ImageDataLoader {
    func loadImageData(from url: URL, completion: @escaping (ImageDataResult) -> Void)
}

class ImageDataLoaderImp: ImageDataLoader {
    
    let session: HTTPSession
    
    init(session: HTTPSession) {
        self.session = session
    }
    
    func loadImageData(from url: URL, completion: @escaping (ImageDataResult) -> Void) {
        self.session.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else {
                    completion(.failed(.invalidData))
                    return
                }
                completion(.success(data))
        }.resume()
    }
}
