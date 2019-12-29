//
//  CountryCollectionViewCell.swift
//  CollectionViewLab
//
//  Created by Ahad Islam on 12/29/19.
//  Copyright © 2019 Ahad Islam. All rights reserved.
//

import UIKit

class CountryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var capitalLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    
    public func configureCell(country: Country) {
        nameLabel.text = country.name
        capitalLabel.text = country.capital
        populationLabel.text = String(country.population)
        
        let url = "https://www.countryflags.io/\(country.alpha2Code.lowercased())/shiny/64.png"
        
        imageView.getImage(with: url) { result in
            switch result {
            case.failure(let error):
                print("Error getting image: \(error)")
            case .success(let imageFromAPI):
                DispatchQueue.main.async {
                    self.imageView.image = imageFromAPI
                }
            }
        }
    }
    
    override func prepareForReuse() {
        imageView.image = nil
    }
}
