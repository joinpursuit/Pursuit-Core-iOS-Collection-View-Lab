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
    var alpha2Code: String?
    
    var imageURL: String {
        if alpha2Code != nil || alpha2Code != "" {
            return "https://www.countryflags.io/\(alpha2Code!.lowercased())/flat/64.png"
        } else {
            return "https://i2.wp.com/icfablab.org/wp-content/uploads/woocommerce-placeholder.png?zoom=2&fit=510%2C510&ssl=1"
        }
    }
    
}



struct Currency: Codable {
    var code: String?
    var name: String?
    var symbol: String?
    
}




