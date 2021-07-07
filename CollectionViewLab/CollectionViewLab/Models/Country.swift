//
//  Country.swift
//  CollectionViewLab
//
//  Created by Radharani Ribas-Valongo on 9/26/19.
//  Copyright © 2019 Radharani Ribas-Valongo. All rights reserved.
//

import Foundation

struct Country: Codable {
    let name: String
    let capital: String
    let population: Int
    let currencies: [Currency]
    let languages: [Language]
    let flag: String
}

struct Currency: Codable {
    let code, name, symbol: String
}

struct Language: Codable {
    let iso6391, iso6392, name, nativeName: String
    
    enum CodingKeys: String, CodingKey {
        case iso6391 = "iso639_1"
        case iso6392 = "iso639_2"
        case name, nativeName
    }
}

struct Translations: Codable {
    let de, es, fr, ja: String
    let it, br, pt, nl: String
    let hr, fa: String
}
