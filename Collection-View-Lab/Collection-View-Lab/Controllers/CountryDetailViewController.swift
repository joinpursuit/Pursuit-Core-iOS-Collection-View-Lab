//
//  CountryDetailViewController.swift
//  Collection-View-Lab
//
//  Created by Sunni Tang on 9/26/19.
//  Copyright © 2019 Sunni Tang. All rights reserved.
//

import UIKit

class CountryDetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var capitalLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var exchangeRateLabel: UILabel!
    
    var country: Country!
    var rates: ExchangeRates!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLabels()
    }

    override func viewWillAppear(_ animated: Bool) {
        loadExchangeRates()
        loadImage()
    }
    
    private func configureLabels() {
        nameLabel.text = country.name
        capitalLabel.text = country.capital
        populationLabel.text = "\(country.population)"
    }
    
    private func loadImage() {
        ImageHelper.manager.getImage(urlStr: CountryAPIClient.getFlagImageURLStr(from: country.code)) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure (let error):
                    print(error)
                case .success (let imageFromOnline):
                    self.imageView.image = imageFromOnline
                }
            }
        }
    }

    private func loadExchangeRates() {
        ExchangeRatesAPIClient.manager.getRates { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let ratesFromOnline):
                    self.rates = ratesFromOnline
                    print(ratesFromOnline)
                    print(self.rates.rates["GBP"])
                    print(self.country.currencies[0])
                    let rateCode = self.country.currencies[0].code
                    if let exchangeRate = self.rates.rates[rateCode] {
                        self.exchangeRateLabel.text = "\(exchangeRate)"
                    }
                    
                }
            }
        }
        
    }
    
}
