//
//  Helpers.swift
//  PhazeRo-Marvel
//
//  Created by Omar Al Raisi on 23/08/2022.
//

import Foundation
import CryptoKit
import UIKit

class Helpers {
    
    // This is used to keep track of what characters to load next
    static var offset = -100
    /// Returns the appropriate API URL string for getting the next 100 characters
    static func constructCharactersAPI () -> String {
        let timestamp = String(Date().timeIntervalSince1970).replacingOccurrences(of: ".", with: "")
        let hash = MD5(timestamp)
        offset += 100
        return "\(Constants.CHARACTERS_API_URL)\(timestamp)&apikey=\(Constants.PUBLIC_KEY)&hash=\(hash)&offset=\(offset)"
    }
    
    
    /// Returns the appropriate API URL string for getting 100 comics
    static func constructComicsAPI (_ charID: Int) -> String {
        let timestamp = String(Date().timeIntervalSince1970).replacingOccurrences(of: ".", with: "")
        let hash = MD5(timestamp)
        return "\(Constants.COMICS_API_URL)\(charID)&limit=100&apikey=\(Constants.PUBLIC_KEY)&ts=\(timestamp)&hash=\(hash)"
    }
    
    /// Takes in a plaintext string and returns an MD5 hashed string
    private static func MD5 (_ timestamp: String) -> String {
        // Decided to have the private key in this private method rather than exposing it to the entire app
        let data = "\(timestamp)507eef9581ac59c2b4cb3a416eeeb54d32afd8d4\(Constants.PUBLIC_KEY)"
        let hash = Insecure.MD5.hash(data: data.data(using: .utf8)!)
        return hash.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
    
    /// Takes in a UIImageView and the URL related to the image and sets the image
    static func setImage (_ imageURL: String, _ imageView: UIImageView) {
        if let cacheData = Cache.getImage(imageURL) {
            imageView.image = UIImage(data: cacheData)
            return
        }
        
        let url = URL(string: imageURL)
    
        guard url != nil else {
            return
        }
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { (data, _, error) in

            guard error == nil  && data != nil else {
                return
            }

            Cache.addImage(imageURL, data!)
            if url!.absoluteString != imageURL {
                return
            }
            DispatchQueue.main.async {
                imageView.image = UIImage(data: data!)
            }
        }
        dataTask.resume()
    }
}
