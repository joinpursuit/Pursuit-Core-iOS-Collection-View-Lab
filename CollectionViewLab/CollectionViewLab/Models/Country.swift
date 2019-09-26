//
//  Country.swift
//  CollectionViewLab
//
//  Created by Michelle Cueva on 9/26/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import Foundation

struct Country: Codable {
    let name: String
    let capital: String
    let population: Int
    let alpha2Code: String
    
    static func decodeCountryFromData(from jsondata: Data) throws -> [Country] {
      let response = try JSONDecoder().decode([Country].self, from: jsondata)
        return response
    }
    
    static func getFilteredResults(arr: [Country], searchText: String) -> [Country] {
        var currentFilter: [Country]
        currentFilter = arr.filter{$0.name.lowercased().contains(searchText.lowercased())}
        return currentFilter
    }
    
}
