//
//  CountryAPIClient.swift
//  Collection-View-Lab
//
//  Created by Sunni Tang on 9/26/19.
//  Copyright © 2019 Sunni Tang. All rights reserved.
//

import Foundation

struct CountryAPIClient {
    
    // MARK: - Static Properties
    
    static let manager = CountryAPIClient()
    
    // MARK: - Instance Methods
    
    static func getFlagImageURLStr(from code: String) -> String {
        return "https://www.countryflags.io/\(code.lowercased())/shiny/64.png"
    }
    
    func getCountries(completionHandler: @escaping (Result<[Country], AppError>) -> ())  {
        NetworkHelper.manager.performDataTask(withUrl: countryURL, andMethod: .get) { (results) in
            switch results {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                do {
                    let countryInfo = try Country.decodeCountriesFromData(from: data)
                    completionHandler(.success(countryInfo))
                }
                catch {
                    completionHandler(.failure(.couldNotParseJSON(rawError: error)))
                }
                
            }
        }
    }
    
    
    // MARK: - Private Properties and Initializers
    private var countryURL: URL {
        guard let url = URL(string: "https://restcountries.eu/rest/v2/name/united") else {
            fatalError("Error: Invalid URL")
        }
        return url
    }
    
    private init() {}
}
