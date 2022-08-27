//
//  CharactersResponse.swift
//  PhazeRo-Marvel
//
//  Created by Omar Al Raisi on 26/08/2022.
//

import Foundation

class CharactersResponse: Decodable {
    
    var results: [MarvelCharacter]?
    
    enum CodingKeys: String, CodingKey {
        case data
        case results
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let dataContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        results = try dataContainer.decode([MarvelCharacter].self, forKey: .results)
    }
    
    /*
        CharactersResponse Schema {         <-- container
            data: {                         <-- dataContainer
                results: [MarvelCharacter]  <-- results
            }
        }
    */
}
