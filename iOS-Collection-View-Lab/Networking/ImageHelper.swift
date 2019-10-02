//
//  ImageHelper.swift
//  iOS-Collection-View-Lab
//
//  Created by Krystal Campbell on 10/2/19.
//  Copyright © 2019 Krystal Campbell. All rights reserved.
//

import Foundation
import UIKit

class ImageHelper {
    
    // MARK: - Static Properties
    
    static let shared = ImageHelper()
    
    // MARK: - Instance Methods
    
    func getImage(alphaCode: String, completionHandler: @escaping (Result<UIImage, AppError>) -> ()) {
        
        let imageURL = "https://www.countryflags.io/\(alphaCode)/flat/64.png"
        
        guard let url = URL(string: imageURL) else {
            completionHandler(.failure(.badURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard error == nil else {
                completionHandler(.failure(.badURL))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(.noDataReceived))
                return
            }
            
            guard let image = UIImage(data: data) else {
                completionHandler(.failure(.notAnImage))
                return
            }
            
            completionHandler(.success(image))
            }.resume()
    }
    
    // MARK: - Private Properties and Initializers
    
    private init() {}
}


