//  Created on 08/03/2022.

import Foundation

protocol ImageLoader {
    func load(completion: @escaping (Result) -> Void)
}

//SOLID - interface segregation
protocol ImageCacheLoader: ImageLoader {
    func save(items: [ImageItem], completion: @escaping (Error) -> Void)
}
