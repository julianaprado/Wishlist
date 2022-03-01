//
//  WishlistViewModel.swift
//  Wishlist
//
//  Created by Juliana Prado on 24/02/22.
//

import Foundation
import UIKit


// Wishlist View Model of:
/// Wishlist View Controller
class WishlistViewModel: NSObject {
    
    //MARK: - Properties
    /// View that will be shown by the view controller
    private let view = WishlistView()
    
    /// list of products
    private let products: Products?
    
    /// Saved Wishlist Items
    private let wishlistAllItems: [WishlistFolder]?
    
    /// Collection View Diffable Datasource
    lazy var dataSource = setupDifferableDataSource()
    
    //MARK: - View Controller Properties
    /// Get AllProductsViewModel's Main View
    /// - Returns: UIView
    public func getView() -> UIView{
        return self.view
    }
    
    /// Get Navigation Title
    /// - Returns: String containing the title to be displayed on the navigation bar
    public func getNavigationTitle() -> String{
        return StringConstants.wishlistNavigationTitle
    }
    
    //MARK: - Initializer
    init(products: Products){
        self.products = products
        self.wishlistAllItems = products.getWishlist()
        super.init()
                
        /// Snapshot Data Source
        var dataSourceSnapshot = NSDiffableDataSourceSnapshot<Section,WishlistItemEnum>()
        
        dataSourceSnapshot.appendSections([.main])
        dataSource.apply(dataSourceSnapshot)
                
        var sectionSnapshot = NSDiffableDataSourceSectionSnapshot<WishlistItemEnum>()
        
        guard let list = wishlistAllItems else {
            return
        }
        
        ///Check if wishlistlist is populated
        if list.count > 0 {
            for folderItem in list {
                let folderListItem = WishlistItemEnum.folder(folderItem)
                sectionSnapshot.append([folderListItem])
                
                let productList = folderItem.products.map { WishlistItemEnum.productList($0) }
                sectionSnapshot.append(productList, to: folderListItem)
                
                sectionSnapshot.expand([folderListItem])
            }
            dataSource.apply(sectionSnapshot, to: .main, animatingDifferences: false)
        }
    }
}

//MARK: - Diffable Data Source
extension WishlistViewModel {
    
    /// Setup Wishlist Diffable Data Source
    /// - Returns: Returns Diffable Data Source
    func setupDifferableDataSource() -> UICollectionViewDiffableDataSource<Section, WishlistItemEnum>  {
        
        ///Setup Folder Cell
        let folderCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, WishlistFolder> {  cell, indexPath, wishlistFolder in
        
            ///Folder Cell Title Label
            lazy var label = UILabel()
            label.textColor = .gray
            label.textAlignment = .right
            label.sizeToFit()
            label.numberOfLines = 0
            label.adjustsFontSizeToFitWidth = true
            label.font = .boldSystemFont(ofSize: 17)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = wishlistFolder.folder
            
            ///Insert Label to cell subview
            cell.addSubview(label)
            
            ///Accessory to allow the cell to expand
            let folderDisclosure = UICellAccessory.OutlineDisclosureOptions(style: .header, isHidden: false, reservedLayoutWidth: .standard, tintColor: .gray)
            cell.accessories = [.outlineDisclosure(displayed: .always, options: folderDisclosure, actionHandler: .none)]
            
            ///label constraints
            label.leftAnchor.constraint(equalTo: cell.leftAnchor).isActive = true
            label.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
            label.rightAnchor.constraint(equalTo: cell.rightAnchor, constant: -50).isActive = true
        }
        
        ///Setup product list cell with custom Wishlist Cell View
        let listCellRegistration = UICollectionView.CellRegistration<WishlistCell, ProductModel>  {  [weak self]  cell, indexPath, productList in
            
            ///cell constraint
            cell.heightAnchor.constraint(equalToConstant: (self?.view.frame.width)! * 0.2 ).isActive = true
            
            ///Load image from url
            let image = productList.url
            
            ///setup cell for reuse to cancel loading image
            cell.onReuse = {
                cell.image.cancelLoadingImage()
            }
            
            ///load image from url
            cell.image.downloadWithUrlSession(at: cell, urlStr: image)
            
            ///setup reaining properties
            cell.setupCellProperties(productName: productList.title)
        }
        
        ///Seting up Diffable data source depending on the cell type
        dataSource = UICollectionViewDiffableDataSource<Section, WishlistItemEnum>(collectionView:  view.collectionView) { [weak self]
            (collectionView, indexPath, wishlistItemEnum) -> UICollectionViewCell? in
            switch wishlistItemEnum {
            case .folder(let folder):
                return self?.view.collectionView.dequeueConfiguredReusableCell(using: folderCellRegistration, for: indexPath, item: folder)
            case .productList(let products):
                return self?.view.collectionView.dequeueConfiguredReusableCell(using: listCellRegistration, for: indexPath, item: products)
            }
        }
        return dataSource
    }
}

