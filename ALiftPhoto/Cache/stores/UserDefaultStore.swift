//  Created on 09/03/2022.

import Foundation

class UserDefaultStore: ImageStore {
    
    private let userDefaults = UserDefaults.standard
    private let key = "gallery"
    
    //for unit test
    public var deletedCachedImagesCount = 0
    public var insertedCacheImagesCount = 0
    
    func deleteCachedImage(compeletion: @escaping (ImageStoreResult) -> Void) {
        userDefaults.removeObject(forKey: key)
    }
    
    func insert(_ items: [ImageItem]) {
        let galleryData = try! JSONEncoder().encode(items)
        userDefaults.set(galleryData, forKey: key)
    }
    
    func retrieve(completion: @escaping (ImageStoreRetreiveResult) -> Void) {
        if let galleryData = userDefaults.data(forKey: key) {
            let galleryImages = try! JSONDecoder().decode([ImageItem].self, from: galleryData)
            completion(.success(galleryImages))
        } else {
            completion(.failed)
        }
    }
}
