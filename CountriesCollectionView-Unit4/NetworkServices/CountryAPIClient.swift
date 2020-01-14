//
//  CountryAPIClient.swift
//  CountriesCollectionView-Unit4
//
//  Created by Liubov Kaper  on 1/14/20.
//  Copyright © 2020 Luba Kaper. All rights reserved.
//

import Foundation

struct CountryAPIClient {
    static func getCountry(for searchQuery: String, completion: @escaping (Result<[Country], AppError>) ->()){
        let searchQuery = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "tacos"
        let countryEndpointURL = "https://restcountries.eu/rest/v2/name/\(searchQuery)"
        
        guard let url = URL(string: countryEndpointURL) else {
            completion(.failure(.badURL(countryEndpointURL)))
            return
        }
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let countries = try JSONDecoder().decode([Country].self, from: data)
                    completion(.success(countries))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
