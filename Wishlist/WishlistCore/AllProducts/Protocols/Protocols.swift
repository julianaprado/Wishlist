//
//  Protocols.swift
//  Wishlist
//
//  Created by Juliana Prado on 23/02/22.
//

import Foundation

protocol UIAlertStringProtocol: AnyObject {
    func saveProductWith(name: String, index: Int)
    func showWarning()
}
