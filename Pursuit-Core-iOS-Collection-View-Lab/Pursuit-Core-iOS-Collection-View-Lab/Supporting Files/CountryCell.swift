//
//  CountryCell.swift
//  Pursuit-Core-iOS-Collection-View-Lab
//
//  Created by Bienbenido Angeles on 1/15/20.
//  Copyright © 2020 Bienbenido Angeles. All rights reserved.
//

import UIKit
import ImageKit

class CountryCell: UICollectionViewCell {
    
    @IBOutlet weak var countryFlagImageView: UIImageView!
    @IBOutlet weak var countryNamCapPopLabel: UILabel!
    
    func configureCell(with imageURLString: String, country: CountryList){
        countryFlagImageView.getImage(with: imageURLString) {[weak self] (result) in
            switch result{
            case .failure:
                DispatchQueue.main.async {
                    self?.countryFlagImageView.image = UIImage(named: "exclaimationmark-triangle")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.countryFlagImageView.image = image
                }
            }
        }
        countryNamCapPopLabel.text = "Name: \(country.name) \nCapital: \(country.capital), Location: \(country.subregion), \(country.region)\nPopulation: \(country.population)"
    }
    
}
