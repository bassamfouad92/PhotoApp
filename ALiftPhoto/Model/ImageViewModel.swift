//  Created on 09/03/2022.

import Foundation

final class ImageViewModel {
    private let imageLoader: ImageLoader
    
    init(imageLoader: ImageLoader) {
        self.imageLoader = imageLoader
    }
    
    var onLoadingStateChange: ((Bool) -> Void)?
    var onImageLoad: (([ImageItem]) -> Void)?
    
    func load() {
        onLoadingStateChange?(true)
        imageLoader.load(completion: { [weak self] result in
            switch result {
            case let .success(items):
                self?.onLoadingStateChange?(false)
                self?.onImageLoad?(items)
                break
            case .failed(_):
                self?.onLoadingStateChange?(false)
                break
            }
        })
    }
}
