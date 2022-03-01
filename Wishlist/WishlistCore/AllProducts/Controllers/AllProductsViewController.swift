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
    ///Wishlist View Controller View Model
    fileprivate var viewModel: AllProductsViewModel?
    
    ///Products
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
    
    /// Show Warning if user inputed empty string
    public func showWarning(){
        let alert = UIAlertController(title: StringConstants.warningTitle, message: StringConstants.warningMessage, preferredStyle: .alert)
        
        let action = UIAlertAction(title: StringConstants.warningAction, style: .default)
        
        alert.addAction(action)
        
        self.present(alert, animated: true) {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissAlertController))
            alert.view.superview?.subviews[0].addGestureRecognizer(tapGesture)
        }
    }
    
    /// Show Alert to ask for user input
    /// - Parameter index: cell index
    public func showAlert(index: Int){
    
        let alert = UIAlertController(title: StringConstants.alertTitle, message: nil, preferredStyle: .alert)
        
        ///textfield
        alert.addTextField(configurationHandler:  { (textField) -> Void in
            textField.placeholder = StringConstants.alertPlaceHolder
        })
        
        ///save action and completion
        let action = UIAlertAction(title: StringConstants.alertActionTitle, style: .default) { (_) in
            let textField = alert.textFields![0]
            self.delegate?.saveProductWith(name: String(describing: textField.text!), index: index)
        }
        
        ///add action
        alert.addAction(action)
        
        ///tap gesture outside alert bounds
        self.present(alert, animated: true) {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissAlertController))
            alert.view.superview?.subviews[0].addGestureRecognizer(tapGesture)
        }
    }
    
    /// Dismiss Alert if user clicked outside the alert
    @objc func dismissAlertController(){
        self.dismiss(animated: true, completion: nil)
    }
}
