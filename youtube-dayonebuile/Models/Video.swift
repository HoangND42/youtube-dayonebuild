//
//  Video.swift
//  youtube-dayonebuile
//
//  Created by apple on 2/10/23.
//

import Foundation

struct Video: Decodable {
    
    var videoId = ""
    var title = ""
    var description = ""
    var thumbnail = ""
    var published = Date()
    
    // CodingKey: giao thuc ma hoa
    enum CodingKeys: String, CodingKey {
        // container, nested container key
        case snippet
        case resourceId
        case thumbnails
        case high
        
        // other key
        case videoId
        case title
        case description
        case thumbnail = "url"
        case published = "publishedAt"
    }
    
    // Noi giai ma json
    // Tao 1 doi tuong json duoc goi la vung chua
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let snippetContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .snippet)
        
        // Parse title
        self.title = try snippetContainer.decode(String.self, forKey: .title)
        
        // Parse description
        self.description = try snippetContainer.decode(String.self, forKey: .description)
        
        // Parse videoId
        let resourceIdContainer = try snippetContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .resourceId)
        self.videoId = try resourceIdContainer.decode(String.self, forKey: .videoId)
        
        // Parse thumbnail
        let thumbnailsContainer = try snippetContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .thumbnails)
        let highContainer = try thumbnailsContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .high)
        self.thumbnail = try highContainer.decode(String.self, forKey: .thumbnail)
        
        // Parse published
        self.published = try snippetContainer.decode(Date.self, forKey: .published)
        
    }
}
