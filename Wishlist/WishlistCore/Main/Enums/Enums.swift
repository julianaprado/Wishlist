//
//  WishlistItemEnum.swift
//  Wishlist
//
//  Created by Juliana Prado on 25/02/22.
//

import Foundation


/// Wishlist Enum Diffable Data Source
/// Folder: Expandable Header
/// Product list: List Cells
enum WishlistItemEnum: Hashable {
    case folder(WishlistFolder)
    case productList(ProductModel)
}

/// Main Section of the
enum Section {
    case main
}
