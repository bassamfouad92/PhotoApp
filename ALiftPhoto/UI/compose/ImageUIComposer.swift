//  Created on 09/03/2022.

import Foundation
import UIKit

final class ImageIUComposer {
    
    static func galleryComposeWith(imageLoader: ImageLoader, imageDataLoader: ImageDataLoader) -> GalleryCollectionViewController {
        let imageViewModel = ImageViewModel(imageLoader: imageLoader)
        let refreshController = ImageRefreshViewController(viewModel: imageViewModel)
            
        let galleryController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(identifier: "GalleryCollectionViewController") as? GalleryCollectionViewController
            galleryController?.refreshViewController = refreshController
            galleryController?.refreshViewController.refresh()
            galleryController?.imageDataLoader = imageDataLoader

            refreshController.onRefresh = { items in
                let vc = galleryController!
                    vc.tableModel = items
            }
        
        return galleryController!
    }
    
    
}
