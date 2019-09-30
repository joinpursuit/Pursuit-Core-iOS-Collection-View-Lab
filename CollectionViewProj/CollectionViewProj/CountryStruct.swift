//
//  CountryStruct.swift
//  CollectionViewProj
//
//  Created by Kevin Natera on 9/26/19.
//  Copyright © 2019 Kevin Natera. All rights reserved.
//

import Foundation


struct Country : Codable {
    let name: String
    let capital: String
    let population: Int
    let alpha2Code: String
    
    static func getFilteredCountries(arr: [Country], searchString: String) -> [Country] {
        return arr.filter{$0.name.lowercased().contains(searchString.lowercased())}
    }
    
}

