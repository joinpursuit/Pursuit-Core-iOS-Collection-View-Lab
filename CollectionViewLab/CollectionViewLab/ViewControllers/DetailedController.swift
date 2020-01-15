//
//  DetailedController.swift
//  CollectionViewLab
//
//  Created by Cameron Rivera on 1/14/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import UIKit

class DetailedController: UIViewController {

    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var capitalLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    
    var currentCountry: Country?
    var location: Location?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }

    private func setUp() {
        guard let curCountry = currentCountry else {
            showAlert("Unwrapping Error", "Encountered a value of nil when attempting to unwrap currentCountry")
            return
        }
        
        navigationItem.title = curCountry.name
        capitalLabel.text = "Capital: \(curCountry.capital)"
        populationLabel.text = "Population: \(curCountry.population)"
        currencyLabel.text = "Currency: \(curCountry.currencies.first?.name ?? "n/a")"
        
        flagImageView.getImage(CountryAPIClient.getFlagURL(curCountry.alpha2Code)) { [weak self] result in
            switch result{
            case .failure(let netError):
                DispatchQueue.main.async{
                    self?.showAlert("Image Error", "Encountered error while attempting to load flag: \(netError)")
                }
            case .success(let image):
                DispatchQueue.main.async{
                    self?.flagImageView.image = image
                }
            }
        }
        if let loc = location {
            WeatherAPIClient.getWeather(WeatherAPIClient.getWeather(using: loc.woeid)) { [weak self] result in
                switch result {
                case .failure(let netError):
                    DispatchQueue.main.async{
                        self?.showAlert("Weather Error", "Could not load weather for a given location: \(netError)")
                    }
                case .success(let weather):
                    DispatchQueue.main.async{
                        self?.weatherLabel.text = "Current weather in the region: \(weather.first?.currentWeather ?? "N/A")"
                    }
                }
            }
        }
    }
    
}
