//
//  CountryCollectionViewCell.swift
//  CollectionViewProj
//
//  Created by Kevin Natera on 9/26/19.
//  Copyright © 2019 Kevin Natera. All rights reserved.
//

import UIKit

class CountryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var countryFlagOutlet: UIImageView!
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var countryCapitalLabel: UILabel!
    @IBOutlet weak var countryPopulationLabel: UILabel!
    
    func configureCell(with country: Country) {
        countryNameLabel.text = country.name
        countryCapitalLabel.text = country.capital
        countryPopulationLabel.text = "Pop: \(country.population)"
        
        let urlStr = "https://www.countryflags.io/\(country.alpha2Code.lowercased())/shiny/64.png"
        ImageHelper.shared.getImage(urlStr: urlStr) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let image):
                    self.countryFlagOutlet.image = image
                }
            }
        }
    }
}
