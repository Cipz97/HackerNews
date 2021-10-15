//
//  NetworkManager.swift
//  HackerNews
//
//  Created by Matteo Cipone on 15.10.21.
//

import Foundation


class NetworkManager: ObservableObject {
    
   @Published var posts: [Post] = [Post]()
    
    func fetchData() {
        if let url = URL(string: K.apiKey) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let results = try decoder.decode(Results.self, from: safeData)
                            DispatchQueue.main.async {
                                self.posts = results.hits
                            }
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    func performRequest(with url: String) {
        
    }
}
