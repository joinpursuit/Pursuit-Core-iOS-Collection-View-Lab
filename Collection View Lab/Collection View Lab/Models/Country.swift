//
//  Country.swift
//  Collection View Lab
//
//  Created by Jason Ruan on 9/26/19.
//  Copyright © 2019 Jason Ruan. All rights reserved.
//

import Foundation

struct Country: Codable {
    let name: String
    let capital: String
    let countryCode: String
    let population: Double
    let currencies: [Currency]
    
    private enum CodingKeys: String, CodingKey {
        case name
        case capital
        case countryCode = "alpha2Code"
        case population
        case currencies
    }
    
    struct Currency: Codable {
        let code: String?
        let symbol: String?
    }
}
