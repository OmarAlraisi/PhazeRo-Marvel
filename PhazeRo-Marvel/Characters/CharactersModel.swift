//
//  CharactersModel.swift
//  PhazeRo-Marvel
//
//  Created by Omar Al Raisi on 23/08/2022.
//

import Foundation

protocol CharactersModelDelegate {
    func charactersFetched (_ characters:[MarvelCharacter])
}

class CharactersModel {
    
    var charactersDelegate: CharactersModelDelegate?
    
    func loadCharacters () {
        
        let url = URL(string: Helpers.constructCharactersAPI())
        
        guard url != nil else {
            return
        }
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { (data, _, error) in
            
            guard (error == nil && data != nil) else {
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(CharactersResponse.self, from: data!)
                
                // Call the delegate method to pass the response to the characters view controller
                if response.results != nil {
                    DispatchQueue.main.async {
                        self.charactersDelegate?.charactersFetched(response.results!)
                    }
                }
            } catch {
                print("Could not load more characters!!!")
            }
        }
        dataTask.resume()
    }
}
