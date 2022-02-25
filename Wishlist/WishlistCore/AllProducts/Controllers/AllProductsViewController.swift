//
//  AllProductsViewController.swift
//  Wishlist
//
//  Created by Juliana Prado on 23/02/22.
//

import Foundation
import UIKit

/// Product List View Controller
class AllProductsViewController: CoreViewController {
    
    //MARK: - Properties
    fileprivate var viewModel: AllProductsViewModel?
    weak var delegate: UIAlertStringProtocol?
    
    //MARK: - Initializers
    init(products: Products){
        super.init(nibName: nil, bundle: nil)
        viewModel = AllProductsViewModel(product: products, viewController: self)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - View Lifecycle
    override func loadView() {
        guard let v = viewModel else {
            return
        }
        self.view = v.getView()
        self.shouldHaveWishlistButton = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let v = viewModel else {
            return
        }
        navigationItem.title = v.getNavigationTitle()
    }
    
}

//MARK: - UIAlert Extension
extension AllProductsViewController {
    
    public func showAlert(){
       
        let alert = UIAlertController(title: "Save to wishlist", message: nil, preferredStyle: .alert)
        
        alert.addTextField(configurationHandler:  { (textField) -> Void in
            textField.placeholder = "Custom Name"
        })
    
        let action = UIAlertAction(title: "Save", style: .default) { (_) in
            let textField = alert.textFields![0]
            self.delegate?.saveProductWith(name: String(describing: textField.text))
        }
        
        alert.addAction(action)
    
        self.present(alert, animated: true) {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissAlertController))
            alert.view.superview?.subviews[0].addGestureRecognizer(tapGesture)
        }
    }
    
    @objc func dismissAlertController(){
        self.dismiss(animated: true, completion: nil)
    }
}
