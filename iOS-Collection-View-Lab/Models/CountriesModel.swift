//
//  CountriesModel.swift
//  iOS-Collection-View-Lab
//
//  Created by Krystal Campbell on 10/2/19.
//  Copyright © 2019 Krystal Campbell. All rights reserved.
//

import Foundation

struct Countries: Codable{
    let name: String
    let alpha2Code: String
    let capital: String
    let population: Int
}
