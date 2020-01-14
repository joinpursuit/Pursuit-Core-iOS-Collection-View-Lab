//
//  Country.swift
//  CollectionViewLab
//
//  Created by Cameron Rivera on 1/14/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import Foundation

struct Country: Decodable{
    let name: String
    let alpha2Code: String
    let capital: String
    let region: String
    let population: Int
}
