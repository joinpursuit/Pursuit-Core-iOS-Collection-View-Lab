//
//  CountriesAPIClient.swift
//  iOS-Collection-View-Lab
//
//  Created by Krystal Campbell on 10/2/19.
//  Copyright © 2019 Krystal Campbell. All rights reserved.
//

import Foundation
class CountriesAPIManager {
    private init() {}
    static let shared = CountriesAPIManager()
    
    func getCountries(showInfo: String, completionHandler: @ escaping(Result<[Countries], AppError>)-> Void){
        
       // var countryURL = "https://restcountries.eu/rest/v2/name/united"
        
       // let newStr = countryURL.replacingOccurrences(of: " ", with: "-")
                
        let countryURL = "https://restcountries.eu/rest/v2/name/\(showInfo.replacingOccurrences(of: " ", with: "-"))"
    
        guard let urlStr = URL(string: countryURL) else {
            completionHandler(.failure(AppError.badURL))
            return
        }
        
        NetworkManager.shared.performDataTask(withUrl: urlStr, andMethod: .get){(result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                do {
                    let countryData = try JSONDecoder().decode([Countries].self, from: data)
                    completionHandler(.success(countryData))
                } catch {
                    print(error)
                    completionHandler(.failure(AppError.invalidJSONResponse))
                }
            }
        }
        
    }
}
