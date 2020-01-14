//
//  CountryModel.swift
//  CountriesCollectionView-Unit4
//
//  Created by Liubov Kaper  on 1/14/20.
//  Copyright © 2020 Luba Kaper. All rights reserved.
//

import Foundation

struct Country: Decodable {
   let name: String
   let capital: String
   let population: Int
   let alpha2Code: String
}
