//
//  CountryModel.swift
//  Pursuit-Core-iOS-Collection-View-Lab
//
//  Created by Bienbenido Angeles on 1/14/20.
//  Copyright © 2020 Bienbenido Angeles. All rights reserved.
//

import Foundation

struct CountryList: Decodable {
    var name: String
    var alpha2Code: String
    var capital: String
    var subregion: String
    var region: String
    var population: Int
    var currencies: [Currencies]
}

struct Currencies:Decodable {
    var code: String?
    var name: String?
    var symbol: String?
}
