//
//  MarvelCharacter.swift
//  PhazeRo-Marvel
//
//  Created by Omar Al Raisi on 26/08/2022.
//

import Foundation

class MarvelCharacter: Decodable {
    
    var id: Int!
    var name = ""
    var thumbnail = ""
    var detailsURL: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case thumbnail
        case path
        case exten = "extension"
        case urls
        case type
        case url
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        
        // Thumbnail parsing
        let thumbnailContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .thumbnail)
        let imagePath = try thumbnailContainer.decode(String.self, forKey: .path)
        let imageExtension = try thumbnailContainer.decode(String.self, forKey: .exten)
        thumbnail = "\(imagePath)/standard_fantastic.\(imageExtension)"
        thumbnail = thumbnail.replacingOccurrences(of: "http", with: "https")
        
        // Wiki url parsing
        let urls = try container.decode([URLSResponse].self, forKey: .urls)
        for url in urls {
            if url.type == "wiki" {
                detailsURL = url.url
            }
        }
    }
    
    /*
        MarvelCharacter Schema {    <-- container
            id: Int,                <-- id
            name: String,           <-- name
            thumbnail: {
                path: String,       <-- imagePath
                extension: String   <-- imageExtension
            },                      <-- thumbnail = imagePath + "standard_fantastic." + imageExtension
            urls: [URLSResponse]    <-- urls --> url where type is "wiki"
        }
    */
}
