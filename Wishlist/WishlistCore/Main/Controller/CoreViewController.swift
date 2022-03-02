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
        } else {
            setupBackButton(nav: nv)
            setupSearchIcon()
        }
    
    }
    
    //MARK: - Customizing Navbar
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
        nav.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    /// Setup Back Button
    /// - Parameter nav: UINavigationController
    func setupBackButton(nav: UINavigationController){
        ///Back Button Setup
        nav.navigationBar.topItem!.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"), style: .plain, target: self, action: #selector(leftBarButtonItemTapped))
        nav.navigationItem.leftBarButtonItem?.tintColor = .gray
    }
    
    /// Setup Wishlist Button
    func setupWishlistButton(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "text.badge.plus"), style: .plain, target: self, action: #selector(rightBarButtonItemTapped))
        navigationItem.rightBarButtonItem?.tintColor = .gray
    }
    
    /// Setup Search Icon
    func setupSearchIcon(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchButtonItemTapped))
        navigationItem.rightBarButtonItem?.tintColor = .gray
    }
    
    //MARK: - Selector Functions
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
    
    /// WIshlist button action
    /// - Parameter sender: UIBarButtonItem
    @objc func leftBarButtonItemTapped(_ sender: UIBarButtonItem){
        guard let nv = self.navigationController else {
            return
        }
        nv.popViewController(animated: false)
    }
    
    /// Search button action
    /// - Parameter sender: UIBarButtonItem
    @objc func searchButtonItemTapped(_ sender: UIBarButtonItem){

        let searchController = UISearchController()
        navigationItem.searchController = searchController
    }
    
}
