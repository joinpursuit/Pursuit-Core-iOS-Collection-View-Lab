//
//  CountryCell.swift
//  CollectionViewLab
//
//  Created by Cameron Rivera on 1/14/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import UIKit

class CountryCell: UICollectionViewCell {
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var countryCapitalLabel: UILabel!
    @IBOutlet weak var countryPopulationLabel: UILabel!
    
    var flagImageURL = ""
    
    override func prepareForReuse() {
        super.prepareForReuse()
        flagImageView.image = nil
    }
    
    func setUpCell(_ country: Country){
        flagImageURL = CountryAPIClient.getFlagURL(country.alpha2Code)
        countryNameLabel.text = "\(country.name)"
        countryCapitalLabel.text = "Captial: \(country.capital)"
        countryPopulationLabel.text = "Population: \(country.population)"
        
        flagImageView.getImage(CountryAPIClient.getFlagURL(country.alpha2Code)) { [weak self] result in
            switch result{
            case .failure:
                DispatchQueue.main.async{
                    self?.flagImageView.image = UIImage(systemName: "")
                }
            case .success(let image):
                DispatchQueue.main.async{
                    if CountryAPIClient.getFlagURL(country.alpha2Code) == self?.flagImageURL{
                        self?.flagImageView.image = image
                    }
                }
            }
        }
    }
}
