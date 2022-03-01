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

extension AllProductsViewModel: UIAlertStringProtocol {
    func showWarning() {
        print()
    }
    
    
    func saveProductWith(name: String, index: Int){
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
        } else {
                guard let vc = viewController else {
                    return
                }
                vc.delegate = self
            vc.showWarning()
        }
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
