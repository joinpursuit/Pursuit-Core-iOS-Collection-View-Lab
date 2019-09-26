//
//  CountryModel.swift
//  ConcurrencyLab
//
//  Created by Sam Roman on 9/3/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import Foundation
import UIKit



struct Countries: Codable {
    var name: String
    var flag: String
    var capital: String
    var population: Int
    var currencies: [Currency]
    
    static func getCountries(from data: Data) -> [Countries]? {
        do {
            let countries = try JSONDecoder().decode([Countries].self, from: data)
            return countries
        } catch let decodeError {
            fatalError("Could not decode \(decodeError)")
        }
        
}
    
    
}

struct Currency: Codable {
    var code: String
    var name: String
    var symbol: String
    
}




