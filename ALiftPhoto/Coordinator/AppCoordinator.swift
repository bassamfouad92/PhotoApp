//  Created on 09/03/2022.

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navCon : UINavigationController) {
        self.navigationController = navCon
    }
    
    func start() {
        launchGallery()
    }
    
    func launchGallery() {
        
        let session = HTTPSessionImp()
        
        let remoteImageLoader = RemoteImageLoader(url: URL(string: "https://pixabay.com/api/?key=26054130-eb566695e67c21a63f07eb622&q=yellow+flowers&image_type=photo&pretty=true")!, client: URLSessionHTTPClient(session: session))
        
        let localImageLoader = LocalImageLoader(store: UserDefaultStore())
        //with composite we have strategy to load from local if remote not working
        let imageFallbackComposite = ImageLoaderWithFallbackComposite(remote: remoteImageLoader, local: localImageLoader)
        
        let galleryViewController = ImageIUComposer.galleryComposeWith(imageLoader: imageFallbackComposite, imageDataLoader: ImageDataLoaderImp(session: session))

        //without composite
        
       // let galleryViewController = ImageIUComposer.galleryComposeWith(imageLoader: remoteImageLoader, imageDataLoader: ImageDataLoaderImp(session: session))
        
        self.navigationController.pushViewController(galleryViewController, animated: true)
    }
}
