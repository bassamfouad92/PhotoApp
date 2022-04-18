//  Created on 09/03/2022.

import UIKit

private let reuseIdentifier = "ImageCollectionViewCell"

class GalleryCollectionViewController: UICollectionViewController {
    
    //property injection
    public var imageDataLoader: ImageDataLoader!
    public var refreshViewController: ImageRefreshViewController!

    public var tableModel = [ImageItem]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    //constructor injection
    public convenience init(imageDataLoader: ImageDataLoader, refreshImageController: ImageRefreshViewController) {
        self.init()
        self.imageDataLoader = imageDataLoader
        self.refreshViewController = refreshImageController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionViewLayout()
        collectionView.refreshControl = refreshViewController.view
        refreshViewController.refresh()
        collectionView.alwaysBounceVertical = true
    }
    
    private func setCollectionViewLayout() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            layout.sectionInset = UIEdgeInsets(top:0,left:0,bottom:0,right:0)
            layout.itemSize = CGSize(width: UIScreen.main.bounds.size.width/3, height: UIScreen.main.bounds.size.width/3)
        layout.minimumLineSpacing = -10
        layout.minimumInteritemSpacing = -10
        collectionView.collectionViewLayout = layout
    }
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tableModel.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
            if let imageCell = cell as? ImageCollectionViewCell {
                return getImageCellController(cell: imageCell, row: indexPath.row)
            }
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    private func getImageCellController(cell: ImageCollectionViewCell, row: Int) -> ImageCollectionViewCell {
        let view = ImageCellController(model: tableModel[row], imageDataLoader: imageDataLoader).view(cell)
        return view
    }

}
