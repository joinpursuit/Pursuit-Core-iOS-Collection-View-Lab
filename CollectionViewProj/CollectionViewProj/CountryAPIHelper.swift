//
//  CountryAPIHelper.swift
//  CollectionViewProj
//
//  Created by Kevin Natera on 9/26/19.
//  Copyright © 2019 Kevin Natera. All rights reserved.
//

import Foundation
import UIKit

class CountryAPIHelper {
   private init() {}
   
   static let shared = CountryAPIHelper()

   func getCountries(completionHandler: @escaping (Result<[Country],ErrorHandling>) -> () ) {
    let urlStr = "https://restcountries.eu/rest/v2/"

    NetworkHelper.shared.getData(urlString: urlStr) { (result) in
        switch result {
        case .failure(let error):
            print(error)
        case .success(let data):
            do {
                let countryInfo = try JSONDecoder().decode([Country].self, from: data)
                completionHandler(.success(countryInfo))
            } catch {
                completionHandler(.failure(.decodingError))
            }
       }
   }
 }
}
