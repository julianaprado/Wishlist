//
//  Core.swift
//  Wishlist
//
//  Created by Juliana Prado on 23/02/22.
//

import Foundation
import UIKit

public final class Core: CoreProtocol{

    let products = Products()

    public func coreSetup(nav: UINavigationController) {
        let allProductsModule = AllProductsCore()
        allProductsModule.showAllProducts(nav: nav, products: products)
    }
}
