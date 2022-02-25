//
//  AllProductsView.swift
//  Wishlist
//
//  Created by Juliana Prado on 23/02/22.
//

import Foundation
import UIKit

class AllProductsView: UIView{
        
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 3.5
        layout.minimumInteritemSpacing = 3.5
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(AllProductsCell.self, forCellWithReuseIdentifier: AllProductsCell.identifier)
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

extension AllProductsView: UIViewLayout {
    
    func setupHierarchy(){
        addSubview(collectionView)
    }
    
    func setupConstraints(){
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalToSystemSpacingBelow: self.layoutMarginsGuide.topAnchor, multiplier: 15),
            collectionView.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor),
            collectionView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5)
        ])
        
    }
    
    func setupViews(){
    }
    
}
