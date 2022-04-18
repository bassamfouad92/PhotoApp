//  Created on 08/03/2022.

import Foundation

enum ImageStoreResult {
    case success
    case failed
}

enum ImageStoreRetreiveResult {
    case success([ImageItem])
    case failed
}

protocol ImageStore {
    func deleteCachedImage(compeletion: @escaping (ImageStoreResult) -> Void)
    func insert(_ items: [ImageItem])
    func retrieve(completion: @escaping (ImageStoreRetreiveResult) -> Void)
}

