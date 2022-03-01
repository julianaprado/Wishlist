//
//  Products.swift
//  Wishlist
//
//  Created by Juliana Prado on 23/02/22.
//

import Foundation

class Products {
    
    private var products: [ProductModel] = []
    private var wishlist: [WishlistFolder] = []
    private var wishlistDictionary = [String: Int]()
    
    init(){
        populateProducts()
    }
    
    fileprivate func populateProducts(){
        for i in 1...20{
            let id = String(i)
            let title = "Product \(id)"
            products.append(ProductModel(id: id, title: title, url: "https://via.placeholder.com/150"))
        }
    }
    
    public func getProducts() -> [ProductModel] {
        return products
    }
    
    public func addToWishList(folderName: String, productName: String, index: Int){
        let i = wishlistDictionary[folderName]
        if i == nil {
            wishlist.append(WishlistFolder(folder: String(folderName), products: [ProductModel(id: "0", title: String(productName), url: products[index].url)]))
            wishlistDictionary[folderName] = wishlist.endIndex
            wishlist = wishlist.sorted {
                $0.folder < $1.folder
            }
            sortWishlistDictionary()
        } else {
            let lastIndex = wishlist[i!].products.count
            wishlist[i!].products.append(ProductModel(id: String(lastIndex), title: String(productName), url: products[index].url))
            wishlist[i!].products = wishlist[i!].products.sorted {
                $0.title < $1.title
            }
        }
    }
    
    func sortWishlistDictionary(){
        for (i,folder) in wishlist.enumerated() {
            wishlistDictionary.updateValue(i, forKey: folder.folder)
        }
    }
    
    public func getWishlist() -> [WishlistFolder] {
        return wishlist
    }
    
}
