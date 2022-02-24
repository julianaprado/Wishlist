//
//  Core.swift
//  Wishlist
//
//  Created by Juliana Prado on 23/02/22.
//

import Foundation
import UIKit

public protocol CoreProtocol: AnyObject {
    func coreSetup(nav: UINavigationController)
}

public class Core: CoreProtocol{

    let products: [ProductModel]
    
    init (products prod: [ProductModel]){
        self.products = prod
    }
    
    public func coreSetup(nav: UINavigationController) {
        let allProductsModule = AllProductsCore()
        allProductsModule.showAllProducts(nav: nav)
    }
    
}
