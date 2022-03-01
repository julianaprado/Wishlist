//
//  AllProductsViewModel.swift
//  Wishlist
//
//  Created by Juliana Prado on 23/02/22.
//

import Foundation
import UIKit

// All Products View Model of:
/// All Products View Controller
class AllProductsViewModel: NSObject {
    
    /// View that will be shown by the view controller
    private let view = AllProductsView()
    
    /// list of products
    private var products: Products?
    
    /// Products List
    private var productList: [ProductModel] = []
    
    ///View Controller
    private let viewController: AllProductsViewController?
    
    /// Get AllProductsViewModel's Main View
    /// - Returns: UIView
    public func getView() -> UIView{
        return self.view
    }
    
    
    /// Get Navigation Title
    /// - Returns: String containing the title to be displayed on the navigation bar
    public func getNavigationTitle() -> String{
        return StringConstants.allProductsViewNavigationTitle
    }
    
    //MARK: - Initializer
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

//MARK: - UICollectionViewDelegateFlowLayout
extension AllProductsViewModel: UICollectionViewDelegateFlowLayout {
}

//MARK: - UICollectionViewDataSource,UIGestureRecognizerDelegate
extension AllProductsViewModel: UICollectionViewDataSource, UIGestureRecognizerDelegate {
    
    /// Setup Long Gesture Recognizer
    func setupLongGestureRecognizerOnCollection() {
        let longPressedGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gestureRecognizer:)))
        longPressedGesture.minimumPressDuration = 0.3
        longPressedGesture.delegate = self
        longPressedGesture.delaysTouchesBegan = true
        view.collectionView.addGestureRecognizer(longPressedGesture)
    }
    
    /// Handle Long Press
    /// - Parameter gestureRecognizer: UILongPressGestureRecognizer
    @objc func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        if (gestureRecognizer.state != .began) {
            return
        }
        
        let p = gestureRecognizer.location(in: view.collectionView)
        
        if let index = view.collectionView.indexPathForItem(at: p) {
            guard let vc = viewController else {
                return
            }
            vc.delegate = self
            vc.showAlert(index: index.row)
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
        
        let image = product.url
        cell.onReuse = {
            cell.image.cancelLoadingImage()
        }
        cell.image.downloadWithUrlSession(at: cell, urlStr: image)
        
        cell.setupCellProperties(productName: product.title)
        return cell
    }
}

/////MARK: - UIAlertStringProtocol
extension AllProductsViewModel: UIAlertStringProtocol {
    
    /// Save Products With Folder Name and Product Name
    /// - Parameters:
    ///   - name: Name inputed by the user
    ///   - index: product index
    func saveProductWith(name: String, index: Int){
        
        ///if user inputed the name
        if name != "" {
            let list = name.components(separatedBy: "/")
            let lastIndex = (list.count - 1) - 1
            
            if lastIndex >= 1 {
                let folderNameList = list[0...lastIndex]
                let folderName = folderNameList.joined(separator: "/")
                print("1: "+folderName)
                let productName = Array(list.suffix(1))
                products?.addToWishList(folderName: folderName, productName: productName[0], index: index)
            } else if lastIndex == 0{
                products?.addToWishList(folderName: list[0], productName: list[1], index: index )
            } else {
                products?.addToWishList(folderName: list[0], productName: list[0], index: index)
            }
        
        } ///if user inputed an empty string call ui alert
        else {
            guard let vc = viewController else {
                return
            }
            vc.delegate = self
            vc.showWarning()
        }
    }
}

//MARK: - wishlistButttonProtocol
extension AllProductsViewModel: wishlistButttonProtocol {
    
    /// Wish List Button clicked
    /// - Returns: Products
    func wishlistClicked() -> Products {
        guard let pd = products else {
            return Products()
        }
        return pd
    }
    
}
