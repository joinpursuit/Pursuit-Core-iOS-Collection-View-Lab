//
//  CountryAPIClient.swift
//  collectionViewsLab
//
//  Created by Sam Roman on 9/26/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import Foundation

struct CountryAPIClient {
    static let shared = CountryAPIClient()

    
    func fetchData(searchStr: String, completionHandler: @escaping (Result<[Countries], AppError>) -> () ) {
        var str = "united"
        if searchStr != "" {
          str = searchStr
        } else {
            str = "united"
        }
        
        
        guard let url = URL(string:  "https://restcountries.eu/rest/v2/name/\(str.lowercased())") else { completionHandler(.failure(.badURL))
                       return
   
        }
    
        NetworkManager.manager.performDataTask(withUrl: url, andMethod: .get) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                do {
                    let decoded = try JSONDecoder().decode([Countries].self, from: data)
                    completionHandler(.success(decoded))
                } catch {
                    completionHandler(.failure(.badStatusCode))
                    print(error)
                }
            }
        }
        
    }
    
    
    
}
