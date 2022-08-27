//
//  Comic.swift
//  PhazeRo-Marvel
//
//  Created by Omar Al Raisi on 26/08/2022.
//

import Foundation

class Comic: Decodable{
    
    var title = ""
    var detailsURL = ""
    
    enum CodingKeys: String, CodingKey {
        case title
        case urls
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        title = try container.decode(String.self, forKey: .title)
        
        // Parsing urls
        let urls = try container.decode([URLSResponse].self, forKey: .urls)
        for url in urls {
            if url.type == "detail" {
                detailsURL = url.url
            }
        }
    }
    
    /*
        Comic Schema {              <-- container
            title: String,          <-- title
            urls: [URLSResponse]    <-- urls --> url where type is "details"
        }
    */
}
