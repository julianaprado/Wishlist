//
//  AllProductsCore.swift
//  Wishlist
//
//  Created by Juliana Prado on 23/02/22.
//

import Foundation
import UIKit

protocol AllProductsCoreProtocol: AnyObject{
    func showAllProducts(nav: UINavigationController, products: Products)
}


public class AllProductsCore: AllProductsCoreProtocol {
    
    func showAllProducts(nav: UINavigationController, products: Products) {
        let controller = AllProductsViewController(products: products)
        nav.pushViewController(controller, animated: false)
    }
    

}

