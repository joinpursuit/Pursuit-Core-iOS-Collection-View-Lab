//
//  ExchangeRateAPIClient.swift
//  Collection View Lab
//
//  Created by Jason Ruan on 9/27/19.
//  Copyright © 2019 Jason Ruan. All rights reserved.
//

import Foundation

class ExchangeRateAPIClient {
    private init() {}
    static let manager = ExchangeRateAPIClient()
    
    func getExchangeRate(countryCurrency: String, completionHandler: @escaping (Result<ExchangeRate, AppError>) -> () ) {
        let urlString = "http://data.fixer.io/api/latest?access_key=a17aef5ece92cf36d9c5963f7f4babf1&format=1"
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.badURL))
            return
        }
        NetworkHelper.manager.performDataTask(withUrl: url, andMethod: .get) { (result) in
            switch result {
            case .failure(_):
                completionHandler(.failure(.noDataReceived))
            case .success(let data):
                do {
                    let exchangeRate = try JSONDecoder().decode(ExchangeRate.self, from: data)
                    completionHandler(.success(exchangeRate))
                } catch {
                    completionHandler(.failure(.couldNotParseJSON(rawError: error)))
                }
            }
        }
    }
}
