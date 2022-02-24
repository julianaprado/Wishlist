//
//  Products.swift
//  Wishlist
//
//  Created by Juliana Prado on 23/02/22.
//

import Foundation

class Products {
    
    private var products: [ProductModel] = []
    
    init(){
        populateProducts()
    }
    
    fileprivate func populateProducts(){
        for i in 0...20{
            let id = String(i)
            let title = "Product \(id)"
            products.append(ProductModel(id: id, title: title, url: "https://via.placeholder.com/150"))
        }
    }
    
    public func getProducts() -> [ProductModel] {
        return products
    }
    
}
