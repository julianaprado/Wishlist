//
//  CoreViewController.swift
//  Wishlist
//
//  Created by Juliana Prado on 24/02/22.
//

import Foundation
import UIKit

/// Extension class to setup navigation bar items
public class CoreViewController: UIViewController {
    
    /// Bool to check if there should be wishlist button
    var shouldHaveWishlistButton = false

    /// Wishlist button delegate
    weak var wishlistButtonDelegate: wishlistButttonProtocol?
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let nv = self.navigationController else {
            return
        }
        
        ///Setup navbar for all view controllers
        setupNavbar(nav: nv)
        
        ///setup navbar if wishlist button is ture
        if shouldHaveWishlistButton {
            setupWishlistButton()
        }
    
    }
    
    /// Setup Navbar
    /// - Parameter nav: Navigation Controller
    func setupNavbar(nav: UINavigationController) {
        
        ///Navigation Controller Title attributes
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray]
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .black
        appearance.titleTextAttributes = textAttributes
        nav.navigationBar.standardAppearance = appearance
        nav.navigationBar.isTranslucent = false
        nav.navigationBar.tintColor = .gray
        
        ///Back Button Setup
        let yourBackImage = UIImage(systemName: "arrow.left")
        nav.navigationItem.leftBarButtonItem?.image = yourBackImage
        nav.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
        nav.navigationBar.backItem?.title = ""

    }
    
    /// Setup Wishlist Button
    func setupWishlistButton(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "text.badge.plus"), style: .plain, target: self, action: #selector(rightBarButtonItemTapped))
        navigationItem.rightBarButtonItem?.tintColor = .gray
    }
    
    /// WIshlist button action
    /// - Parameter sender: UIBarButtonItem
    @objc func rightBarButtonItemTapped(_ sender: UIBarButtonItem){
        guard let nv = self.navigationController else {
            return
        }
        nv.navigationItem.hidesBackButton = true
        weak var product = (wishlistButtonDelegate?.wishlistClicked())!
        let wishlist = WishlistCore()
        wishlist.showWishlist(nav: nv, products: product!)
    }
    
}
