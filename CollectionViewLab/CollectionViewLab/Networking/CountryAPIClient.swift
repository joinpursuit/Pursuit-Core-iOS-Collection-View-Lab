//
//  CountryAPIClient.swift
//  CollectionViewLab
//
//  Created by Michelle Cueva on 9/26/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import Foundation

struct CountryAPIClient {
    
    // MARK: - Static Properties
    
    static let manager = CountryAPIClient()
    
    // MARK: - Instance Methods
    
    static func getFlagUrl(from abbreviation: String) -> String {
        return "https://www.countryflags.io/\(abbreviation.lowercased())/shiny/64.png"
    }
    
    func getElements(completionHandler: @escaping (Result<[Country], AppError>) -> ())  {
        NetworkHelper.manager.performDataTask(withUrl: countryURL, andMethod: .get) { (results) in
            switch results {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                do {
                    let countryInfo = try Country.decodeCountryFromData(from: data)
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
