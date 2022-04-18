//  Created on 09/03/2022.

import Foundation
import UIKit

public class ImageRefreshViewController: NSObject {
    
    private var viewModel: ImageViewModel
    public lazy var view: UIRefreshControl = {
        let view = UIRefreshControl()
        bind(view)
        view.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return view
    }()
    
    init(viewModel: ImageViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var onRefresh: (([ImageItem]) -> Void)?
    
    private func bind(_ view: UIRefreshControl) {
        viewModel.onLoadingStateChange = { [weak self] isLoading in
            DispatchQueue.main.async {
                if isLoading {
                    self?.view.beginRefreshing()
                } else {
                    self?.view.endRefreshing()
                }
            }
        }
    }
    
    @objc func refresh() {
        loadImageItems()
    }
    
    private func loadImageItems() {
        viewModel.load()
        viewModel.onImageLoad = { [weak self] items in
            self?.onRefresh?(items)
        }
    }
    
}
