//
//  Country.swift
//  CollectionViewLab
//
//  Created by Ahad Islam on 12/29/19.
//  Copyright © 2019 Ahad Islam. All rights reserved.
//

import Foundation

struct Country: Codable {
    let name: String
    let topLevelDomain: [String]
    let alpha2Code: String
    let alpha3Code: String
    let callingCodes: [String]
    let capital: String
    let altSpellings: [String]
    let region: String
    let subregion: String
    let population: Int
    let latlng: [Int]
    let demonym: String
    let area: Int?
    let gini: Double?
    let timezones: [String]
    let borders: [String]
    let nativeName: String
    let numericCode: String
    let currencies: [Currency]
    let flag: String
    let cioc: String
}

struct Currency: Codable {
    let code: String
    let name: String
    let symbol: String
}

