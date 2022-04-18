//  Created on 08/03/2022.

import XCTest
@testable import ALiftPhoto


class LocalImageLoaderTests: XCTestCase {

    func test_delete_ImageStore() {
        let store = MockStore()
        XCTAssertEqual(store.deletedCachedImagesCount, 0)
        store.deleteCachedImage(compeletion: { _ in })
        XCTAssertEqual(store.deletedCachedImagesCount, 1)
    }
    
    func test_insert_ImageStore() {
        let store = MockStore()
        let imageItem = Helpers.makeMockItem(id: 1, type: .photo, largeUrl: "", imageUrl: "")
        XCTAssertEqual(store.insertedCacheImagesCount, 0)
        store.insert([imageItem.item])
        XCTAssertEqual(store.insertedCacheImagesCount, 1)
        XCTAssertEqual(store.deletedCachedImagesCount, 0)
    }
    
    func test_insert_retreive_UserDefaultStore() {
        let store = UserDefaultStore()
        let imageItem1 = Helpers.makeMockItem(id: 1, type: .photo, largeUrl: "https://pixabay.com/get/ed6a9364a9fd0a76647.jpg", imageUrl: "https://pixabay.com/get/ed6a9364a9fd0a76647.jpg")
        let imageItem2 = Helpers.makeMockItem(id: 2, type: .photo, largeUrl: "https://pixabay.com/get/ed6a9364a9fd0a76647.jpg", imageUrl: "https://pixabay.com/get/ed6a9364a9fd0a76647.jpg")
            store.insert([imageItem1.item, imageItem2.item])
            store.retrieve(completion: { result in
                switch result {
                   case let .success(items):
                    XCTAssertEqual(items.count, 2)
                case .failed:
                    break
                }
            })
    }
    
    func test_delete_retreive_UserDefaultStore() {
        let store = UserDefaultStore()
        let imageItem1 = Helpers.makeMockItem(id: 1, type: .photo, largeUrl: "https://pixabay.com/get/ed6a9364a9fd0a76647.jpg", imageUrl: "https://pixabay.com/get/ed6a9364a9fd0a76647.jpg")
        let imageItem2 = Helpers.makeMockItem(id: 2, type: .photo, largeUrl: "https://pixabay.com/get/ed6a9364a9fd0a76647.jpg", imageUrl: "https://pixabay.com/get/ed6a9364a9fd0a76647.jpg")
            store.insert([imageItem1.item, imageItem2.item])
            store.retrieve(completion: { result in
                switch result {
                   case let .success(items):
                    XCTAssertEqual(items.count, 2)
                case .failed:
                    break
                }
            })
           store.deleteCachedImage(compeletion: {_ in })
           store.retrieve(completion: { result in
            switch result {
               case let .success(items):
                XCTAssertEqual(items.count, 0)
            case .failed:
                break
            }
          })
    }

    // MARK: - Helpers
    private class MockStore: ImageStore {
        
        private var items = [ImageItem]()
        public var deletedCachedImagesCount = 0
        public var insertedCacheImagesCount = 0
        
        func deleteCachedImage(compeletion: @escaping (ImageStoreResult) -> Void) {
            items.removeAll()
            deletedCachedImagesCount += 1
        }
        
        func insert(_ items: [ImageItem]) {
            self.items = items
            insertedCacheImagesCount += 1
        }
        
        func retrieve(completion: @escaping (ImageStoreRetreiveResult) -> Void) {
            completion(.success(items))
        }
        
    }
}
