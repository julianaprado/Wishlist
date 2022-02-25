//
//  AllProductsViewModel.swift
//  Wishlist
//
//  Created by Juliana Prado on 23/02/22.
//

import Foundation
import UIKit

class AllProductsViewModel: NSObject {
    
    /// View that will be shown by the view controller
    private let view = AllProductsView()
    private var products: Products?
    private var productList: [ProductModel] = []
    private let viewController: AllProductsViewController?
    
    /// Get AllProductsViewModel's Main View
    /// - Returns: UIView
    public func getView() -> UIView{
        return self.view
    }
    
    public func getNavigationTitle() -> String{
        return StringConstants.allProductsViewNavigationTitle
    }
    
    init(product: Products, viewController vc: AllProductsViewController) {
        self.products = product
        self.productList = product.getProducts()
        self.viewController = vc
        super.init()
        vc.wishlistButtonDelegate = self
        view.collectionView.delegate = self
        view.collectionView.dataSource = self
        setupLongGestureRecognizerOnCollection()
    }
    
}

extension AllProductsViewModel: UICollectionViewDelegateFlowLayout {
    
}


extension AllProductsViewModel: UICollectionViewDataSource, UIGestureRecognizerDelegate {
    
    func setupLongGestureRecognizerOnCollection() {
        let longPressedGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gestureRecognizer:)))
        longPressedGesture.minimumPressDuration = 0.3
        longPressedGesture.delegate = self
        longPressedGesture.delaysTouchesBegan = true
        view.collectionView.addGestureRecognizer(longPressedGesture)
    }
    
    @objc func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        if (gestureRecognizer.state != .began) {
            return
        }
        
        let p = gestureRecognizer.location(in: view.collectionView)
        
        if let indexPath = view.collectionView.indexPathForItem(at: p) {
            guard let vc = viewController else {
                return
            }
            vc.delegate = self
            vc.showAlert()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height * 0.12)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AllProductsCell.identifier, for: indexPath) as! AllProductsCell
        let product = productList[indexPath.row]
        cell.setupCellProperties(productName: product.title, image: UIImage())
        return cell
    }
    
}

extension AllProductsViewModel: UIAlertStringProtocol {
    
    func saveProductWith(name: String) {
        products?.addToWishList(id: "1", title: name)
    }
    
}

extension AllProductsViewModel: wishlistButttonProtocol {
   
    func wishlistClicked() -> Products {
        guard let pd = products else {
            return Products()
        }
        return pd
    }
    
}
