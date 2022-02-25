//
//  WishlistViewModel.swift
//  Wishlist
//
//  Created by Juliana Prado on 24/02/22.
//

import Foundation
import UIKit

class WishlistViewModel: NSObject {
   
    /// View that will be shown by the view controller
    private let view = WishlistView()
    private let products: Products?
    private let wishlistAllItems: [ProductModel]?
    
    /// Get AllProductsViewModel's Main View
    /// - Returns: UIView
    public func getView() -> UIView{
        return self.view
    }
    
    public func getNavigationTitle() -> String{
        return StringConstants.wishlistNavigationTitle
    }
    
    init(products: Products){
        self.products = products
        self.wishlistAllItems = products.getWishlist()
        super.init()
        view.collectionView.delegate = self
        view.collectionView.dataSource = self
    }
    
}

extension WishlistViewModel: UICollectionViewDelegate {
    
}

extension WishlistViewModel: UICollectionViewDataSource {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let list = wishlistAllItems else {
            return 0 
        }
        
        if list.count != 0 {
            return list.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WishlistCell.wishlistIdentifier, for: indexPath) as! WishlistCell
        
        guard let list = wishlistAllItems else {
            return cell
        }
        
        if list.count != 0 {
            let product = list[indexPath.row]
            cell.setupCellProperties(productName: product.title, image: UIImage())
            return cell
        }
       return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height * 0.12)
    }
    
}
