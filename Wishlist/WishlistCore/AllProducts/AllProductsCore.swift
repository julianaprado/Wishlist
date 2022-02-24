//
//  AllProductsCore.swift
//  Wishlist
//
//  Created by Juliana Prado on 23/02/22.
//

import Foundation
import UIKit

public protocol AllProductsCoreProtocol: AnyObject{
    func showAllProducts(nav: UINavigationController)
}


public class AllProductsCore: AllProductsCoreProtocol {
    public func showAllProducts(nav: UINavigationController) {
        let controller = AllProductsViewController()
        nav.pushViewController(controller, animated: false)
    }

}

