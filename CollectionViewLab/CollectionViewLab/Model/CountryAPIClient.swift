//
//  CountryAPIClient.swift
//  CollectionViewLab
//
//  Created by Cameron Rivera on 1/14/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import Foundation

struct CountryAPIClient{
    static func getCountries(_ urlString: String, completion: @escaping (Result<[Country],NetworkError>) -> ()){
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.badURL(urlString)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(request) { result in
            switch result {
            case .failure(let netError):
                completion(.failure(.networkClientError(netError)))
            case .success(let data):
                do{
                    let countries = try JSONDecoder().decode([Country].self, from: data)
                    completion(.success(countries))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
    
    static func getCountryURL(_ country: String) -> String {
        return "https://restcountries.eu/rest/v2/name/\(country)"
    }
    
    static func getFlagURL(_ countryCode: String) -> String {
        return "https://www.countryflags.io/\(countryCode)/flat/64.png"
    }
}
