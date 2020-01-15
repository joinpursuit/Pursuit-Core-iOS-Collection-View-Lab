//
//  WeatherAPI.swift
//  CollectionViewLab
//
//  Created by Cameron Rivera on 1/14/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import Foundation

struct WeatherAPIClient{
    
    static func getLocations(_ urlString: String, completion: @escaping (Result<[Location],NetworkError>) -> ()){
        
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
                do{
                    let locations = try JSONDecoder().decode([Location].self, from: data)
                    completion(.success(locations))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
    
    static func getWeather(_ urlString: String, completion: @escaping (Result<[Weather],NetworkError>) -> ()){
        
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
                do{
                    let weeklyWeather = try JSONDecoder().decode(WeatherWrapper.self, from: data)
                    completion(.success(weeklyWeather.consolidatedWeather))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
    
    static func getLocationURL(_ lat: Double, _ long: Double) -> String {
        return "https://www.metaweather.com/api/location/search/?lattlong=\(lat),\(long)"
    }
    
    static func getWeather(using woeid: Int) -> String {
        return "https://www.metaweather.com/api/location/\(woeid)/"
    }
}
