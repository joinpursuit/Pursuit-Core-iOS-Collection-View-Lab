//
//  UIImageView+Extensions.swift
//  CollectionViewLab
//
//  Created by Cameron Rivera on 1/14/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import UIKit

extension UIImageView{
    func getImage(_ urlString: String, completion: @escaping (Result<UIImage,NetworkError>) -> ()){
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.badURL(urlString)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(request) { result in
            switch result{
            case .failure(let netError):
                completion(.failure(.networkClientError(netError)))
            case .success(let data):
                if let image = UIImage(data: data){
                    completion(.success(image))
                }
            }
        }
    }
}
