//
//  WishlistFolderCell.swift
//  Wishlist
//
//  Created by Juliana Prado on 27/02/22.
//

import Foundation
import UIKit

class WishlistFolderCell: UIView {
    
    fileprivate lazy var folderName: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.textAlignment = .right
        label.sizeToFit()
        label.adjustsFontSizeToFitWidth = true
        label.font = .boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension WishlistFolderCell: UIViewLayout {
    func setupHierarchy() {
        addSubview(folderName)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            folderName.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    func setupViews() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
}

extension WishlistFolderCell {
    
    func setupFolderName(name: String){
        folderName.text = name
    }
    
}
