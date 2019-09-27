//
//  NetworkHelper.swift
//  CollectionViewLab
//
//  Created by Radharani Ribas-Valongo on 9/26/19.
//  Copyright © 2019 Radharani Ribas-Valongo. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

class NetworkHelper {
    
    private init() {}
    
    /// singleton
    static let shared = NetworkHelper()
    
    func fetchData(withUrl url: URL, andHTTPBody body: Data? = nil, andMethod httpMethod: HTTPMethod,  completionHandler: @escaping (Result<Data,AppError>) -> ()) {
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.httpBody = body
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                completionHandler(.failure(.networkError))
                return
            }
                
            guard let data = data else {
                completionHandler(.failure(.noDataError))
                return
            }
                
            guard let response = response as? HTTPURLResponse else {
                completionHandler(.failure(.badHTTPResponse))
                return
            }
                
            switch response.statusCode {
            case 404:
                completionHandler(.failure(.notFound))
            case 401,403:
                completionHandler(.failure(.unauthorized))
            case 200...299:
                completionHandler(.success(data))
            default:
                completionHandler(.failure(.other(errorDescription: "Wrong Status Code")))
            }
        }.resume()
    }
}

