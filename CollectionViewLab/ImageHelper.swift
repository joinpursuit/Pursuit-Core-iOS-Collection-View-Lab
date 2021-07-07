//
//  ImageHelper.swift
//  CollectionViewLab
//
//  Created by Radharani Ribas-Valongo on 9/26/19.
//  Copyright © 2019 Radharani Ribas-Valongo. All rights reserved.
//

import Foundation
import UIKit

class ImageHelper {
    private init() {}
    
    // MARK: - Static Properties
    static let shared = ImageHelper()
    
    // MARK: - Internal Methods
    func getImage(urlStr: String, completionHandler: @escaping (Result<UIImage,AppError>) -> ()) {
        
        guard let url = URL(string: urlStr) else {
            completionHandler(.failure(.badUrl))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard error == nil else {
                completionHandler(.failure(.noDataError))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(.noDataError))
                return
            }
            
            guard let image = UIImage(data: data) else {
                completionHandler(.failure(.badImageData))
                return
            }
            
            completionHandler(.success(image))
            
        } .resume()
    }
}
