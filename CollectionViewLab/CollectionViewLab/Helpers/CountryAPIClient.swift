//
//  CountryAPIClient.swift
//  CollectionViewLab
//
//  Created by Radharani Ribas-Valongo on 9/26/19.
//  Copyright © 2019 Radharani Ribas-Valongo. All rights reserved.
//

import Foundation

class PodcastAPIClient {
    private init() {}
    static let shared = PodcastAPIClient()
    
    func getCountry(searchWord: String,completionHandler: @escaping (Result<[Country],AppError>) -> Void ) {
        let urlStr = "https://restcountries.eu/rest/v2/name/united"
        
        guard let url = URL(string: urlStr) else {
            completionHandler(.failure(.badUrl))
            return
        }
        
        NetworkHelper.shared.fetchData(withUrl: url, andMethod: .get) { (result) in
            switch result {
            case .failure(let appError):
                completionHandler(.failure(appError))
            case .success(let data):
                do {
                    let data = try JSONDecoder().decode([Country].self, from: data)
                    completionHandler(.success(data))
                } catch {
                    completionHandler(.failure(.badJSONError))                }
            }
        }
    }
}
