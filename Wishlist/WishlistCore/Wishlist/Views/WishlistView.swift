//
//  WishlistView.swift
//  Wishlist
//
//  Created by Juliana Prado on 24/02/22.
//

import Foundation
import UIKit

class WishlistView: UIView {
    
    lazy var collectionView: UICollectionView = {
        var layoutConfig = UICollectionLayoutListConfiguration(appearance: .plain)
        layoutConfig.itemSeparatorHandler = .none
        layoutConfig.showsSeparators = false
        let layout = UICollectionViewCompositionalLayout.list(using: layoutConfig)

        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(WishlistCell.self, forCellWithReuseIdentifier: WishlistCell.wishlistIdentifier)
        collection.backgroundColor = .black
        collection.showsVerticalScrollIndicator = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        self.configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension WishlistView: UIViewLayout {
   
    func setupHierarchy() {
        addSubview(collectionView)
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalToSystemSpacingBelow: self.layoutMarginsGuide.topAnchor, multiplier: 15),
            collectionView.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor),
            collectionView.widthAnchor.constraint(equalTo: self.layoutMarginsGuide.widthAnchor),
        ])
        
    }
    
    func setupViews() {
    }
    
}
