//
//  URLSResponse.swift
//  PhazeRo-Marvel
//
//  Created by Omar Al Raisi on 26/08/2022.
//

import Foundation

class URLSResponse: Decodable {
    
    var url = ""
    var type = ""
    
    enum CodingKeys: String, CodingKey {
        case type
        case url
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(String.self, forKey: .type)
        url = try container.decode(String.self, forKey: .url)
    }
    
    /*
        URLSResponse Schema {   <-- container
            type: String,       <-- type
            url: String         <-- url
        }
    */
}
