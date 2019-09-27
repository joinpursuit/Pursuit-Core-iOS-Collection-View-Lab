//
//  DetailViewController.swift
//  Collection View Lab
//
//  Created by Jason Ruan on 9/26/19.
//  Copyright © 2019 Jason Ruan. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    //MARK: Properties
    var country: Country!
    var flagImage: UIImage!
    var exchangeRateBaseEuro: ExchangeRate?
    
    //MARK: IBOutlets
    @IBOutlet weak var detailFlagImageView: UIImageView!
    @IBOutlet weak var detailCountryNameLabel: UILabel!
    @IBOutlet weak var detailCapitalLabel: UILabel!
    @IBOutlet weak var detailPopulationLabel: UILabel!
    @IBOutlet weak var detailExchangeRateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    private func setUpViews() {
        detailFlagImageView.image = flagImage
        detailCountryNameLabel.text = "Country: \(country.name)"
        detailCapitalLabel.text = "Capital: \(country.capital)"
        detailPopulationLabel.text = "Population: \(country.population.description)"
        
        DispatchQueue.main.async {
            CountryAPIClient.manager.getFlagImage(countryCode: self.country.countryCode) { (result) in
                switch result {
                case .failure(let error):
                    print("Could not get image: \(error)")
                case .success(let flagImage):
                    DispatchQueue.main.async {
                        self.detailFlagImageView.image = flagImage
                    }
                }
            }
        }
        
//        DispatchQueue.main.async {
//            guard let countryCurrencyCode = self.country.currencies[0].code else { return }
//            ExchangeRateAPIClient.manager.getExchangeRate(countryCurrency: countryCurrencyCode) { (result) in
//                switch result {
//                case .failure(let error):
//                    print(error)
//                case .success(let exchangeRateInfo):
//
//                    self.detailExchangeRateLabel.text = exchangeRateInfo
//                }
//            }
//        }
    }
    
}
