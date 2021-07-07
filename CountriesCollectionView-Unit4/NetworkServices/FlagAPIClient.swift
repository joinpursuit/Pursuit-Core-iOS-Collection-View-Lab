//
//  FlagAPIClient.swift
//  CountriesCollectionView-Unit4
//
//  Created by Liubov Kaper  on 1/14/20.
//  Copyright © 2020 Luba Kaper. All rights reserved.
//

import UIKit

struct ImageAPIClient {
    static func getImageURL(for imageURL: URL, competion: @escaping (Result<UIImage?, Error>) ->()) {
        
        
           let request = URLRequest(url: imageURL)
            NetworkHelper.shared.performDataTask(with: request) { (result) in
                switch result {
                case .failure(let appError):
                    competion(.failure(appError))
                case .success(let data):
                    let image = UIImage(data: data)
                    competion(.success(image))
                }
            }
    
    
        }
}
