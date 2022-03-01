//
//  WishlistCore.swift
//  Wishlist
//
//  Created by Juliana Prado on 23/02/22.
//

import Foundation
import UIKit

/// Wishlist Protocol
 protocol WishlistCoreProtocol: AnyObject{
    func showWishlist(nav: UINavigationController, products: Products)
}

/// WIshlist Coordinator
public class WishlistCore: WishlistCoreProtocol {
    
    /// Show Wishlist
    /// - Parameters:
    ///   - nav: UINavigationController
    ///   - products: Products Object
    func showWishlist(nav: UINavigationController, products: Products) {
        let controller = WishlistViewController(products: products)
        nav.pushViewController(controller, animated: false)
    }

}
