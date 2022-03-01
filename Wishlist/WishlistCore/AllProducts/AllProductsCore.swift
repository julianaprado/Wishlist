//
//  AllProductsCore.swift
//  Wishlist
//
//  Created by Juliana Prado on 23/02/22.
//

import Foundation
import UIKit

/// All Products Protocol
protocol AllProductsCoreProtocol: AnyObject{
    func showAllProducts(nav: UINavigationController, products: Products)
}

/// AllProducts Coordinator
public class AllProductsCore: AllProductsCoreProtocol {
    
    /// Show All Products View Controller
    /// - Parameters:
    ///   - nav: UINavigationController
    ///   - products: Products Object
    func showAllProducts(nav: UINavigationController, products: Products) {
        let controller = AllProductsViewController(products: products)
        nav.pushViewController(controller, animated: false)
    }
}
