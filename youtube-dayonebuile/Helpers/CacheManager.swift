//
//  CacheManager.swift
//  youtube-dayonebuile
//
//  Created by apple on 2/12/23.
//

import Foundation

class CacheManager {
    
    // Create a cache disctionary static proprerty
    static var cache = [String: Data]()
    
    static func setVideoCache(_ url: String, _ data: Data?) {
        
        // Store the image data and use the url as the key
        cache[url] = data
    }
    
    static func getVideoCache(_ url: String) -> Data? {
        
        // Try to get the data for the specified url (Cố gắng lấy dữ liệu cho url đã chỉ định)
        return cache[url]
    }
}
