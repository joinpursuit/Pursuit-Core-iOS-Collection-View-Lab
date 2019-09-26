//
//  Country.swift
//  Collection-View-Lab
//
//  Created by Sunni Tang on 9/26/19.
//  Copyright © 2019 Sunni Tang. All rights reserved.
//

import Foundation

struct Country: Codable {
    let name: String
    let capital: String
    let population: Int
    let code: String
    let currencies: [CurrencyInfo]
    
    private enum CodingKeys: String, CodingKey {
        case name, capital, population, currencies
        case code = "alpha2Code"
    }
    
    static func decodeCountriesFromData(from jsonData: Data) throws -> [Country] {
        let response = try JSONDecoder().decode([Country].self, from: jsonData)
        return response
    }
}

struct CurrencyInfo: Codable {
    let code: String
}
