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
        
        
       
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard error == nil else {completionHandler(.failure(.badStatusCode))
                return
            }
            
            guard let data = data else {completionHandler(.failure(.noDataReceived))
                return
            }
            
            guard let countries = Countries.getCountries(from: data) else {completionHandler(.failure(.invalidJSONResponse))
                return
            }
            
            completionHandler(.success(countries))}.resume()
    }
    
    
    
}
