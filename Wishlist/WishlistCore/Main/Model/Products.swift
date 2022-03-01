//
//  Products.swift
//  Wishlist
//
//  Created by Juliana Prado on 23/02/22.
//

import Foundation

/// Product Model Coordinator
class Products {
    
    //MARK: - Properties
    /// products list
    private var products: [ProductModel] = []
    
    /// list of wishlist folders
    /// Wishlist Folders: [Folder, List of Products]
    private var wishlist: [WishlistFolder] = []
    
    /// Dictionary: {String - folder name : Int - wishlist folder index}
    private var wishlistDictionary = [String: Int]()
    
    ///Image url string
    private let url = StringConstants.imageUrl
    
    //MARK: - Initializer
    init(){
        populateProducts()
    }
    
    //MARK: - Private Functions
    /// Populates the Poducts list
    fileprivate func populateProducts(){
        for i in 1...20{
            let id = String(i)
            let title = "Product \(id)"
            products.append(ProductModel(id: id, title: title, url: self.url))
        }
    }
    
    /// Setup Wishlist Dictionary
    private func sortWishlistDictionary(){
        for (i,folder) in wishlist.enumerated() {
            wishlistDictionary.updateValue(i, forKey: folder.folder)
        }
    }
    
    //MARK: - Public Functions
    /// Get Products
    /// - Returns: products list
    public func getProducts() -> [ProductModel] {
        return products
    }
    
    /// get Wishlist
    /// - Returns: [WishlistFolder]
    public func getWishlist() -> [WishlistFolder] {
        return wishlist
    }
    
    /// Add To Wishlist Function
    /// - Parameters:
    ///   - folderName: Name of the Folder to be added/created
    ///   - productName: Product Name (User Input String)
    ///   - index: Product's index from the product list
    public func addToWishList(folderName: String, productName: String, index: Int){
        let i = wishlistDictionary[folderName]
        
        ///if there is no folder created with that string
        if i == nil {
            wishlist.append(WishlistFolder(folder: String(folderName), products: [ProductModel(id: "0", title: String(productName), url: products[index].url)]))
            wishlistDictionary[folderName] = wishlist.endIndex
            
            ///order folders alphabetically
            wishlist = wishlist.sorted {
                $0.folder < $1.folder
            }
            ///update dictionary
            sortWishlistDictionary()
            
        /// else create a new folder
        } else {
            let lastIndex = wishlist[i!].products.count
            wishlist[i!].products.append(ProductModel(id: String(lastIndex), title: String(productName), url: products[index].url))
            ///order products alphabetically
            wishlist[i!].products = wishlist[i!].products.sorted {
                $0.title < $1.title
            }
        }
    }

}
