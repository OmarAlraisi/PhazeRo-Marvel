//
//  ComicsModel.swift
//  PhazeRo-Marvel
//
//  Created by Omar Al Raisi on 26/08/2022.
//

import Foundation

protocol ComicsModelDelegate {
    func comicsFetched (_ comics:[Comic])
}

class ComicsModel {
    
    var delegate: ComicsModelDelegate?
    
    func getComics(_ charID: Int) {
        
        let url = URL(string: Helpers.constructComicsAPI(charID))
        
        guard url != nil else {
            return
        }
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            guard (error == nil && data != nil) else {
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(ComicsResponse.self, from: data!)
                
                // Call the "comicsFetched" ComicsModelDelegate method to pass the parsed response to our comics view controller
                if response.results != nil {
                    DispatchQueue.main.async {
                        self.delegate?.comicsFetched(response.results!)
                    }
                }
            } catch {
                print("Could not load comics!!!")
            }
        }
        dataTask.resume()
    }
}
