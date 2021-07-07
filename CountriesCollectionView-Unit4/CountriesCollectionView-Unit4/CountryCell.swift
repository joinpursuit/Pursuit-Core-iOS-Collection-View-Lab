//
//  CountryCell.swift
//  CountriesCollectionView-Unit4
//
//  Created by Liubov Kaper  on 1/14/20.
//  Copyright © 2020 Luba Kaper. All rights reserved.
//

import UIKit

class CountryCell: UICollectionViewCell {
    
    @IBOutlet weak var flagImage: UIImageView!
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    @IBOutlet weak var capitalLabel: UILabel!
    
    
    @IBOutlet weak var populationLabel: UILabel!
    
    
    public func configureCell(for country: Country) {
        nameLabel.text = country.name
        capitalLabel.text = "Capital: \(country.capital)"
        populationLabel.text = "population: \(country.population.description)"
        let imageURL = "https://www.countryflags.io/\(country.alpha2Code)/flat/64.png"
        
        guard let url = URL(string: imageURL) else {
            fatalError("error")
        }
        ImageAPIClient.getImageURL(for: url) { (result) in
            switch result {
            case .failure(let appError):
                print("error: \(appError)")
            case .success(let image):
                DispatchQueue.main.async {
                    self.flagImage.image = image
                }
            }
        }
        
    }
}
