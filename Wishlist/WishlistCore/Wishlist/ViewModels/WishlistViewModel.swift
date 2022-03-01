//
//  WishlistViewModel.swift
//  Wishlist
//
//  Created by Juliana Prado on 24/02/22.
//

import Foundation
import UIKit

class WishlistViewModel: NSObject {
    
    /// View that will be shown by the view controller
    private let view = WishlistView()
    private let products: Products?
    private let wishlistAllItems: [WishlistFolder]?
    lazy var dataSource = setupDifferableDataSource()
    
    /// Get AllProductsViewModel's Main View
    /// - Returns: UIView
    public func getView() -> UIView{
        return self.view
    }
    
    public func getNavigationTitle() -> String{
        return StringConstants.wishlistNavigationTitle
    }
    
    init(products: Products){
        self.products = products
        self.wishlistAllItems = products.getWishlist()
        super.init()
                
        //Data Source
        var dataSourceSnapshot = NSDiffableDataSourceSnapshot<Section,WishlistItemEnum>()
        
        dataSourceSnapshot.appendSections([.main])
        dataSource.apply(dataSourceSnapshot)
                
        var sectionSnapshot = NSDiffableDataSourceSectionSnapshot<WishlistItemEnum>()
        
        guard let list = wishlistAllItems else {
            return
        }
        
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

extension WishlistViewModel {

    
    func setupDifferableDataSource() -> UICollectionViewDiffableDataSource<Section, WishlistItemEnum>  {
        
        let folderCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, WishlistFolder> {  cell, indexPath, wishlistFolder in
        
            lazy var label = UILabel()
            label.textColor = .gray
            label.textAlignment = .right
            label.sizeToFit()
            label.numberOfLines = 0
            label.adjustsFontSizeToFitWidth = true
            label.font = .boldSystemFont(ofSize: 17)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = wishlistFolder.folder
            
            cell.addSubview(label)
            
            let folderDisclosure = UICellAccessory.OutlineDisclosureOptions(style: .header, isHidden: false, reservedLayoutWidth: .standard, tintColor: .gray)
            cell.accessories = [.outlineDisclosure(displayed: .always, options: folderDisclosure, actionHandler: .none)]
            
            label.leftAnchor.constraint(equalTo: cell.leftAnchor).isActive = true
            label.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
            label.rightAnchor.constraint(equalTo: cell.rightAnchor, constant: -50).isActive = true
 
        }
        
        let listCellRegistration = UICollectionView.CellRegistration<WishlistCell, ProductModel>  {  [weak self]  cell, indexPath, productList in
            cell.heightAnchor.constraint(equalToConstant: (self?.view.frame.width)! * 0.2 ).isActive = true
            let image = productList.url
            cell.onReuse = {
                cell.image.cancelLoadingImage()
            }
            cell.image.downloadWithUrlSession(at: cell, urlStr: image)
            cell.setupCellProperties(productName: productList.title)
        }
        
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

