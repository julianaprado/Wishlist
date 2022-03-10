//
//  Prduct.swift
//  Wishlist
//
//  Created by Juliana Prado on 23/02/22.
//

import Foundation

/// Individual Product Struct
struct ProductModel: Hashable {
    var i = UUID()
    ///Products id
    let id: String
    
    ///Products title
    let title: String
    
    ///Products image
    let url: String
    
    func hash(into hasher: inout Hasher) {
      hasher.combine(id)
    }
    
    static func == (lhs: ProductModel, rhs: ProductModel) -> Bool {
      lhs.i == rhs.i
    }
}

/// Wishlist's folder
struct WishlistFolder: Hashable {
    var i = UUID()
    
    /// folder that the product belongs to
    let folder: String
    
    /// list of all the products that belong to the folder
    var products: [ProductModel]
    
    func hash(into hasher: inout Hasher) {
      // 2
      hasher.combine(i)
    }
    // 3
    static func == (lhs: WishlistFolder, rhs: WishlistFolder) -> Bool {
      lhs.i == rhs.i
    }
    
}
