//
//  CountriesAPIClient.swift
//  Pursuit-Core-iOS-Collection-View-Lab
//
//  Created by Bienbenido Angeles on 1/14/20.
//  Copyright © 2020 Bienbenido Angeles. All rights reserved.
//

import Foundation
import  NetworkHelper

struct CountryListAPI{
    static func getListOfCountries(completion: @escaping (Result<[CountryList],AppError>)->()){
        let endPointURLString = "https://restcountries.eu/rest/v2/name/united"
        
        guard let url = URL(string: endPointURLString) else {
            completion(.failure(.badURL(endPointURLString)))
            return
        }
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result{
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do{
                    let countryList = try JSONDecoder().decode([CountryList].self, from: data)
                    completion(.success(countryList))
                } catch{
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
