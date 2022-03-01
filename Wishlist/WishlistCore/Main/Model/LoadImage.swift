//
//  LoadImage.swift
//  Wishlist
//
//  Created by Juliana Prado on 27/02/22.
//

import Foundation
import UIKit

/// image Cache to avoid reloading images
let imageCache = NSCache<AnyObject, AnyObject>()

/// Image View that allows for loading images from url
class DownloadableImageView: UIImageView {
    
    //MARK: - Properties
    var urlString: String?
    var dataTask: URLSessionDataTask?
    
    /// Download Image from Url
    /// - Parameters:
    ///   - cell: collection view cell which this image belongs to
    ///   - urlStr: url string to download image from
    func downloadWithUrlSession(at cell: UICollectionViewCell, urlStr: String) {
        urlString = urlStr
        
        guard let url = URL(string: urlStr) else { return  }
    
        image = nil
        
        ///if image is in cache
        if let imageFromCache = imageCache.object(forKey: urlStr as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        ///else, load image from url
        self.dataTask = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            guard let self = self,
                  let data = data,
                  let image = UIImage(data: data) else {
                return
            }
            
            DispatchQueue.main.async {
                if self.urlString == urlStr {
                    self.image = image
                }
                
                imageCache.setObject(image, forKey: urlStr as AnyObject)
            }
        }
        
        dataTask?.resume()
    }
    
    /// Cancel Loading Image
    func cancelLoadingImage() {
        dataTask?.cancel()
        dataTask = nil
    }
}
