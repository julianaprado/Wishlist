//
//  CoreViewController.swift
//  Wishlist
//
//  Created by Juliana Prado on 24/02/22.
//

import Foundation
import UIKit

public class CoreViewController: UIViewController {
    
    var shouldHaveWishlistButton = false
    weak var wishlistButtonDelegate: wishlistButttonProtocol?
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let nv = self.navigationController else {
            return
        }
        
        setupNavbar(nav: nv)
    
        
        if shouldHaveWishlistButton {
            
            setupWishlistButton()
        }
        
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }

    func setupNavbar(nav: UINavigationController) {
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray]
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .black
        appearance.titleTextAttributes = textAttributes
        nav.navigationBar.standardAppearance = appearance
        nav.navigationBar.isTranslucent = false
        nav.navigationBar.tintColor = .gray
        
        let yourBackImage = UIImage(systemName: "arrow.left")
        nav.navigationItem.leftBarButtonItem?.image = yourBackImage
        nav.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
        nav.navigationBar.backItem?.title = ""

    }
    
    func setupWishlistButton(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "text.badge.plus"), style: .plain, target: self, action: #selector(rightBarButtonItemTapped))
        navigationItem.rightBarButtonItem?.tintColor = .gray
    }
    
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
