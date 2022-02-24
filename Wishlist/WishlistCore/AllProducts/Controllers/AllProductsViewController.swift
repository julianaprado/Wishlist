//
//  AllProductsViewController.swift
//  Wishlist
//
//  Created by Juliana Prado on 23/02/22.
//

import Foundation
import UIKit

class AllProductsViewController: UIViewController {
    
    fileprivate var viewModel = AllProductsViewModel()
    
    override func loadView() {
        self.view = viewModel.getView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = viewModel.getNavigationTitle()
    }
        
}
