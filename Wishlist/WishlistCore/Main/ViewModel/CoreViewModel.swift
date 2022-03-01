//
//  Core.swift
//  Wishlist
//
//  Created by Juliana Prado on 23/02/22.
//

import Foundation
import UIKit

///Main Coordinator
public final class Core: CoreProtocol{

    ///Create Products Instance
    let products = Products()

    
    /// Call on All Products Coordinator
    /// - Parameter nav: UINavigationController
    public func coreSetup(nav: UINavigationController) {
        let allProductsModule = AllProductsCore()
        allProductsModule.showAllProducts(nav: nav, products: products)
    }
}
