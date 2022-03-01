//
//  CoreProtocols.swift
//  Wishlist
//
//  Created by Juliana Prado on 24/02/22.
//

import Foundation
import UIKit

//MARK: - Core Protocol
public protocol CoreProtocol: AnyObject {
    func coreSetup(nav: UINavigationController)
}

//MARK: - UIViewLayout
public protocol UIViewLayout {
    func setupHierarchy()
    func setupConstraints()
    func setupViews()
}

/// Extention of UIViewLayout
extension UIViewLayout {
    func configureView(){
        setupHierarchy()
        setupConstraints()
        setupViews()
    }
}

//MARK: - Wishlist Protocol
protocol wishlistButttonProtocol: AnyObject {
    func wishlistClicked() -> Products
}
