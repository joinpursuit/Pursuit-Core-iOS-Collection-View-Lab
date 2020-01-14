//
//  NetworkError.swift
//  CollectionViewLab
//
//  Created by Cameron Rivera on 1/14/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import Foundation

enum NetworkError: Error{
    case badURL(String)
    case networkClientError(Error)
    case badStatusCode(Int)
    case decodingError(Error)
    case encodingError(Error)
    case noResponse
    case badData
}
