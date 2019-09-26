//
//  ExchangeRatesAPIClient.swift
//  Collection-View-Lab
//
//  Created by Sunni Tang on 9/26/19.
//  Copyright © 2019 Sunni Tang. All rights reserved.
//

import Foundation

struct ExchangeRatesAPIClient {
    
    // MARK: - Static Properties
    
    static let manager = ExchangeRatesAPIClient()
    
    // MARK: - Instance Methods
    func getRates(completionHandler: @escaping (Result<ExchangeRates, AppError>) -> ())  {
        NetworkHelper.manager.performDataTask(withUrl: ratesURL, andMethod: .get) { (results) in
            switch results {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                do {
                    let ratesInfo = try ExchangeRates.decodeExchangeRatesFromData(from: data)
                    completionHandler(.success(ratesInfo))
                }
                catch {
                    completionHandler(.failure(.couldNotParseJSON(rawError: error)))
                }
                
            }
        }
    }
    
    
    // MARK: - Private Properties and Initializers
    private var ratesURL: URL {
        guard let url = URL(string: "http://data.fixer.io/api/latest?access_key=a17aef5ece92cf36d9c5963f7f4babf1&format=1") else {
            fatalError("Error: Invalid URL")
        }
        return url
    }
    
    private init() {}
}
