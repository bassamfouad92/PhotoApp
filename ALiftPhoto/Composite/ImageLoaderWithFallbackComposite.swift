//  Created on 09/03/2022.

import Foundation

class ImageLoaderWithFallbackComposite: ImageLoader {
    
    let remote: ImageLoader
    let local: ImageCacheLoader

    init(remote: ImageLoader, local: ImageCacheLoader) {
        self.remote = remote
        self.local = local
    }
    
    //when failed to load date from remote api load from local
    func load(completion: @escaping (Result) -> Void) {
        remote.load(completion: { [weak self] result in
            switch result {
             case let .success(images):
                self?.local.save(items: images, completion: {_ in })
                completion(.success(images))
             case .failed(_): break
                self?.local.load(completion: completion)
             }
        })
    }
    
}
