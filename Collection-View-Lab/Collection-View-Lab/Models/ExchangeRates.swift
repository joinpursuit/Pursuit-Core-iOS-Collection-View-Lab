//
//  ExchangeRates.swift
//  Collection-View-Lab
//
//  Created by Sunni Tang on 9/26/19.
//  Copyright © 2019 Sunni Tang. All rights reserved.
//

import Foundation

struct ExchangeRates: Codable {
    let rates: Dictionary<String, Double>
    
    static func decodeExchangeRatesFromData(from jsonData: Data) throws -> ExchangeRates {
        let response = try JSONDecoder().decode(ExchangeRates.self, from: jsonData)
        return response
    }
}
