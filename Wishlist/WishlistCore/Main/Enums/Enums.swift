//
//  WishlistItemEnum.swift
//  Wishlist
//
//  Created by Juliana Prado on 25/02/22.
//

import Foundation

enum WishlistItemEnum: Hashable {

    case folder(WishlistFolder)
    case productList(ProductModel)
    
}

enum Section {
    case main
}
