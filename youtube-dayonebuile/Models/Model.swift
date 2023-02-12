//
//  Model.swift
//  youtube-dayonebuile
//
//  Created by apple on 2/12/23.
//

import Foundation

protocol ModelDelegate {
    
    func videosFetched(_ video: [Video])
    
}

class Model {
    
    var delegate: ModelDelegate?
    
    func getVideos() {
        
        // Create a URL object
        let url = URL(string: Constants.API_URL)
        
        guard url != nil else {
            return
        }
        
        // Get a URLSession object
        let session = URLSession.shared
        
        // Get a dataTask from the URLSession object
        // dataTask run in the background thread
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            // check if there were any error
            guard error == nil && data != nil else {
                return
            }
            
            do {
                
                // Parsing the data into video objects
                // decoder.dateDecodingStrategy = .iso8601 / chuyen doi doi tuong json string to Date()
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                let response = try decoder.decode(Response.self, from: data!)
               
                guard response.items != nil else {
                    return
                }
                
                // Call the [videosFetched] method of the delegate
                // Moving to the main thread
                DispatchQueue.main.async {
                    // Refer in the closure required explicit with self
                    self.delegate?.videosFetched(response.items!)
                }
                
                dump(response)
                
            } catch {
                
            }
        }
        
        // Kick off the task
        dataTask.resume()
    }
}
