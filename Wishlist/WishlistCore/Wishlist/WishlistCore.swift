//
//  WishlistCore.swift
//  Wishlist
//
//  Created by Juliana Prado on 23/02/22.
//

import Foundation
import UIKit

 protocol WishlistCoreProtocol: AnyObject{
    func showWishlist(nav: UINavigationController, products: Products)
}


public class WishlistCore: WishlistCoreProtocol {
    
    func showWishlist(nav: UINavigationController, products: Products) {
        let controller = WishlistViewController(products: products)
        nav.pushViewController(controller, animated: false)
    }

}
