//
//  WishlistCell.swift
//  Wishlist
//
//  Created by Juliana Prado on 25/02/22.
//

import Foundation
import UIKit

/// Wishlist Cell: Custom Collection View Cell
class WishlistCell: UICollectionViewCell {
    
    //MARK: - Properties
    static let wishlistIdentifier = "cell"
    
    //MARK: - View Components
    ///Product name label
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
    
    ///product image
     lazy var image: DownloadableImageView = {
        let image = DownloadableImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    ///Function called inside prepare for reuse
    var onReuse: () -> Void = {}
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Collection View Delegate Function
    override func prepareForReuse() {
      super.prepareForReuse()
      onReuse()
      image.image = nil
    }
    
}

//MARK: - View Layout Protocol
extension WishlistCell: UIViewLayout{
    
    func setupHierarchy() {
        addSubview(productName)
        addSubview(image)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            image.rightAnchor.constraint(equalTo: self.rightAnchor),
            image.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            image.widthAnchor.constraint(equalTo: self.heightAnchor, constant: -3),
            image.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -3),
            
            productName.leftAnchor.constraint(equalTo: self.leftAnchor),
            productName.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            productName.rightAnchor.constraint(equalTo: image.leftAnchor, constant: -20),
            
        ])
    }
    
    func setupViews() {
        self.backgroundColor = .clear
        self.clipsToBounds = true
    }
    
}

//MARK: - Setup Cell Properties
extension WishlistCell {
    
    /// Setup Cell Properties
    /// - Parameter productName: Product Name Text
    func setupCellProperties(productName: String) {
        self.productName.text = productName
    }
    
}
