//
//  Cache.swift
//  PhazeRo-Marvel
//
//  Created by Omar Al Raisi on 26/08/2022.
//

import Foundation

/**
    - Notes:
        Since there are under 2,000 characters as of August 2022, and not all characters have images. If we assume that 1,800 of the characters have images and the average size of the images is 20KB, they would sum up to 36MB total size, which is not a lot in today's standards, so I would rather give up a little bit of space to increase time efficiency by downloading an image once and then cache it in a dictionary object "cache".
 
        The caching mechanism used here is a simple and effective one in our case. However, in different scenarios it has a major issue which is that it can use a lot of memory as the number of images increase. A still simple but slightly better solution would be using NSCache, which is also a key/value storage, but, we can limit the size of the cached images, and it has its auto-eviction policy that would ensure being under the limit at all times. But for the sake of simplisity I just went with the dictionary cache approach shown below.
*/

class Cache {
    
    private static var cache = [String: Data]()
    
    static func addImage (_ url: String, _ data: Data) {
        cache[url] = data
    }
    
    static func getImage (_ url: String) -> Data? {
        return cache[url]
    }
}
