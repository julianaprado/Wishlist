//
//  Prduct.swift
//  Wishlist
//
//  Created by Juliana Prado on 23/02/22.
//

import Foundation

/// Individual Product Struct
struct ProductModel: Hashable {
    
    ///Products id
    let id: String
    
    ///Products title
    let title: String
    
    ///Products image
    let url: String
    
}

/// Wishlist's folder
struct WishlistFolder: Hashable {
    
    /// folder that the product belongs to
    let folder: String
    
    /// list of all the products that belong to the folder
    var products: [ProductModel]
    
}
