//
//  WishlistCell.swift
//  Wishlist
//
//  Created by Juliana Prado on 25/02/22.
//

import Foundation
import UIKit

class WishlistCell: UICollectionViewCell {
    
    //MARK: - Properties
    static let wishlistIdentifier = "cell"
    
    fileprivate lazy var productName: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.textAlignment = .right
        label.sizeToFit()
        label.adjustsFontSizeToFitWidth = true
        label.font = .boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension WishlistCell: UIViewLayout{
    
    func setupHierarchy() {
        addSubview(productName)
//        addSubview(image)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
//            image.rightAnchor.constraint(equalTo: self.rightAnchor),
//            image.centerYAnchor.constraint(equalTo: self.centerYAnchor),
//            image.widthAnchor.constraint(equalTo: self.heightAnchor),
//            image.heightAnchor.constraint(equalTo: self.heightAnchor),
            
            productName.leftAnchor.constraint(equalTo: self.leftAnchor),
            productName.centerYAnchor.constraint(equalTo: self.centerYAnchor),
//            productName.rightAnchor.constraint(equalTo: image.leftAnchor, constant: -20),
            
        ])
    }
    
    func setupViews() {
        self.backgroundColor = .gray
        self.clipsToBounds = true
    }
    
}

extension WishlistCell {
    
    func setupCellProperties(productName: String, image: UIImage){
        self.productName.text = productName
//        self.image.image = image
    }
    
}
