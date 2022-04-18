//  Created on 08/03/2022.

import Foundation

class LocalImageLoader: ImageCacheLoader {
    
    let store: ImageStore
    private var queue = DispatchQueue(label: "local_image_loader", qos: .userInitiated)
    
    init(store: ImageStore) {
        self.store = store
    }
    
    func save(items: [ImageItem], completion: @escaping (Error) -> Void) {
        queue.async {
            self.store.deleteCachedImage(compeletion: {[weak self] result in
                guard let self = self else { return }
                switch result {
                   case .success:
                    self.store.insert(items)
                   case .failed:
                    completion(.noData)
                }
            })
        }
    }
    
    func load(completion: @escaping (Result) -> Void) {
        queue.async {
            self.store.retrieve(completion: { result in
                switch result {
                case let .success(items):
                  completion(.success(items))
                case .failed:
                  completion(.failed(.noData))
                }
            })
        }
    }
}
