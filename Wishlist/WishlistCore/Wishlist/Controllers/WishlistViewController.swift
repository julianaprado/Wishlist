//
//  WishlistViewController.swift
//  Wishlist
//
//  Created by Juliana Prado on 23/02/22.
//

import UIKit

/// Wishlist View Controller
class WishlistViewController: CoreViewController {

    //MARK: - Properties
    ///Wishlist View Controller View Model
    fileprivate var viewModel: WishlistViewModel?
    
    ///Products
    fileprivate var products: Products?
    
    //MARK: - Initializers
    init(products: Products){
        self.products = products
        super.init(nibName: nil, bundle: nil)
        viewModel = WishlistViewModel(products: products)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - View LifeCycle
    override func loadView() {
        guard let model = viewModel else {
            return
        }
        self.view = model.getView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let model = viewModel else {
            return
        }
        navigationItem.title = model.getNavigationTitle()
    }

}

