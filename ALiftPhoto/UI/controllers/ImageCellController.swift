//  Created on 09/03/2022.

import Foundation
import UIKit

public class ImageCellController {
    
    private let model: ImageItem
    private let imageDataLoader: ImageDataLoader
    let imageCache = NSCache<NSString, UIImage>()

    init(model: ImageItem, imageDataLoader: ImageDataLoader) {
        self.model = model
        self.imageDataLoader = imageDataLoader
    }
    
    func view(_ cell: ImageCollectionViewCell) -> ImageCollectionViewCell {
        
        if let cachedImage = imageCache.object(forKey: model.previewURL as NSString)  {
            cell.galleryImageView.image = cachedImage
            return cell
        }
        
        let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .medium)
        cell.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        activityIndicator.center = cell.center
        
        imageDataLoader.loadImageData(from: URL(string: model.previewURL)!, completion: { [weak self] result in
            
            switch result {
               case let .success(data):
                DispatchQueue.main.async {
                    if let image = UIImage(data: data) {
                            self?.imageCache.setObject(image, forKey: (self?.model.previewURL ?? "") as NSString)
                            cell.galleryImageView.image = image
                            activityIndicator.removeFromSuperview()
                     }
                }
             case .failed(_): break
            }
        })
        
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
       
        return cell
    }
}
