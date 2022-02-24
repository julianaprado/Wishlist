//
//  AllProductsViewModel.swift
//  Wishlist
//
//  Created by Juliana Prado on 23/02/22.
//

import Foundation
import UIKit

class AllProductsViewModel {
    
    /// View that will be shown by the view controller
    private let view = AllProductsView()
    
    /// Get AllProductsViewModel's Main View
    /// - Returns: UIView
    public func getView() -> UIView{
        return self.view
    }
    
    public func getNavigationTitle() -> String{
        return StringConstants.allProductsViewNavigationTitle
    }
    
}
